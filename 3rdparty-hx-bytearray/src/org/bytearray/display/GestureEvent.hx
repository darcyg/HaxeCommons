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

import flash.events.Event;

class GestureEvent extends Event {

    // ------------------------------------------------
        //
        // ---o static
        //
        // ------------------------------------------------
        static public inline var START_CAPTURE : String = "startCapture";
    static public inline var STOP_CAPTURE : String = "stopCapture";
    static public inline var CAPTURING : String = "capturing";
    static public inline var GESTURE_MATCH : String = "gestureMatch";
    static public inline var NO_MATCH : String = "noMatch";
    // ------------------------------------------------
        //
        // ---o properties
        //
        // ------------------------------------------------
        public var datas : Dynamic;
    public var fiability : Int;
    // ------------------------------------------------
        //
        // ---o constructor
        //
        // ------------------------------------------------
        public function new(type : String, bubbles : Bool = false, cancelable : Bool = false) {
        super(type, bubbles, cancelable);
    }

    // ------------------------------------------------
        //
        // ---o methods
        //
        // ------------------------------------------------
        override public function clone() : Event {
        return try cast(new GestureEvent(type, bubbles, cancelable), Event) catch(e:Dynamic) null;
    }

}

