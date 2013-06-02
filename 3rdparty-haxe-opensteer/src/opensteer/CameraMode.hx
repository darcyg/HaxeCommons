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

// camera mode selection
class CameraMode {

    // marks beginning of list
    static public inline var StartMode : Int = 0;
    // fixed global position and aimpoint
    static public inline var Fixed : Int = 1;
    // camera position is directly above (in global Up/Y) target
    // camera up direction is target's forward direction
    static public inline var StraightDown : Int = 2;
    // look at subject vehicle, adjusting camera position to be a
    // constant distance from the subject
    static public inline var FixedDistanceOffset : Int = 3;
    // camera looks at subject vehicle from a fixed offset in the
    // local space of the vehicle (as if attached to the vehicle)
    static public inline var FixedLocalOffset : Int = 4;
    // camera looks in the vehicle's forward direction, camera
    // position has a fixed local offset from the vehicle.
    static public inline var OffsetPOV : Int = 5;
    // cmFixedPositionTracking // xxx maybe?
    // marks the end of the list for cycling (to cmStartMode+1)
    static public inline var EndMode : Int = 6;
}