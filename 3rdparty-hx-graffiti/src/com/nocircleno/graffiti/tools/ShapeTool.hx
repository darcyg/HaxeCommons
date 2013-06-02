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
import flash.display.Sprite;
import flash.display.LineScaleMode;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsPathWinding;
import flash.geom.Rectangle;
import flash.geom.Point;
import com.nocircleno.graffiti.tools.ITool;
import com.nocircleno.graffiti.tools.ToolRenderType;
import com.nocircleno.graffiti.tools.ShapeType;
import com.nocircleno.graffiti.utils.Conversions;
/**
* ShapeTool Class allows the user to draw RECTANGLE, SQUARE, OVAL or CIRCLE to the canvas.
* You can control the stroke and fill of the shape.
*
* @langversion 3.0
    * @playerversion Flash 10 AIR 1.5 
*/
class ShapeTool extends BitmapTool {
    public var strokeWidth(get, set) : Float;
    public var strokeColor(get, set) : Int;
    public var fillColor(get, set) : Int;
    public var strokeAlpha(get, set) : Float;
    public var fillAlpha(get, set) : Float;
    // store local references for performance reasons
    var _strokeWidth : Float;
    var _strokeColor : Int;
    var _fillColor : Int;
    var _strokeAlpha : Float;
    var _fillAlpha : Float;
    /**
    * The <code>ShapeTool</code> constructor.
    * 
    * @param strokeWidth Stroke width.
    * @param strokeColor Stroke Color, pass -1 for NO stroke on Shape.
    * @param fillColor Fill Color, pass -1 for NO fill in Shape.
    * @param strokeAlpha Stroke Alpha, default is 1.
    * @param fillAlpha Fill Alpha, default is 1.
    * @param shapeType Type of Shape.
    * @param toolMode Tool mode the Shape will be drawing with.
    * 
    * @example The following code creates a Shape instance.
    * <listing version="3.0" >
    * // create a rectangle shape with red stroke width of 2 and no fill
    * var rectangleShape:Shape = new Shape(2, 0xFF0000, -1, 1, 1, ShapeType.RECTANGLE);
    * </listing>
    */    
    public function new(strokeWidth : Float = 1, strokeColor : Int = 0x000000, fillColor : Int = 0xFFFFFF, strokeAlpha : Float = 1, fillAlpha : Float = 1, shapeType : String = null, toolMode : String = null) {
        super();
    // set render type
        _renderType = ToolRenderType.CLICK_DRAG;
        // store size
        this.strokeWidth = strokeWidth;
        // store stroke color
        this.strokeColor = strokeColor;
        // store fill color
        this.fillColor = fillColor;
        // store stroke alpha
        this.strokeAlpha = strokeAlpha;
        // store fill alpha
        this.fillAlpha = fillAlpha;
        // store type
        type = shapeType;
        // store mode
        mode = toolMode;
    }
    /**
    * Stroke width
    */    
    public function set_strokeWidth(strokeW : Float) : Float {
        if(strokeW > 0 || strokeW == -1)  {
            // set stroke size
            _strokeWidth = strokeW;
        }
        return strokeW;
    }
    public function get_strokeWidth() : Float {
        return _strokeWidth;
    }
    /**
    * Color of the Stroke, set to -1 for no stroke.
    */    
    public function set_strokeColor(color : Int) : Int {
        _strokeColor = color;
        return color;
    }
    public function get_strokeColor() : Int {
        return _strokeColor;
    }
    /**
    * Color of the Fill, set to -1 for no fill.
    */    
    public function set_fillColor(color : Int) : Int {
        _fillColor = color;
        return color;
    }
    public function get_fillColor() : Int {
        return _fillColor;
    }
    /**
    * Alpha of the Stroke
    */    
    public function set_strokeAlpha(alpha : Float) : Float {
        _strokeAlpha = alpha;
        return alpha;
    }
    public function get_strokeAlpha() : Float {
        return _strokeAlpha;
    }
    /**
    * Alpha of the Fill
    */    
    public function set_fillAlpha(alpha : Float) : Float {
        _fillAlpha = alpha;
        return alpha;
    }
    public function get_fillAlpha() : Float {
        return _fillAlpha;
    }
    /**
    * Type of Shape
    */    
    override public function set_type(shapeType : String) : String {
        // determine type
        if(shapeType != null && ShapeType.validType(shapeType))  {
            _type = shapeType;
        }
        else  {
            _type = ShapeType.RECTANGLE;
        }
        return shapeType;
    }
    /**
    * The <code>apply</code> method applies the line to the Sprite object passed
    * to the method.
    * 
    * @param drawingTarget Sprite that the Shape will draw to.
    * @param point1 Starting point to apply Shape.
    * @param point2 End point to apply Shape.
    */    
    override public function apply(drawingTarget : DisplayObject, point1 : Point, point2 : Point = null) : Void {
        var k : Int;
        var xControl : Float;
        var yControl : Float;
        var xAnchor : Float;
        var yAnchor : Float;
        var theta : Float = 45;
        var r : Float;
        var r2 : Float;
        var d : Float;
        var d2 : Float;
        var controlAngleRadians : Float;
        var anchorAngleRadians : Float;
        var centerPoint : Point;
        // clear drawing commands and data
        resetTool();
        // cast target as a Sprite
        var targetCast : Sprite = cast((drawingTarget), Sprite);
        // calculate dim differences
        var xDiff : Float = point2.x - point1.x;
        var yDiff : Float = point2.y - point1.y;
        // if stroke color exists, define line style
        if(_strokeColor != -1)  {
            // use square corners with miter joints for rectangle and square shapes
            if(_type == ShapeType.RECTANGLE || _type == ShapeType.SQUARE)  {
                targetCast.graphics.lineStyle(_strokeWidth, _strokeColor, _strokeAlpha, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
            }
            else  {
                targetCast.graphics.lineStyle(_strokeWidth, _strokeColor, _strokeAlpha);
            }
        }
        // if fill color exists, start fill
        if(_fillColor != -1)  {
            targetCast.graphics.beginFill(_fillColor, _fillAlpha);
        }
        // draw shape
        if(_type == ShapeType.RECTANGLE)  {
            commands.push(GraphicsPathCommand.MOVE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x + xDiff);
            drawingData.push(point1.y);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x + xDiff);
            drawingData.push(point1.y + yDiff);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y + yDiff);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y);
        }
        if(_type == ShapeType.SQUARE)  {
            // calculate length
            var segmentLength : Float = Math.abs(Math.max(xDiff, yDiff));
            var squareWidth : Float = point2.x < (point1.x) ? -segmentLength : segmentLength;
            var squareHeight : Float = point2.y < (point1.y) ? -segmentLength : segmentLength;
            commands.push(GraphicsPathCommand.MOVE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x + squareWidth);
            drawingData.push(point1.y);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x + squareWidth);
            drawingData.push(point1.y + squareHeight);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y + squareHeight);
            commands.push(GraphicsPathCommand.LINE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y);
        }
        else if(_type == ShapeType.OVAL)  {
            r = xDiff / 2;
            r2 = yDiff / 2;
            d = r / Math.cos(Conversions.radians(0.5 * theta));
            d2 = r2 / Math.cos(Conversions.radians(0.5 * theta));
            centerPoint = new Point(point1.x + ((xDiff) / 2), point1.y + ((yDiff) / 2));
            commands.push(GraphicsPathCommand.MOVE_TO);
            drawingData.push(centerPoint.x + r);
            drawingData.push(centerPoint.y);
            // draw the new preview circle
            k = Std.int(theta / 2);
            while(k < 361) {
                controlAngleRadians = Conversions.radians(k);
                anchorAngleRadians = Conversions.radians(k + (theta / 2));
                xControl = d * Math.cos(controlAngleRadians);
                yControl = d2 * Math.sin(controlAngleRadians);
                xAnchor = r * Math.cos(anchorAngleRadians);
                yAnchor = r2 * Math.sin(anchorAngleRadians);
                commands.push(GraphicsPathCommand.CURVE_TO);
                drawingData.push(centerPoint.x + xControl);
                drawingData.push(centerPoint.y + yControl);
                drawingData.push(centerPoint.x + xAnchor);
                drawingData.push(centerPoint.y + yAnchor);
                k = Std.int(k + theta);
            }
        }
        else if(_type == ShapeType.CIRCLE)  {
            var lineLength : Float = Math.sqrt(Math.pow(point2.x - point1.x, 2) + Math.pow(point2.y - point1.y, 2));
            r = lineLength / 2;
            d = r / Math.cos(Conversions.radians(0.5 * theta));
            centerPoint = new Point(point1.x + ((xDiff) / 2), point1.y + ((yDiff) / 2));
            commands.push(GraphicsPathCommand.MOVE_TO);
            drawingData.push(centerPoint.x + r);
            drawingData.push(centerPoint.y);
            k = Std.int(theta / 2);
            while(k < 361) {
                controlAngleRadians = Conversions.radians(k);
                anchorAngleRadians = Conversions.radians(k + (theta / 2));
                xControl = d * Math.cos(controlAngleRadians);
                yControl = d * Math.sin(controlAngleRadians);
                xAnchor = r * Math.cos(anchorAngleRadians);
                yAnchor = r * Math.sin(anchorAngleRadians);
                commands.push(GraphicsPathCommand.CURVE_TO);
                drawingData.push(centerPoint.x + xControl);
                drawingData.push(centerPoint.y + yControl);
                drawingData.push(centerPoint.x + xAnchor);
                drawingData.push(centerPoint.y + yAnchor);
                k = Std.int(k + theta);
            }
        }
        // draw shape
        targetCast.graphics.drawPath(commands, drawingData, GraphicsPathWinding.NON_ZERO);
        // if fill color exists then end fill
        if(_fillColor != -1)  {
            targetCast.graphics.endFill();
        }
    }
}