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
import com.nocircleno.graffiti.tools.ITool;
import com.nocircleno.graffiti.tools.ToolRenderType;
/**
* Fill Bucket Tool Class allows the user to flood fill a part of the canvas.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class FillBucketTool implements ITool {
    public var fillColor(get, set) : Int;
    public var useEntireCanvas(get, set) : Bool;
    public var useAdvancedFill(get, set) : Bool;
    public var smoothStrength(get, set) : Int;
    public var layerType(get, never) : String;
    public var renderType(get, never) : String;
    var LAYER_TYPE : String;
    var _renderType : String;
    var _fillColor : Int;
    var _useEntireCanvas : Bool;
    var _useAdvancedFill : Bool;
    var _smoothStrength : Int;
    /**
    * The <code>FillBucketTool</code> constructor.
    * 
    * @param fillColor Color to fill with.  This color should have an alpha value.
    * @param useEntireCanvas Use underlaid and overlaid display object when filling.
    * @param useAdvancedFill Apply a smoothing to the fill before applying it to the canvas.
    * @param smoothStrength Smoothing setting for advanced fill.
    *
    * @example The following code creates a Fill Bucket Tool instance.
    * <listing version="3.0" >
    * // create a fill bucket tool
    * var fillTool:FillBucketTool = new FillBucketTool(0xFFFF0000, false); 
    * </listing>
    * 
    */   
    public function new(fillColor : Int, useEntireCanvas : Bool = false, useAdvancedFill : Bool = true, smoothStrength : Int = 8) {
        LAYER_TYPE = LayerType.DRAWING_LAYER;
        _renderType = ToolRenderType.SINGLE_CLICK;
        _fillColor = fillColor;
        _useEntireCanvas = useEntireCanvas;
        _useAdvancedFill = useAdvancedFill;
        _smoothStrength = smoothStrength;
    }
    /**
    * Fill Color
    */    
    public function set_fillColor(color : Int) : Int {
        _fillColor = color;
        return color;
    }
    public function get_fillColor() : Int {
        return _fillColor;
    }
    /**
    * Use the entire canvas when filling including an overlaid and underlaid display objects.
    */    
    public function set_useEntireCanvas(b : Bool) : Bool {
        _useEntireCanvas = b;
        return b;
    }
    public function get_useEntireCanvas() : Bool {
        return _useEntireCanvas;
    }
    /**
    * Smooth out the fill before applying to the canvas.
    */    
    public function set_useAdvancedFill(b : Bool) : Bool {
        _useAdvancedFill = b;
        return b;
    }
    public function get_useAdvancedFill() : Bool {
        return _useAdvancedFill;
    }
    /**
    * Smoothing strength when using advanded fill.
    */    
    public function set_smoothStrength(s : Int) : Int {
        _smoothStrength = s;
        return s;
    }
    public function get_smoothStrength() : Int {
        return _smoothStrength;
    }
    /**
    * Layer to create on.
    */    
    public function get_layerType() : String {
        return LAYER_TYPE;
    }
    /**
    * Fill Bucket Render Mode
    */    
    public function get_renderType() : String {
        return _renderType;
    }
}