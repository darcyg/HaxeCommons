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
import flash.display.DisplayObject;
import flash.geom.Point;    
import flash.Vector;
import com.nocircleno.graffiti.tools.ITool;
/**
* BitmapTool Class is the base class used by Tools that draw to the bitmap layer.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class BitmapTool implements ITool {
    public var renderType(get, never) : String;
    public var type(get, set) : String;
    public var layerType(get, never) : String;
    public var mode(get, set) : String;
    var LAYER_TYPE : String;
    var _renderType : String;
    var _mode : String;
    var _type : String;
    var commands : Vector<Int>;
    var drawingData : Vector<Float>;
    public function new() {
        LAYER_TYPE = LayerType.DRAWING_LAYER;
        commands = new Vector<Int>();
        drawingData = new Vector<Float>();
    }
    /**
    * Render Type
    */    
    public function get_renderType() : String {
        return _renderType;
    }
    /**
    * Type of Tool Option
    */    
    public function set_type(t : String) : String {
        _type = t;
        return t;
    }
    public function get_type() : String {
        return _type;
    }
    /**
    * Layer Tool Writes to
    */    
    public function get_layerType() : String {
        return LAYER_TYPE;
    }
    /**
    * Drawing Mode
    */    
    public function set_mode(toolMode : String) : String {
        // store mode
        if(toolMode != null && ToolMode.validMode(toolMode))  {
            _mode = toolMode;
        }
        else  {
            _mode = ToolMode.NORMAL;
        }
        return toolMode;
    }
    public function get_mode() : String {
        return _mode;
    }
    /**
    * The <code>resetTool</code> method will reset the drawing data held by the tool.
    */    
    public function resetTool() : Void {
        commands = new Vector<Int>();
        drawingData = new Vector<Float>();
    }
    /**
    * The <code>apply</code> method applies the BitmapTool to the DisplayObject passed
    * to the method.
    * 
    * @param drawingTarget Sprite that the bitmap tool will draw to.
    * @param point1 Starting point to apply tool.
    * @param point2 End point to apply tool.
    */    
    public function apply(drawingTarget : DisplayObject, point1 : Point, point2 : Point = null) : Void {
    }
}