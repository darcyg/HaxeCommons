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
package com.nocircleno.graffiti.display;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import com.nocircleno.graffiti.events.GraffitiObjectEvent;
/**
* GraffitiObject Class is the base class for all object used in the Graffiti Library.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class GraffitiObject extends Sprite {
    public var selected(get, set) : Bool;
    @:isVar
    public var editing(get, set) : Bool;
    /**
    * Selected Color
    */    
    static public inline var SELECTED_COLOR : Int = 0xFF0000;
    /**
    * Edit Color
    */    
    static public inline var EDIT_COLOR : Int = 0xFFCC00;
    var _selected : Bool;
    var _editing : Bool;
    public function new() {
        super();
    _selected = false;
        _editing = false;
    }
    /**
    * Selected state.
    */    
    public function set_selected(select : Bool) : Bool {
        _selected = select;
        return select;
    }
    public function get_selected() : Bool {
        return _selected;
    }
    /**
    * Edited state.
    */    
    public function set_editing(edit : Bool) : Bool {
        // only dispatch event if it is different than the current setting
        if(edit != _editing)  {
            if(edit)  {
                dispatchEvent(new GraffitiObjectEvent(this, GraffitiObjectEvent.ENTER_EDIT));
            }
            else  {
                dispatchEvent(new GraffitiObjectEvent(this, GraffitiObjectEvent.EXIT_EDIT));
            }
        }
        _editing = edit;
        return edit;
    }
    public function get_editing() : Bool {
        return _editing;
    }
}