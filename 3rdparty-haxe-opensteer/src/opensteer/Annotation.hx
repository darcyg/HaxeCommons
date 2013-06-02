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
package opensteer;
/**
     *  This class adds OpenSteerDemo-based graphical annotation functionality to a
     *  given base class, which is typically something that supports the AbstractVehicle interface.
     *  @author Mohammad Haseeb
     */
     class Annotation implements IAnnotationService {
    public var IsEnabled(get, set) : Bool;
    var trails : Array<Trail>;
    var isenabled : Bool;
    //PV3D Render Variables
        //public var LineList:Lines3D;
        //public var LineTexture:LineMaterial;
        /**
         * constructor
         */    public function new() {
        isenabled = false;
        trails = new Array<Trail>();
    }
    /**
         * Indicates whether annotation is enabled.
         * @return Boolean
         */    
         public function getIsEnabled() : Bool {
        return isenabled;
    }
    public function setIsEnabled(val : Bool) : Bool {
        isenabled = val;
        return val;
    }
    public function Redraw() : Void {
    }
    /**
         * @inheritDoc
         *
         */    
         public function AddTrail(trail : Trail) : Void {
        trails.push(trail);
    }
    /** Removes the specified Trail.
         * @inheritDoc
        * @param trail The trail to remove
        */    
        public function RemoveTrail(trail : Trail) : Void {
        trails.splice(Lambda.indexOf(trails,trail), 1);
    }
    /** Draws all registered Trails.
         * @inheritDoc
         */    
         public function DrawAllTrails() : Void {
    }
    /**
         * Draw the given registered Trail
         */    
         public function DrawTrail(trail : Trail) : Void {
    }
    /** Clears all registered Trails.
         *
         */    
         public function ClearAllTrails() : Void {
    }
    /** Clear a registered Trail.
         *
         */    
         
         public function ClearTrail(trail : Trail) : Void {
        trail.Clear();
    }
    /** ------------------------------------------------------------------------
        * drawing of lines, circles and (filled) disks to annotate steering
        * behaviors.  When called during OpenSteerDemo's simulation update phase,
        * these functions call a "deferred draw" routine which buffer the
        * arguments for use during the redraw phase.
        *
        * note: "circle" means unfilled
        *       "disk" means filled
        *       "XZ" means on a plane parallel to the X and Z axes (perp to Y)
        *       "3d" means the circle is perpendicular to the given "axis"
        *       "segments" is the number of line segments used to draw the circle
        */    /**  Draw an opaque colored line segment between two locations in space
         * @param startPoint A 3D point in space to start the line
         * <p/>
         * @param endPoint A 3D point in space where the line ends
         * <p/>
         * @param color An unsigned integer for the color of the object
         */    
         public function Line(startPoint : Vector3, endPoint : Vector3, color : Int) : Void {
    }
    /**  Draw a circle on the XZ plane
         * @param radius The size of the Circle
         * <p/>
         * @param center A 3D point in space where the line ends
         * <p/>
         * @param color An unsigned integer for the color of the object
         * <p/>
         * @param segments An integer or the number of line segments used to draw the circle
         */    
         public function CircleXZ(radius : Float, center : Vector3, color : Int, segments : Int) : Void {
        CircleOrDiskXZ(radius, center, color, segments, false);
    }
    /**  Draw a disk on the XZ plane
         * @param radius The size of the disk
         * <p/>
         * @param center A 3D point in space where the line ends
         * <p/>
         * @param color An unsigned integer for the color of the object
         * <p/>
         * @param segments An integer or the number of line segments used to draw the disk
         */    
         public function DiskXZ(radius : Float, center : Vector3, color : Int, segments : Int) : Void {
        CircleOrDiskXZ(radius, center, color, segments, true);
    }
    /**  Draw a circle perpendicular to the given axis
         * @param radius The size of the circle
         * <p/>
         * @param center A 3D point in space where the line ends
         * <p/>
         * @param axis A 3D point in space to tell the axis of the Circle
         * <p/>
         * @param color An unsigned integer for the color of the object
         * <p/>
         * @param segments An integer or the number of line segments used to draw the circle
         */    
         public function Circle3D(radius : Float, center : Vector3, axis : Vector3, color : Int, segments : Int) : Void {
        CircleOrDisk3D(radius, center, axis, color, segments, false);
    }
    /**  Draw a disk perpendicular to the given axis
         * @param radius The size of the disk
         * <p/>
         * @param center A 3D point in space where the line ends
         * <p/>
         * @param axis A 3D point in space to tell the axis of the Circle
         * <p/>
         * @param color An unsigned integer for the color of the object
         * <p/>
         * @param segments An integer or the number of line segments used to draw the disk
         */    
         public function Disk3D(radius : Float, center : Vector3, axis : Vector3, color : Int, segments : Int) : Void {
        CircleOrDisk3D(radius, center, axis, color, segments, true);
    }
    /** Support for annotation circles
        */    
        public function CircleOrDiskXZ(radius : Float, center : Vector3, color : Int, segments : Int, filled : Bool) : Void {
        CircleOrDisk(radius, Vector3.Zero, center, color, segments, filled, false);
    }
    /** Support for annotation circles
        */    
        public function CircleOrDisk3D(radius : Float, center : Vector3, axis : Vector3, color : Int, segments : Int, filled : Bool) : Void {
        CircleOrDisk(radius, axis, center, color, segments, filled, true);
    }
    /** Support for annotation circles
        */    
        public function CircleOrDisk(radius : Float, axis : Vector3, center : Vector3, color : Int, segments : Int, filled : Bool, in3d : Bool) : Void {
    }
    /** Called when steerToAvoidObstacles decides steering is required
        * (default action is to do nothing, layered classes can overload it)
        */    
        public function AvoidObstacle(vehicle : IVehicle, minDistanceToCollision : Float) : Void {
        var boxSide : Vector3 = Vector3.ScalarMultiplication(vehicle.Radius, vehicle.Side);
        var boxFront : Vector3 = Vector3.ScalarMultiplication(minDistanceToCollision, vehicle.Forward);
        var FR : Vector3 = Vector3.VectorAddition(vehicle.Position, Vector3.VectorSubtraction(boxFront, boxSide));
        var FL : Vector3 = Vector3.VectorAddition(vehicle.Position, Vector3.VectorAddition(boxFront, boxSide));
        var BR : Vector3 = Vector3.VectorSubtraction(vehicle.Position, boxSide);
        var BL : Vector3 = Vector3.VectorAddition(vehicle.Position, boxSide);
        Line(FR, FL, Colors.White);
        Line(FL, BL, Colors.White);
        Line(BL, BR, Colors.White);
        Line(BR, FR, Colors.White);
    }
    /** called when steerToFollowPath decides steering is required
        * (default action is to do nothing, layered classes can overload it)
        */    
        public function PathFollowing(future : Vector3, onPath : Vector3, target : Vector3, outside : Float) : Void {
    }
    /** called when steerToAvoidCloseNeighbors decides steering is required
        * (default action is to do nothing, layered classes can overload it)
        */    
        public function AvoidCloseNeighbor(other : IVehicle, additionalDistance : Float) : Void {
    }
    /** called when steerToAvoidNeighbors decides steering is required
        * (default action is to do nothing, layered classes can overload it)
        */    
        public function AvoidNeighbor(threat : IVehicle, steer : Float, ourFuture : Vector3, threatFuture : Vector3) : Void {
    }
    /** Caller Function
         */    
         public function VelocityAcceleration(vehicle : IVehicle) : Void {
        VelocityAcceleration3(vehicle, 3, 3);
    }
    /** Caller Function
         */    
         public function VelocityAcceleration2(vehicle : IVehicle, maxLength : Float) : Void {
        VelocityAcceleration3(vehicle, maxLength, maxLength);
    }
    /**
         * @param vehicle An IVehicle Object
         * <p/>
         * @param maxLengthAcceleration A number to tell the maximum scale of acceleration
         * <p/>
         * @param maxLengthVelocity A Number to tell the maximum scale of Velocity
         */    
         public function VelocityAcceleration3(vehicle : IVehicle, maxLengthAcceleration : Float, maxLengthVelocity : Float) : Void {
        var desat : Int = 102;
        var vColor : Int = Colors.RGBToHex(255, desat, 255);
        // pinkish
        var aColor : Int = Colors.RGBToHex(desat, desat, 255);
        // bluish
        var aScale : Float = maxLengthAcceleration / vehicle.MaxForce;
        var vScale : Float = maxLengthVelocity / vehicle.MaxSpeed;
        var p : Vector3 = vehicle.Position;
        Line(p, Vector3.VectorAddition(p, Vector3.ScalarMultiplication(vScale, vehicle.Velocity)), vColor);
        Line(p, Vector3.VectorAddition(p, Vector3.ScalarMultiplication(aScale, vehicle.Acceleration)), aColor);
    }
}