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
import com.nocircleno.graffiti.display.GraffitiObject;
/**
* GraffitiObjectEvent Class is used to notify of object changes.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class GraffitiObjectEvent extends Event {
    public var graffitiObject(get, never) : GraffitiObject;
    /**
    * Dispatched when an object is selected.
    *
    * @eventType com.nocircleno.graffiti.events.GraffitiObjectEvent.SELECT
    */    
    static public inline var SELECT : String = "select";
    /**
    * Dispatched when an object is deselected.
    *
    * @eventType com.nocircleno.graffiti.events.GraffitiObjectEvent.DESELECT
    */    
    static public inline var DESELECT : String = "deselect";
    /**
    * Dispatched when an object enters edit mode.
    *
    * @eventType com.nocircleno.graffiti.events.GraffitiObjectEvent.ENTER_EDIT
    */    
    static public inline var ENTER_EDIT : String = "enterEdit";
    /**
    * Dispatched when an object exits edit mode.
    *
    * @eventType com.nocircleno.graffiti.events.GraffitiObjectEvent.EXIT_EDIT
    */    
    static public inline var EXIT_EDIT : String = "exitEdit";
    /**
    * Dispatched when an object is deleted from the stage.
    *
    * @eventType com.nocircleno.graffiti.events.GraffitiObjectEvent.DELETE
    */    
    static public inline var DELETE : String = "delete";
    var _graffitiObject : GraffitiObject;
    /**
    * The <code>GraffitiObjectEvent</code> constructor.
    *
    * @param gObject Graffiti Object affected by event.
    * @param type Event type.
    * @param bubbles Does the event bubble.
    * @param cancelable Is the Event cancelable.
    */    
    public function new(gObject : GraffitiObject, type : String, bubbles : Bool = false, cancelable : Bool = false) {
        super(type, bubbles, cancelable);
        _graffitiObject = gObject;
    }
    /**
     * Graffiti Object affected by event.
     */    
     public function get_graffitiObject() : GraffitiObject {
        return _graffitiObject;
    }
    /**
    * The <code>clone</code> method will return a new instance of the ObjectEvent.
    *
    * @return Returns new ObjectEvent with all the same settings.
    */    
    override public function clone() : Event {
        return new GraffitiObjectEvent(_graffitiObject, type, bubbles, cancelable);
    }
    /**
    * The <code>toString</code> method will output the event details. 
    *
    * @return Returns the event information.
    */    
    override public function toString() : String {
        return formatToString("GraffitiObjectEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}