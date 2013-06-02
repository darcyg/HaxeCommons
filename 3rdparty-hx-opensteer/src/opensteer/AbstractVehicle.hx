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
 * Base class for generic steerable vehicles
 * @author Mohammad Haseeb
 */class AbstractVehicle extends LocalSpace implements IVehicle {
    public var Mass(get, set) : Float;
    public var Radius(get, set) : Float;
    public var Velocity(get, never) : Vector3;
    public var Acceleration(get, never) : Vector3;
    public var Speed(get, set) : Float;
    public var MaxForce(get, set) : Float;
    public var MaxSpeed(get, set) : Float;
    public function getMass() : Float {
        return 0.0;
    }
    public function getRadius() : Float {
        return 0.0;
    }
    public function setMass(param : Float) : Float {
        return param;
    }
    public function setRadius(param : Float) : Float {
        return param;
    }
    public function getVelocity() : Vector3 {
        return new Vector3();
    }
    public function getAcceleration() : Vector3 {
        return new Vector3();
    }
    public function getSpeed() : Float {
        return 0.0;
    }
    public function setSpeed(param : Float) : Float {
        return param;
    }
    public function getMaxForce() : Float {
        return 0.0;
    }
    public function getMaxSpeed() : Float {
        return 0.0;
    }
    public function setMaxForce(param : Float) : Float {
        return param;
    }
    public function setMaxSpeed(param : Float) : Float {
        return param;
    }
    public function PredictFuturePosition(predictionTime : Float) : Vector3 {
        return new Vector3();
    }
    public function new(args:Array<Vector3>) {
    super(args);
    }
}