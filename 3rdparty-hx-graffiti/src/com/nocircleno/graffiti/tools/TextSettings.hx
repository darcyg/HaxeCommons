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
package com.nocircleno.graffiti.tools;
import flash.text.Font;
import flash.text.FontType;
import flash.text.TextFormat;
/**
* TextSettings Class is used to configure the look of text for the graffiti library.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class TextSettings {
    public var embeddedFont(get, never) : Bool;
    public var font(get, set) : Font;
    public var textFormat(get, set) : TextFormat;
    public var backgroundColor(get, set) : Int;
    public var borderColor(get, set) : Int;
    var _font : Font;
    var _textFormat : TextFormat;
    var _embeddedFont : Bool;
    var _backgroundColor : Int;
    var _borderColor : Int;
    /**
    * The <code>TextSettings</code> constructor.
    *
    * @param font Font object used for text.
    * @param textFormat TextFormat Object used to display Text.
    * @param backgroundColor Background Color used for the text, set to -1 for no background.
    * @param borderColor Border Color used for the text, set to -1 for no border.
    * 
    * @example The following code creates an instance of the TextSettings.
    * <listing version="3.0" >
    * var allFonts:Array = Font.enumerateFonts(true);
    * allFonts.sortOn("fontName", Array.CASEINSENSITIVE);
    * 
    * var fmt:TextFormat = new TextFormat();
    * fmt.size = 22;
    * fmt.color = 0x000000;
    * 
    * var textSettings:TextSettings = new TextSettings(Font(allFonts[0]), fmt, -1, 0xFF0000);
    * </listing>
    * 
    */    
    public function new(font : Font, textFormat : TextFormat, backgroundColor : Int = -1, borderColor : Int = -1) {
        _embeddedFont = false;
        // store properties
        this.font = font;
        this.textFormat = textFormat;
        _backgroundColor = backgroundColor;
        _borderColor = borderColor;
    }
    /**
    * Is the font used an embedded font.
    */    
    public function get_embeddedFont() : Bool {
        return _embeddedFont;
    }
    /**
    * Font Object
    */    
    public function set_font(f : Font) : Font {
        _font = f;
        // check to see if font is embedded or not
        if(_font.fontType == FontType.DEVICE)  {
            _embeddedFont = false;
        }
        else  {
            _embeddedFont = true;
        }
        // update text format object if exist
        if(_textFormat != null)  {
            _textFormat.font = _font.fontName;
        }
        return f;
    }
    public function get_font() : Font {
        return _font;
    }
    /**
    * Text Format for Text
    */    
    public function set_textFormat(fmt : TextFormat) : TextFormat {
        _textFormat = fmt;
        _textFormat.font = _font.fontName;
        return fmt;
    }
    public function get_textFormat() : TextFormat {
        return _textFormat;
    }
    /**
    * Background Color of Text.  Set to -1 for no background.
    */    
    public function set_backgroundColor(color : Int) : Int {
        _backgroundColor = color;
        return color;
    }
    public function get_backgroundColor() : Int {
        return _backgroundColor;
    }
    /**
    * Border Color of Text.  Set to -1 for no border.
    */    
    public function set_borderColor(color : Int) : Int {
        _borderColor = color;
        return color;
    }
    public function get_borderColor() : Int {
        return _borderColor;
    }
    /**
    * The <code>clone</code> method will return a new instance of the TextSettings.
    *
    * @return Returns new TextSettings with all the same settings.
    */    
    public function clone() : TextSettings {
        return new TextSettings(_font, _textFormat, _backgroundColor, _borderColor);
    }
}