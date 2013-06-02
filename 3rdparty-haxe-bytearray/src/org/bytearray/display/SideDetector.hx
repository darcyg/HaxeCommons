////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Didier Brun - www.foxaweb.com
// Contributors: 
//              Thibault Imbert - http://www.bytearray.org
//              Andras Csizmadia -  http://www.vpmedia.eu
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////
package org.bytearray.display;

import flash.geom.Point;
import flash.geom.Vector3D;
import flash.events.EventDispatcher;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Matrix3D;
import flash.geom.Orientation3D;

class SideDetector extends EventDispatcher {

    var target : DisplayObject;
    var localPoint1 : Point;
    var localPoint2 : Point;
    var localPoint3 : Point;
    var globalPoint1 : Point;
    var globalPoint2 : Point;
    var globalPoint3 : Point;
    var vector1 : Vector3D;
    var vector2 : Vector3D;
    var isFront : Bool;
    var wasFront : Bool;
    var normale : Vector3D;
    static public inline var FACE : String = "face";
    static public inline var BACKFACE : String = "backFace";
    public function new(pDisplayObject : DisplayObject) {
        super();
    target = pDisplayObject;
        localPoint1 = new Point(0, 0);
        localPoint2 = new Point(100, 0);
        localPoint3 = new Point(0, 100);
        target.addEventListener(Event.ENTER_FRAME, calculNormale);
    }

    function calculNormale(pEvt : Event) : Void {
        // Senocular trick ;)
        // http://www.senocular.com/?id=2.57
        globalPoint1 = target.localToGlobal(localPoint1);
        globalPoint2 = target.localToGlobal(localPoint2);
        globalPoint3 = target.localToGlobal(localPoint3);
        vector1 = new Vector3D(globalPoint2.x - globalPoint1.x, globalPoint2.y - globalPoint1.y);
        vector2 = new Vector3D(globalPoint3.x - globalPoint1.x, globalPoint3.y - globalPoint1.y);
        normale = vector1.crossProduct(vector2);
        isFront = normale.z > 0;
        if(isFront && !wasFront) 
            dispatchEvent(new FlippedEvent(FlippedEvent.FLIPPED, SideDetector.FACE))
        else if(wasFront && !isFront) 
            dispatchEvent(new FlippedEvent(FlippedEvent.FLIPPED, SideDetector.BACKFACE));
        wasFront = isFront;
    }

}

