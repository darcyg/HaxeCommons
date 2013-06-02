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
import flash.text.TextFormat;
/**
* TextTool Class is used to create and edit text objects for the graffiti library.
*
* @langversion 3.0
    * @playerversion Flash 10 AIR 1.5 
*/class TextTool implements ITool {
    public var layerType(get, never) : String;
    public var renderType(get, never) : String;
    public var textSettings(get, set) : TextSettings;
    var LAYER_TYPE : String;
    var _renderType : String;
    var _textSettings : TextSettings;
    /**
    * The <code>TextTool</code> constructor.
    *
    * @param textSettings TextSettings instance used when the TextTool is used.
    * 
    * @example The following code creates an instance of the TextTool.
    * <listing version="3.0" >
    * var fmt:TextFormat = new TextFormat();
    * fmt.font = "Arial";
    * fmt.size = 22;
    * fmt.color = 0x000000;
    * 
    * var textSettings:TextSettings = new TextSettings(fmt);
    * 
    * var textTool:TextTool = new TextTool(textSettings);
    * </listing>
    * 
    */    
    public function new(textSettings : TextSettings) {
        LAYER_TYPE = LayerType.OBJECT_LAYER;
        _renderType = ToolRenderType.SINGLE_CLICK;
        // store properties
        _textSettings = textSettings;
    }
    /**
    * Layer to create on.
    */    
    public function get_layerType() : String {
        return LAYER_TYPE;
    }
    /**
    * Text Tool Render Mode
    */    
    public function get_renderType() : String {
        return _renderType;
    }
    /**
    * Text Settings used by the Text Tool
    */    
    public function get_textSettings() : TextSettings {
        return _textSettings;
    }
    public function set_textSettings(value : TextSettings) : TextSettings {
        _textSettings = value;
        return value;
    }
}