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
import com.nocircleno.graffiti.tools.LineType;
import com.nocircleno.graffiti.utils.Conversions;
/**
* LineTool Class allows the user to draw a SOLID, DASHED or DOTTED line on the canvas.
*
* @langversion 3.0
    * @playerversion Flash 10 AIR 1.5 
*/
class LineTool extends BitmapTool {
    public var lineWidth(get, set) : Float;
    public var color(get, set) : Int;
    public var alpha(get, set) : Float;
    // store local references for performance reasons
    var THETA : Float;
    var LINE_SEGMENT_LENGTH_BASE : Int;
    var _lineWidth : Float;
    var _color : Int;
    var _alpha : Float;
    var _dotSpacing : Float;
    var _r : Float;
    var _d : Float;
    /**
    * The <code>LineTool</code> constructor.
    * 
    * @param lineWidth Line width.
    * @param lineColor Line Color.
    * @param lineType Type of Line.
    * @param toolMode Tool mode the Line will be drawing with.
    * 
    * @example The following code creates a Line instance.
    * <listing version="3.0" >
    * // create a dotted line of size 8 and the color of red
    * var dottedLine:Line = new Line(8, 0xFF0000, 1, LineType.DOTTED);
    * </listing>
    */    
    public function new(lineWidth : Float = 4, lineColor : Int = 0x000000, lineAlpha : Float = 1, lineType : String = null, toolMode : String = null) {
        super();
    THETA = 45;
        LINE_SEGMENT_LENGTH_BASE = 4;
        // set render type
        _renderType = ToolRenderType.CLICK_DRAG;
        // store size
        this.lineWidth = lineWidth;
        // store color
        color = lineColor;
        // store alpha
        _alpha = lineAlpha;
        // store type
        type = lineType;
        // store mode
        mode = toolMode;
    }
    /**
    * Size of the Line
    */    
    public function set_lineWidth(lineW : Float) : Float {
        if(lineW > 0)  {
            // set brush size
            _lineWidth = lineW;
            // update values for dotted line
            _dotSpacing = 2 * _lineWidth;
            _r = _lineWidth * .5;
            _d = _r / Math.cos(Conversions.radians(0.5 * THETA));
        }
        return lineW;
    }
    public function get_lineWidth() : Float {
        return _lineWidth;
    }
    /**
    * Color of the Line
    */    
    public function set_color(lineColor : Int) : Int {
        _color = lineColor;
        return lineColor;
    }
    public function get_color() : Int {
        return _color;
    }
    /**
    * Alpha of the Line
    */    
    public function set_alpha(lineAlpha : Float) : Float {
        _alpha = lineAlpha;
        return lineAlpha;
    }
    public function get_alpha() : Float {
        return _alpha;
    }
    /**
    * Type of Line
    */    
    override public function set_type(lineType : String) : String {
        // determine type
        if(lineType != null && LineType.validType(lineType))  {
            _type = lineType;
        }
        else  {
            _type = LineType.SOLID;
        }
        return lineType;
    }
    /**
    * The <code>apply</code> method applies the line to the Sprite object passed
    * to the method.
    * 
    * @param drawingTarget Sprite that the line will draw to.
    * @param point1 Starting point to apply line.
    * @param point2 End point to apply line.
    */    
    override public function apply(drawingTarget : DisplayObject, point1 : Point, point2 : Point = null) : Void {
        // clear drawing commands and data
        resetTool();
        // cast target as a Sprite
        var targetCast : Sprite = cast((drawingTarget), Sprite);
        // clear it
        targetCast.graphics.clear();
        var lineLength : Float = Math.sqrt(Math.pow(point2.x - point1.x, 2) + Math.pow(point2.y - point1.y, 2));
        var angle : Float = Math.atan2(point2.y - point1.y, point2.x - point1.x);
        var i : Int;
        // make sure second point is defined
        if(point2 != null)  {
            // move to first point
            commands.push(GraphicsPathCommand.MOVE_TO);
            drawingData.push(point1.x);
            drawingData.push(point1.y);
            // draw SOLID line
            if(_type == LineType.SOLID)  {
                // add line
                commands.push(GraphicsPathCommand.LINE_TO);
                drawingData.push(point2.x);
                drawingData.push(point2.y);
                targetCast.graphics.lineStyle(_lineWidth, _color, _alpha);
                targetCast.graphics.drawPath(commands, drawingData, GraphicsPathWinding.NON_ZERO);
            }
            else if(_type == LineType.DASHED)  {
                var lineSegmentLength : Int = Std.int(LINE_SEGMENT_LENGTH_BASE * _lineWidth);
                var lineSegmentLengthSpace : Int = Std.int(LINE_SEGMENT_LENGTH_BASE * _lineWidth);
                var numberLineSegments : Int = Math.floor(lineLength / (lineSegmentLength + lineSegmentLengthSpace));
                var segmentStartPoint : Point = new Point();
                var segmentEndPoint : Point = new Point();
                // loop and draw all segments
                i = 0;
                while(i <= numberLineSegments) {
                    // calculate segment start point
                    segmentStartPoint.x = point1.x + (Math.cos(angle) * (i * (lineSegmentLength + lineSegmentLengthSpace)));
                    segmentStartPoint.y = point1.y + (Math.sin(angle) * (i * (lineSegmentLength + lineSegmentLengthSpace)));
                    // calculate segment end point
                    segmentEndPoint.x = point1.x + (Math.cos(angle) * (((i + 1) * (lineSegmentLength + lineSegmentLengthSpace)) - lineSegmentLengthSpace));
                    segmentEndPoint.y = point1.y + (Math.sin(angle) * (((i + 1) * (lineSegmentLength + lineSegmentLengthSpace)) - lineSegmentLengthSpace));
                    // check last segment and adjust length if needed
                    if(i == numberLineSegments)  {
                        var finalLength : Float = Math.sqrt(Math.pow((point2.x - segmentStartPoint.x), 2) + Math.pow((point2.y - segmentStartPoint.y), 2));
                        // if final length is less then or equal to the line segment then use end point to draw last segment
                        if(finalLength <= lineSegmentLength)  {
                            segmentEndPoint.x = point2.x;
                            segmentEndPoint.y = point2.y;
                        }
                    }
                    // store segment
                    commands.push(GraphicsPathCommand.MOVE_TO);
                    drawingData.push(segmentStartPoint.x);
                    drawingData.push(segmentStartPoint.y);
                    commands.push(GraphicsPathCommand.LINE_TO);
                    drawingData.push(segmentEndPoint.x);
                    drawingData.push(segmentEndPoint.y);
                    ++i;
                }
                targetCast.graphics.lineStyle(_lineWidth, _color, _alpha, false, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
                targetCast.graphics.drawPath(commands, drawingData, GraphicsPathWinding.NON_ZERO);
            }
            else if(_type == LineType.DOTTED)  {
                var k : Int;
                var xControl : Float;
                var yControl : Float;
                var xAnchor : Float;
                var yAnchor : Float;
                var controlAngleRadians : Float;
                var anchorAngleRadians : Float;
                var dotPos : Point = new Point();
                // loop and draw all points for the line
                i = 0;
                while(i <= lineLength) {
                    // calculate dot position
                    dotPos.x = point1.x + (Math.cos(angle) * i);
                    dotPos.y = point1.y + (Math.sin(angle) * i);
                    commands.push(GraphicsPathCommand.MOVE_TO);
                    drawingData.push(dotPos.x + _r);
                    drawingData.push(dotPos.y);
                    k = Std.int(THETA / 2);
                    while(k < 361) {
                        controlAngleRadians = Conversions.radians(k);
                        anchorAngleRadians = Conversions.radians(k + (THETA / 2));
                        xControl = _d * Math.cos(controlAngleRadians);
                        yControl = _d * Math.sin(controlAngleRadians);
                        xAnchor = _r * Math.cos(anchorAngleRadians);
                        yAnchor = _r * Math.sin(anchorAngleRadians);
                        commands.push(GraphicsPathCommand.CURVE_TO);
                        drawingData.push(dotPos.x + xControl);
                        drawingData.push(dotPos.y + yControl);
                        drawingData.push(dotPos.x + xAnchor);
                        drawingData.push(dotPos.y + yAnchor);
                        k = Std.int(k + THETA);
                    }
                    i += Std.int(_dotSpacing);
                }
                // draw dots
                targetCast.graphics.lineStyle(0, 0xFF0000, 0);
                targetCast.graphics.beginFill(_color, _alpha);
                targetCast.graphics.drawPath(commands, drawingData, GraphicsPathWinding.NON_ZERO);
                targetCast.graphics.endFill();
            }
        }
    }
}