////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012-2013, Original author & contributors
// Original author : www.nocircleno.com/graffiti/
// Contributors: Andras Csizmadia <andras@vpmedia.eu>
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
package com.nocircleno.graffiti.events;
import flash.events.Event;
import flash.geom.Rectangle;
/**
* The Canvas Event provides a custom Event for Canvas events.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class CanvasEvent extends Event {
    public var zoom(get, never) : Float;
    public var canvasWidth(get, never) : Int;
    public var canvasHeight(get, never) : Int;
    public var viewableRect(get, never) : Rectangle;
    /**
    * Dispatched when the canvas zoom value changes.
    *
    * @eventType com.nocircleno.graffiti.events.CanvasEvent.ZOOM
    */    
    static public inline var ZOOM : String = "zoom";
    /**
    * Dispatched when the canvas position is changed.
    *
    * @eventType com.nocircleno.graffiti.events.CanvasEvent.DRAG
    */    
    static public inline var DRAG : String = "drag";
    var _canvasZoom : Float;
    var _canvasWidth : Int;
    var _canvasHeight : Int;
    var _viewableRect : Rectangle;
    /**
    * The <code>CanvasEvent</code> constructor.
    * 
    * @param type Type of Canvas Event.
    * @param zoom Zoom of the Canvas instance that dispatched the event.
    * @param canvasWidth Width of the Canvas instance that dispatched the event.
    * @param canvasHeight Height of the Canvas instance that dispatched the event.
    * @param viewableRect Viewable Rectangle of the Canvas instance that dispatched the event.
    * @param bubbles Does the event bubble.
    * @param cancelable Is the Event cancelable.
    * 
    */    
    public function new(type : String, zoom : Float, canvasWidth : Int, canvasHeight : Int, viewableRect : Rectangle, bubbles : Bool = false, cancelable : Bool = false) {
        super(type, bubbles, cancelable);
        // store canvas properties
        _canvasZoom = zoom;
        _canvasWidth = canvasWidth;
        _canvasHeight = canvasHeight;
        _viewableRect = viewableRect;
    }
    /**
    * Canvas Zoom value.
    */    
    public function get_zoom() : Float {
        return _canvasZoom;
    }
    /**
    * Canvas Width.
    */    
    public function get_canvasWidth() : Int {
        return _canvasWidth;
    }
    /**
    * Canvas Height
    */    
    public function get_canvasHeight() : Int {
        return _canvasHeight;
    }
    /**
    * Viewable Rectangle of the Canvas.
    */    
    public function get_viewableRect() : Rectangle {
        return _viewableRect;
    }
}