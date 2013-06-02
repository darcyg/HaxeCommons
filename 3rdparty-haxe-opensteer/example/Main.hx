// ----------------------------------------------------------------------------
//
// PaperSteer - Papervision3D Port of OpenSteer
// Port by Mohammad Haseeb aka M.H.A.Q.S.
// http://www.tabinda.net
// AS3 Refactor by Andras Csizmadia <andras@vpmedia.eu> (No PV3D dependency)
// HaXe Port by Andras Csizmadia <andras@vpmedia.eu> 
//
// OpenSteer -- Steering Behaviors for Autonomous Characters
//
// Copyright (c) 2002-2003, Sony Computer Entertainment America
// Original author: Craig Reynolds <craig_reynolds@playstation.sony.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//
// ----------------------------------------------------------------------------
package;   

import flash.display.Sprite; 
import flash.events.Event; 
import flash.Lib;

import opensteer.AbstractVehicle;
import opensteer.Annotation;
import opensteer.BruteForceProximityDatabase;
import opensteer.CameraMode;
import opensteer.ClientProxy;
import opensteer.Clock;
import opensteer.Colors;
import opensteer.IAnnotationService;
import opensteer.ILocalSpace;
import opensteer.IObstacle;
import opensteer.IPlugIn;
import opensteer.IProximityDatabase;
import opensteer.ITokenForProximityDatabase;
import opensteer.IVehicle;
import opensteer.LocalSpace;
import opensteer.LQDatabase;
//import opensteer.LQProximityDatabase;
import opensteer.PathIntersection;
import opensteer.Pathway;
import opensteer.PlugIn;
import opensteer.PolylinePathway;
import opensteer.SeenFromState;
import opensteer.SimpleVehicle;
import opensteer.SphericalObstacle;
import opensteer.SteerLibrary;
import opensteer.Trail;
import opensteer.Utilities;
import opensteer.Vector3;
import opensteer.VHelper;

class OpenSteerExample extends Sprite {

    static var proximityDatabase:IProximityDatabase=new BruteForceProximityDatabase();
    var neighbors:Array<IVehicle>;    
    var vehicle:SimpleVehicle;
    var proximityToken:ITokenForProximityDatabase;
    var boundaryCondition:Int;
    var worldRadius:Float;

        
  public function new()  
  {
    super();
    worldRadius = 50;
    boundaryCondition = 0;
    neighbors = [];
    Lib.current.addChild(this);      
    
    vehicle=new SimpleVehicle([]);
    // reset the vehicle
    vehicle.Reset();
    // steering force is clipped to this magnitude
    vehicle.MaxForce=27.0;
    // velocity is clipped to this magnitude
    vehicle.MaxSpeed=9.0;
    // initial slow speed
    vehicle.Speed=vehicle.MaxSpeed * 0.3;
    vehicle.RegenerateOrthonormalBasisUF(VHelper.RandomUnitVector());
    // randomize initial position
    vehicle.Position=Vector3.ScalarMultiplication(10.0, VHelper.RandomVectorInUnitRadiusSphere());
    // notify proximity database that our position has changed
    // FIXME: SimpleVehicle::SimpleVehicle() calls reset() before proximityToken is set
    proximityToken=proximityDatabase.AllocateToken(vehicle);
    proximityToken.UpdateForNewPosition(vehicle.Position);
    
    Lib.current.addEventListener(Event.ENTER_FRAME, step);

  } 
  
   private function step(e:Event):Void
    {
        trace("onStep"+"::"+vehicle.Position);
        var td:Float = 1 / 24;
        //
        // TEST BEHAVIORS!
        //
        // steer to flock and perhaps to stay within the spherical boundary
        vehicle.ApplySteeringForce(Vector3.VectorAddition(SteerToFlock(), HandleBoundary()), td);
        vehicle.ApplySteeringForce(Vector3.VectorAddition(vehicle.SteerForWander(td), HandleBoundary()), td);
        // trace(vehicle.Position);
        // notify proximity database that our position has changed
        proximityToken.UpdateForNewPosition(vehicle.Position);
    }
    
       // basic flocking
        public function SteerToFlock():Vector3
        {
            var separationRadius:Float=5.0;
            var separationAngle:Float=-0.707;
            var separationWeight:Float=12.0;
            var alignmentRadius:Float=7.5;
            var alignmentAngle:Float=0.7;
            var alignmentWeight:Float=8.0;
            var cohesionRadius:Float=9.0;
            var cohesionAngle:Float=-0.15;
            var cohesionWeight:Float=8.0;
            var maxRadius:Float=Math.max(separationRadius, Math.max(alignmentRadius, cohesionRadius));
            // find all flockmates within maxRadius using proximity database
            neighbors.splice(0, neighbors.length);
            neighbors=proximityToken.FindNeighbors(vehicle.Position, maxRadius, neighbors);
            // determine each of the three component behaviors of flocking
            var separation:Vector3=vehicle.SteerForSeparation(separationRadius, separationAngle, neighbors);
            var alignment:Vector3=vehicle.SteerForAlignment(alignmentRadius, alignmentAngle, neighbors);
            var cohesion:Vector3=vehicle.SteerForCohesion(cohesionRadius, cohesionAngle, neighbors);
            // apply weights to components (save in variables for annotation)
            var separationW:Vector3=Vector3.ScalarMultiplication(separationWeight, separation);
            var alignmentW:Vector3=Vector3.ScalarMultiplication(alignmentWeight, alignment);
            var cohesionW:Vector3=Vector3.ScalarMultiplication(cohesionWeight, cohesion);
            return Vector3.VectorAddition(Vector3.VectorAddition(separationW, alignmentW), cohesionW);
        }

        // Take action to stay within sphereical boundary.  Returns steering
        // value (which is normally zero) and may take other side-effecting
        // actions such as kinematically changing the Boid's position.
        public function HandleBoundary():Vector3
        {
            // while inside the sphere do noting
            if (vehicle.Position.Magnitude() < worldRadius)
            {
                return Vector3.Zero;
            }
            // once outside, select strategy
            switch (boundaryCondition)
            {
                case 0:
                {
                    // steer back when outside
                    var seek:Vector3=vehicle.xxxSteerForSeek(Vector3.Zero);
                    var lateral:Vector3=VHelper.PerpendicularComponent(seek, vehicle.Forward);
                    return lateral;
                }
                case 1:
                {
                    // wrap around (teleport)
                    vehicle.Position=VHelper.SphericalWrapAround(vehicle.Position, Vector3.Zero, worldRadius);
                    return Vector3.Zero;
                }
            }
            return Vector3.Zero; // should not reach here
        }




}