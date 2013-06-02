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
import com.nocircleno.graffiti.events.GraffitiObjectEvent;
import com.nocircleno.graffiti.tools.TextSettings;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.AntiAliasType;
#if flash
import flash.text.GridFitType;
#end
import flash.filters.GlowFilter;
import flash.filters.BitmapFilterQuality;
/**
* Text Class displays text as a GraffitiObject on the GraffitiCanvas.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class Text extends GraffitiObject {
    public var textSetting(get, set) : TextSettings;
    public var text(get, never) : String;
    var _textfield : TextField;
    var _textSettings : TextSettings;
    var _bg : Sprite;
    /**
    * The <code>Text</code> constructor. 
    * 
    * @param textSettings TextSettings instance.
    */    
    public function new(textSettings : TextSettings) {
        super();
    // store settings
        _textSettings = textSettings;
        // create background
        _bg = new Sprite();
        _bg.alpha = 0;
        addChild(_bg);
        // create textfield
        _textfield = new TextField();
        _textfield.name = "text_label";
        _textfield.embedFonts = _textSettings.embeddedFont;
        _textfield.antiAliasType = AntiAliasType.ADVANCED;
    #if flash
        _textfield.gridFitType = GridFitType.PIXEL;
    #end
        _textfield.autoSize = TextFieldAutoSize.LEFT;
        _textfield.multiline = true;
        _textfield.wordWrap = false;
        _textfield.defaultTextFormat = _textSettings.textFormat;
        _textfield.type = TextFieldType.INPUT;
        _textfield.background = _textSettings.backgroundColor != -(1) ? true : false;
        _textfield.backgroundColor = _textSettings.backgroundColor != -(1) ? _textSettings.backgroundColor : 0xFFFFFF;
        _textfield.border = _textSettings.borderColor != -(1) ? true : false;
        _textfield.borderColor = _textSettings.borderColor != -(1) ? _textSettings.borderColor : 0xFFFFFF;
        addChild(_textfield);
        _textfield.addEventListener(Event.CHANGE, updateBackground, false, 0, true);
        _textfield.addEventListener(FocusEvent.FOCUS_OUT, focusHandler, false, 0, true);
        this.addEventListener(Event.ADDED_TO_STAGE, init);
        // enable double click to edit
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, mouseHandler, false, 0, true);
        this.addEventListener(Event.REMOVED_FROM_STAGE, removeEventHandler);
        updateBackground(null);
    }
    /**
    * Set the text settings for the Text object.
    */    
    public function set_textSetting(setting : TextSettings) : TextSettings {
        _textSettings = setting;
        _textfield.embedFonts = _textSettings.embeddedFont;
        _textfield.background = _textSettings.backgroundColor != -(1) ? true : false;
        _textfield.backgroundColor = _textSettings.backgroundColor != -(1) ? _textSettings.backgroundColor : 0xFFFFFF;
        _textfield.border = _textSettings.borderColor != -(1) ? true : false;
        _textfield.borderColor = _textSettings.borderColor != -(1) ? _textSettings.borderColor : 0xFFFFFF;
        _textfield.setTextFormat(_textSettings.textFormat);
        _textfield.defaultTextFormat = _textSettings.textFormat;
        updateBackground(null);
        return setting;
    }
    public function get_textSetting() : TextSettings {
        return _textSettings;
    }
    /**
    * Set the text displayed by the Text Object.
    */    
    public function get_text() : String {
        return _textfield.text;
    }
    /**
    * Set Text selected state.
    */    
    override public function set_selected(select : Bool) : Bool {
        _selected = select;
        if(_selected)  {
            if(!_textfield.selectable)  {
                _bg.alpha = 1;
                _bg.filters = [new GlowFilter(GraffitiObject.SELECTED_COLOR, 1, 4, 4, 2, BitmapFilterQuality.HIGH, false, true)];
            }
        }
        else  {
            _bg.alpha = 0;
            _bg.filters = [];
        }
        return select;
    }
    /**
    * Set Text edit state.
    */    
    override public function set_editing(edit : Bool) : Bool {
        editing = edit;
        _bg.mouseEnabled = edit;
        _textfield.mouseEnabled = edit;
        _textfield.selectable = edit;
        if(!_editing)  {
            if(_selected)  {
                _bg.alpha = 1;
                _bg.filters = [new GlowFilter(GraffitiObject.SELECTED_COLOR, 1, 4, 4, 2, BitmapFilterQuality.HIGH, false, true)];
            }
            else  {
                _bg.alpha = 0;
                _bg.filters = [];
            }
            stage.focus = null;
            _textfield.setSelection(0, 0);
        }
        else  {
            _bg.alpha = 1;
            _bg.filters = [new GlowFilter(GraffitiObject.EDIT_COLOR, 1, 4, 4, 2, BitmapFilterQuality.HIGH, false, true)];
            // calculate starting cursor position
            var selectedIndex : Int = _textfield.getCharIndexAtPoint(this.mouseX, this.mouseY);
            stage.focus = _textfield;
            _textfield.setSelection(selectedIndex, selectedIndex);
        }
        return edit;
    }
    /**************************************************************************
    Method    : init()
    
    Purpose    : This method will initialize the Text object.
      
    Params    : e - Event Object
    ***************************************************************************/    
    function init(e : Event) : Void {
        this.removeEventListener(Event.ADDED_TO_STAGE, init);
        selected = true;
        editing = true;
    }
    /**************************************************************************
    Method    : removeEventHandler()
    
    Purpose    : This method will remove the event listeners for this object.
      
    Params    : e - Event Object
    ***************************************************************************/    
    function removeEventHandler(e : Event) : Void {
        _textfield.removeEventListener(Event.CHANGE, updateBackground, false);
        _textfield.removeEventListener(FocusEvent.FOCUS_OUT, focusHandler, false);
        this.removeEventListener(Event.REMOVED_FROM_STAGE, removeEventHandler);
        this.removeEventListener(MouseEvent.DOUBLE_CLICK, mouseHandler, false);
    }
    /**************************************************************************
    Method    : updateBackground()
    
    Purpose    : This method will redraw the background.
      
    Params    : e - Event Object
    ***************************************************************************/    
    function updateBackground(e : Event) : Void {
        _bg.graphics.clear();
        _bg.graphics.beginFill(0xFFFFFF, 1);
        _bg.graphics.drawRect(0, 0, _textfield.width, _textfield.height);
    }
    /**************************************************************************
    Method    : updateBackground()
    
    Purpose    : This method will handle the double click event to enable
              editing.
      
    Params    : e - Event Object
    ***************************************************************************/    
    function mouseHandler(e : MouseEvent) : Void {
        if(e.type == MouseEvent.DOUBLE_CLICK && !_editing)  {
            this.editing = true;
        }
    }
    /**************************************************************************
    Method    : focusHandler()
    
    Purpose    : This method will handle when the textfield loses stage
      focus.
      
    Params    : e - FocusEvent Object
    ***************************************************************************/    
    function focusHandler(e : FocusEvent) : Void {
        if(e.type == FocusEvent.FOCUS_OUT)  {
            editing = false;
        }
    }
}