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
package com.nocircleno.graffiti;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.IBitmapDrawable;
import flash.display.LineScaleMode;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.BlendMode; 
import flash.display.PixelSnapping;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
#if flash
import flash.filters.GradientGlowFilter;
#end
import flash.filters.BitmapFilterQuality;
import flash.filters.BitmapFilterType;
import flash.filters.BlurFilter;
import flash.text.TextField;
import flash.utils.ByteArray;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.ColorTransform;
import flash.ui.Keyboard;
import com.nocircleno.graffiti.events.GraffitiObjectEvent;
import com.nocircleno.graffiti.events.CanvasEvent;
import com.nocircleno.graffiti.tools.ITool;
import com.nocircleno.graffiti.tools.BitmapTool;
import com.nocircleno.graffiti.tools.ToolRenderType;
import com.nocircleno.graffiti.tools.BrushTool;
import com.nocircleno.graffiti.tools.BrushType;
import com.nocircleno.graffiti.tools.LineTool;
import com.nocircleno.graffiti.tools.LineType;
import com.nocircleno.graffiti.tools.ShapeTool;
import com.nocircleno.graffiti.tools.ShapeType;
import com.nocircleno.graffiti.tools.ToolMode;
import com.nocircleno.graffiti.tools.TextTool;
import com.nocircleno.graffiti.tools.FillBucketTool;
import com.nocircleno.graffiti.tools.SelectionTool;
import com.nocircleno.graffiti.tools.LayerType;
import com.nocircleno.graffiti.display.GraffitiObject;
import com.nocircleno.graffiti.display.Text;
import com.nocircleno.graffiti.managers.GraffitiObjectManager;
/**
* The GraffitiCanvas Class provides an area on stage to draw in.  It extends
* the Sprite Class, so you can add it as a child anywhere in the display list.
* Once you've created an instance of the GraffitiCanvas Class you can assign
* different tools to the canvas.
*
* <p>2.5 Features:
* <ul>
*      <li>Create a drawing area up to 4095x4095 pixels.</li>
*      <li>Brush Tool providing 7 different Brush shapes with transparency and blur.</li>
*     <li>Line Tool providing Solid, Dashed and Dotted lines.</li>
*     <li>Shape Tool providing Rectangle, Square, Oval and Circle Shapes.</li>
*     <li>Fill Bucket Tool provides a way to quickly fill a solid area of color with another color.</li>
*     <li>Text Tool allows you to create, edit and move text on the canvas.</li>
*      <li>Add a bitmap or vector image under and/or over the drawing area of the Canvas.</li>
*     <li>Built in zoom functionality including ability to drag an obscured canvas with the mouse.</li>
*     <li>Keep and control a history of the drawing allowing undo and redo's</li>
*     <li>Easily get a copy of your drawing to use with your favorite image encoder.</li>
* </ul></p>
* <p>It is up to the developer to implement a UI for these features.
* </p>
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class GraffitiCanvas extends Sprite {
    public var canvasWidth(get, set) : Int;
    public var canvasHeight(get, set) : Int;
    public var zoom(get, set) : Float;
    public var minZoom(get, never) : Float;
    public var maxZoom(get, never) : Float;
    public var activeTool(get, set) : ITool;
    public var overlay(never, set) : DisplayObject;
    public var underlay(never, set) : DisplayObject;
    public var mouseDrag(get, set) : Bool;
    public var canvasEnabled(get, set) : Bool;
    public var historyLength(get, never) : Int;
    public var maxHistoryLength(get, never) : Int;
    public var historyPosition(get, never) : Int;
    static public inline var HISTORY_LENGTH_CHANGE : String = "historyLengthChange";
    var MAX_WIDTH : Int;
    var MAX_HEIGHT : Int;
    var MAX_BITMAP_DIM : Int;
    // display assets
        var drawing_layer : Sprite;
    var object_layer : Sprite;
    var container : Sprite;
    var canvas : Bitmap;
    var overlay_do : DisplayObject;
    var underlay_do : DisplayObject;
    // private properties
    var _bmp : BitmapData;
    var _canvasEnabled : Bool;
    var _mouseDrag : Bool;
    var _tool : ITool;
    var _prevPoint : Point;
    var _canvasWidth : Int;
    var _canvasHeight : Int;
    var _zoom : Float;
    var _minZoom : Int;
    var _maxZoom : Int;
    var _history : Array<BitmapData>;
    var _maxHistoryLength : Int;
    var _historyPosition : Int;
    var _shiftKeyWasDown : Bool;
    var _objectManager : GraffitiObjectManager;
    /**
    * The <code>GraffitiCanvas</code> constructor.
    * 
    * @param canvasWidth Width of the canvas.
    * @param canvasHeight Height of the canvas.
    * @param numberHistoryLevels Max number of History items to keep, if 0 then no history is kept.
    * @param overlay An optional DisplayObject that can be used as an overlay to the Canvas.  DisplayObject should be partially transparent.
    * @param underlay An optional DisplayObject that can be used as an underlay to the Canvas.
    *
    * @example The following code creates a Graffiti Canvas instance. 
    * <listing version="3.0" >
    * package {
    *
    *        import flash.display.Sprite;
    *        import com.nocircleno.graffiti.GraffitiCanvas;
    *        import com.nocircleno.graffiti.tools.BrushTool;
    *        import com.nocircleno.graffiti.tools.BrushType;
    *        
    *        public class Main extends Sprite {
    *            
    *            public function Main() {
    *                
    *                // create new instance of graffiti canvas, with a width and height of 400 and 10 history levels.
    *                // by default a Brush instance is created inside the GraffitiCanvas Class and assigned as the active tool.
    *                var canvas:GraffitiCanvas = new GraffitiCanvas(400, 400, 10);
    *                addChild(canvas);
    *                
    *                // create a new BrushTool instance, brush size of 8, brush color is Red, fully opaque, no blur and Brush type is Backward line.
    *                var angledBrush:BrushTool = new BrushTool(8, 0xFF0000, 1, 0, BrushType.BACKWARD_LINE);
    *                
    *                // assign the Brush as the active tool used by the Canvas
    *                canvas.activeTool = angledBrush;
    *                
    *            }
    *            
    *        }
    * }
    * </listing>
    * 
    */    
    public function new(canvasWidth : Int = 100, canvasHeight : Int = 100, numberHistoryLevels : Int = 0, overlay : DisplayObject = null, underlay : DisplayObject = null) {
        super();
        MAX_WIDTH = 4095;
        MAX_HEIGHT = 4095;
        MAX_BITMAP_DIM = 5500;
        _canvasEnabled = true;
        _mouseDrag = false;
        _zoom = 1;
        _minZoom = 1;
        _historyPosition = 0;
        _shiftKeyWasDown = false;
        // set width and height
        _canvasWidth = canvasWidth;
        _canvasHeight = canvasHeight;
        // check values
        checkPropertyLimits();
        /////////////////////////////////////////////////
        // Create Default Tool, a Brush
        /////////////////////////////////////////////////
        _tool = new BrushTool(16, 0x000000, 1, 0, BrushType.DIAMOND);
        /////////////////////////////////////////////////
        // Create Canvas Assets
        /////////////////////////////////////////////////
        drawing_layer = new Sprite();
        object_layer = new Sprite();
        container = new Sprite();
        _bmp = new BitmapData(_canvasWidth, _canvasHeight, true, 0x00FFFFFF);
        canvas = new Bitmap(_bmp, PixelSnapping.AUTO, false);
        // add to display list
        addChild(container);
        container.addChild(canvas);
        container.addChild(drawing_layer);
        // if a overlay DisplayObject was passed, add it.
        if(overlay != null)  {
            overlay_do = overlay;
            container.addChild(overlay_do);
        }
        // if a underlay DisplayObject was passed, add it.
        if(underlay != null)  {
            underlay_do = underlay;
            container.addChildAt(underlay_do, 0);
        }
        // add object layer above everything
        container.addChild(object_layer);
        // add event listener
        object_layer.addEventListener(GraffitiObjectEvent.ENTER_EDIT, objectEventHandler, true, 0, true);
        object_layer.addEventListener(GraffitiObjectEvent.EXIT_EDIT, objectEventHandler, true, 0, true);
        // init object manager
        _objectManager = GraffitiObjectManager.getInstance();
        _objectManager.addEventListener(GraffitiObjectEvent.SELECT, objectEventHandler);
        _objectManager.addEventListener(GraffitiObjectEvent.DESELECT, objectEventHandler);
        _objectManager.addEventListener(GraffitiObjectEvent.DELETE, objectEventHandler);
        // add event listener for mouse down
        this.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
        // listen for stage add
        this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
        // set scroll rect
        this.scrollRect = new Rectangle(0, 0, _canvasWidth, _canvasHeight);
        /////////////////////////////////////////////////
        // Initialize Drawing History
        /////////////////////////////////////////////////
        initHistory(numberHistoryLevels);
    }
    /**
    * Control the canvas width.
    *
    * Important:
    * <ul>
    *      <li>The canvas is resized from the upper left hand corner.</li>
    *      <li>If you make the canvas width smaller, the drawing will get cropped on the right side.</li>
    *     <li>Changing the width of the canvas is NOT stored in the history.</li>
    * </ul>
    */    
    public function set_canvasWidth(w : Int) : Int {
        // set width
        _canvasWidth = w;
        // check value
        checkPropertyLimits();
        // rebuild the canvas with the new width
        resizeCanvas();
        return w;
    }
    public function get_canvasWidth() : Int {
        return _canvasWidth;
    }
    /**
    * Control the canvas height.
    *
    * Important:
    * <ul>
    *      <li>The canvas is resized from the upper left hand corner.</li>
    *      <li>If you make the canvas height smaller, the drawing will get cropped on the bottom.</li>
    *     <li>Changing the height of the canvas is NOT stored in the history.</li>
    * </ul>
    */    
    public function set_canvasHeight(h : Int) : Int {
        // set height
        _canvasHeight = h;
        // check value
        checkPropertyLimits();
        // rebuild the canvas with the new height
        resizeCanvas();
        return h;
    }
    public function get_canvasHeight() : Int {
        return _canvasHeight;
    }
    /**
    * Control the zoom state of the canvas from %100 (1) to the max zoom.
    */    
    public function set_zoom(z : Float) : Float {
        // check bounds
        if(z >= _minZoom && z <= _maxZoom)  {
            // find view center point to zoom off us.
            var centerPoint : Point = new Point((Math.abs(container.x) + _canvasWidth / 2) / _zoom, (Math.abs(container.y) + _canvasHeight / 2) / _zoom);
            // store zoom level
            _zoom = z;
            // scale container
            container.scaleX = _zoom;
            container.scaleY = _zoom;
            // try and keep the same center focus
            container.x = (-(centerPoint.x) * _zoom) + _canvasWidth / 2;
            container.y = (-(centerPoint.y) * _zoom) + _canvasHeight / 2;
            // enfore bounds and make sure no part of the image is out out of bounds
            if(container.x > 0)  {
                container.x = 0;
            }
            if(container.y > 0)  {
                container.y = 0;
            }
            if(container.x + container.width < _canvasWidth)  {
                container.x = _canvasWidth - container.width;
            }
            if(container.y + container.height < _canvasHeight)  {
                container.y = _canvasHeight - container.height;
            }
            // dispatch zoom event
            dispatchEvent(new CanvasEvent(CanvasEvent.ZOOM, _zoom, _canvasWidth, _canvasHeight, getViewableRect()));
        }
        return z;
    }
    public function get_zoom() : Float {
        return _zoom;
    }
    /**
    * Minimum Zoom value.
    */    
    public function get_minZoom() : Float {
        return _minZoom;
    }
    /**
    * Maximum Zoom value.
    */    
    public function get_maxZoom() : Float {
        return _maxZoom;
    }
    /**
    * Control what Tool is used when the user interacts with the Canvas.
    */    
    public function set_activeTool(tool : ITool) : ITool {
        // set tool
        _tool = tool;
        // if tool isn't null, then check layer
        if(_tool != null)  {
            // look to what layer this tool draws to
            if(_tool.layerType == LayerType.OBJECT_LAYER)  {
                object_layer.mouseChildren = true;
                // make sure we turn off editing for any object on the canvas is the selection
                if(Std.is(_tool, SelectionTool) && _objectManager.areObjectsBeingEdited())  {
                    _objectManager.exitEditAll();
                }
            }
            else  {
                object_layer.mouseChildren = false;
                _objectManager.deselectAll();
            }
        }
        else  {
            object_layer.mouseChildren = false;
            _objectManager.deselectAll();
        }
        return tool;
    }
    public function get_activeTool() : ITool {
        return _tool;
    }
    /**
    * Display Object displayed above the drawing.
    */    
    public function set_overlay(displayObject : DisplayObject) : DisplayObject {
        // if overlay already exists remove it before adding new overlay
        if(overlay_do != null)  {
            container.removeChild(overlay_do);
        }
        // update overlay
        overlay_do = displayObject;
        // add overlay if exists
        if(overlay_do != null)  {
            container.addChildAt(overlay_do, container.numChildren - 1);
        }
        return displayObject;
    }
    /**
    * Display Object displayed under the drawing.
    */    
    public function set_underlay(displayObject : DisplayObject) : DisplayObject {
        // if underlay already exists remove it before adding new underlay
        if(underlay_do != null)  {
            container.removeChild(underlay_do);
        }
        // update underlay
        underlay_do = displayObject;
        // add underlay if exists
        if(underlay_do != null)  {
            container.addChildAt(underlay_do, 0);
        }
        return displayObject;
    }
    /**
    * Control when you can use the mouse to drag around the canvas.
    */    
    public function set_mouseDrag(drag : Bool) : Bool {
        if(drag)  {
            _objectManager.deselectAll();
        }
        _mouseDrag = drag;
        return drag;
    }
    public function get_mouseDrag() : Bool {
        return _mouseDrag;
    }
    /**
    * Control if Canvas is enabled.
    */    
    public function set_canvasEnabled(en : Bool) : Bool {
        _canvasEnabled = en;
        this.mouseEnabled = en;
        this.mouseChildren = en;
        return en;
    }
    public function get_canvasEnabled() : Bool {
        return _canvasEnabled;
    }
    /**
    * Get the current number of saved history items.
    */    
    public function get_historyLength() : Int {
        return _history != (null) ? _history.length : 0;
    }
    /**
    * Get the maximum number of history items.
    */    
    public function get_maxHistoryLength() : Int {
        return _maxHistoryLength;
    }
    /**
    * Get the current history position.
    */    
    public function get_historyPosition() : Int {
        return _historyPosition;
    }
    /**
    * The <code>nextHistory</code> method will step forward and display the next item in 
    * the history.
    *
    * @see #prevHistory()
    * @see #historyLength
    * @see #historyPosition
    * @see #maxHistoryLength
    * @see #clearHistory()
    */    
    public function nextHistory() : Void {
        if(_history != null)  {
            if(_historyPosition != _history.length - 1)  {
                _historyPosition++;
                restoreFromHistory();
            }
        }
    }
    /**
    * The <code>prevHistory</code> method will step backwards and display the next item in 
    * the history.
    *
    * @see #prevHistory()
    * @see #historyLength
    * @see #historyPosition
    * @see #maxHistoryLength
    * @see #clearHistory()
    */    
    public function prevHistory() : Void {
        if(_history != null)  {
            if(_historyPosition != 0)  {
                _historyPosition--;
                restoreFromHistory();
            }
        }
    }
    /**
    * The <code>clearHistory</code> method will clear all history items.
    * the Canvas.
    *
    * @see #prevHistory()
    * @see #historyLength
    * @see #historyPosition
    * @see #maxHistoryLength
    * @see #clearHistory()
    */    
    public function clearHistory() : Void {
        if(_history != null)  {
            var i : Int;
            // kill stored bitmapdata objects
            i = 0;
            while(i < _history.length) {
                _history[i].dispose();
                ++i;
            }
            // create new vector
            _history = new Array<BitmapData>();
            // reset history position
            _historyPosition = 0;
        }
        // dispatch event for history length change
        dispatchEvent(new Event(GraffitiCanvas.HISTORY_LENGTH_CHANGE));
    }
    /**
    * The <code>fill</code> method will flood fill an area of the drawing with the supplied color.
    *
    * @param point Point at which to flood fill with color.
    * @param color Color to fill with.
    * @param useEntireCanvas Set to true to use an overlaid or underlaid display object when filling.
    * @param useAdvancedFill Set to smooth out the fill.
    * @param smoothStrength The strength of the smoothing when using the advanced fill setting.
    */    
    public function fill(point : Point, color : Int, useEntireCanvas : Bool = false, useAdvancedFill : Bool = true, smoothStrength : Int = 8) : Void {
        // make sure point is within bitmap size
        if(_bmp.rect.containsPoint(point))  {
            // if a color is passed with no alpha component, then add it.
            if((color >> 24) == 0)  {
                // add alpha value to color value.
                color = 0xFF << 24 | color;
            }
            var snapshot1 : BitmapData;
            var snapshot2 : BitmapData;
            // get two snapshot copies
            if(useEntireCanvas)  {
                // we do not want to include the object layer in the drawing capture
                this.object_layer.visible = false;
                snapshot1 = cast((this.drawing(true)), BitmapData);
                this.object_layer.visible = true;
            }
            else  {
                snapshot1 = cast((_bmp.clone()), BitmapData);
            }
            // make another copy
            snapshot2 = cast((snapshot1.clone()), BitmapData);
            // fill on point
            snapshot1.floodFill(Std.int(point.x), Std.int(point.y), color);
            // compare snapshots
            var compareResult : Dynamic = snapshot1.compare(snapshot2);
            // check to make sure compare result exists (snapshots are not the same).
            if(compareResult != 0)  {
                var comp : BitmapData = cast((compareResult), BitmapData);
                var compAlpha : BitmapData = comp.clone();
                // get alpha value from color
                var alphaValue : Int = color >> 24 & 0x000000FF;
                var alphaNormalized : Float = alphaValue * 0.003921568627450980392156862745098;
                // only apply filter if advanced fill is set
        
                if(useAdvancedFill)  {
          #if flash
                    // apply glow to smoothout and expand the fill a little
                    comp.applyFilter(comp, comp.rect, new Point(0, 0), new GradientGlowFilter(0, 90, [color, color], [0, alphaNormalized], [0, 255], 2, 2, smoothStrength, BitmapFilterQuality.HIGH, BitmapFilterType.FULL, true));
                    // we do not want to apply any alpha settings to this copy that will be used as an alpha mask with copy pixels
                    compAlpha.applyFilter(comp, comp.rect, new Point(0, 0), new GradientGlowFilter(0, 90, [color, color], [0, 0], [0, 255], 2, 2, smoothStrength, BitmapFilterQuality.HIGH, BitmapFilterType.FULL));
                  #end
        }
        
                else  {
                    // change color of fill difference to desired color
                    var cTransform : ColorTransform = new ColorTransform(1, 1, 1, 0, 0, 0, 0, alphaValue);
                    cTransform.color = color;
                    comp.colorTransform(comp.rect, cTransform);
                }
                // copy fill back into bitmap
                _bmp.copyPixels(comp, comp.rect, new Point(0, 0), compAlpha, new Point(0, 0), true);
                // kill compare bitmapdata objects
                comp.dispose();
                compAlpha.dispose();
            }
            // kill snapshot bitmapdata objects
            snapshot1.dispose();
            snapshot2.dispose();
            // record to history if one is being recorded
            if(_maxHistoryLength != 0)  {
                writeToHistory();
            }
        }
    }
    /**
    * The <code>getColorAtPoint</code> method will return the color at a specific point on the drawing.
    * If the point is out of bounds then 0 is returned.
    *
    * @param point Point to get color from.
    * @param useEntireCanvas A Boolean value that specifies whether to include any overlay or underlay display objects when reading the color at the point specified.
    *
    * @return Returns the color value at the point passed, returns 0 if point is outside of canvas dimensions.
    */    
    public function getColorAtPoint(point : Point, useEntireCanvas : Bool = false) : Int {
        var rColor : Int;
        // make sure point is within bitmap size
        if(_bmp.rect.containsPoint(point))  {
            if(useEntireCanvas)  {
                // get snapshot
                var snapshot : BitmapData = cast((this.drawing()), BitmapData);
                // get color
                rColor = snapshot.getPixel32(Std.int(point.x), Std.int(point.y));
                // kill bitmapdata
                snapshot.dispose();
            }
            else  {
                // get color
                rColor = _bmp.getPixel32(Std.int(point.x), Std.int(point.y));
            }
        }
        else  {
            rColor = 0;
        }
        return rColor;
    }
    /**
    * The <code>getViewableRect</code> method will return a Rectangle defining the viewable area of the Canvas.
    * 
    * @return A Rectangle object that represents the viewable are of the Canvas.
    * If the canvas is zoomed all they way out then the dimensions of the Rectangle
    * are same as the Canvas width and height.
    */    
    public function getViewableRect() : Rectangle {
        var absX : Float = container.x > (0.0) ? container.x : -container.x;
        var absY : Float = container.y > (0.0) ? container.y : -container.y;
        return new Rectangle(absX / _zoom, absY / _zoom, _canvasWidth / _zoom, _canvasHeight / _zoom);
    }
    /**
    * The <code>setCanvasPos</code> method will change the position of the canvas.
    * 
    * @param pos Point to move canvas to.
    */    
    public function setCanvasPos(pos : Point) : Void {
        // try and keep the same center focus
        container.x = pos.x;
        container.y = pos.y;
        // enfore bounds and make sure no part of the image is out out of bounds
        if(container.x > 0)  {
            container.x = 0;
        }
        if(container.y > 0)  {
            container.y = 0;
        }
        if(container.x + container.width < _canvasWidth)  {
            container.x = _canvasWidth - container.width;
        }
        if(container.y + container.height < _canvasHeight)  {
            container.y = _canvasHeight - container.height;
        }
    }
    /**
    * The <code>clearCanvas</code> method will clear the Canvas.
    */    
    public function clearCanvas() : Void {
        // clear canvas
        _bmp.fillRect(new Rectangle(0, 0, _canvasWidth, _canvasHeight), 0x00FFFFFF);
        // delete all objects
        _objectManager.selectAll();
        _objectManager.deleteSelected();
        // record to history if one is being recorded
        if(_maxHistoryLength != 0)  {
            writeToHistory();
        }
    }
    /**
    * The <code>drawing</code> method will return the bitmapdata object that captures
    * the drawn canvas including any overlay or underlay assets.
    *
    * @param transparentBg Specify if you want the image to have a transparent background.
    * 
    * @return A BitmapData object containing the entire canvas.
    */    
    public function drawing(transparentBg : Bool = false) : BitmapData {
        // make sure we deselect all objects before capturing the canvas.
        _objectManager.deselectAll();
        var canvasBmp : BitmapData;
        if(!transparentBg)  {
            canvasBmp = new BitmapData(_canvasWidth, _canvasHeight, false, 0xFFFFFFFF);
        }
        else  {
            canvasBmp = new BitmapData(_canvasWidth, _canvasHeight, true, 0x00FFFFFF);
        }
        canvasBmp.draw(container);
        return canvasBmp;
    }
    /**
    * The <code>drawToCanvas</code> method will draw a display object or bitmapdata object to the canvas.
    * This allows you to add an image that will be editable by the drawing engine.
    * 
    * @param asset Image to write to canvas. Object must IBitmapDrawable. This includes MovieClips, Sprites, Bitmaps, BitmapData.
    */    
    public function drawToCanvas(asset : Dynamic) : Void {
        if(Std.is(asset, IBitmapDrawable))  {
            _bmp.draw(cast((asset), IBitmapDrawable));
            // record to history if one is being recorded
            if(_maxHistoryLength != 0)  {
                writeToHistory();
            }
        }
    }
    /**************************************************************************
    Method    : addToStageHandler()
    
    Purpose    : This method will assign a listener for keyboard shortcuts
      to the stage.
      
    Params    : e - Event Object
    ***************************************************************************/    
    function addToStageHandler(e : Event) : Void {
        this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyboardShortcutHandler);
    }
    /**************************************************************************
    Method    : keyboardShortcutHandler()
    
    Purpose    : This method will handles keyboard shortcuts.
      
    Params    : e - KeyboardEvent Object
    ***************************************************************************/    
    function keyboardShortcutHandler(e : KeyboardEvent) : Void {
        if(_canvasEnabled)  {
            if(e.keyCode == Keyboard.DELETE)  {
                _objectManager.deleteSelected();
            }
        }
    }
    /**************************************************************************
    Method    : objectEventHandler()
    
    Purpose    : This method will handle graffiti object events.
      
    Params    : e - GraffitiObjectEvent Object
    ***************************************************************************/    
    function objectEventHandler(e : GraffitiObjectEvent) : Void {
        var dispatch : Bool = true;
        if(e.type == GraffitiObjectEvent.DESELECT)  {
            if(Std.is(e.graffitiObject, Text))  {
                // if the text field has no text, then kill it
                if(cast((e.graffitiObject), Text).text == "")  {
                    if(object_layer.contains(e.graffitiObject))  {
                        object_layer.removeChild(e.graffitiObject);
                    }
                    dispatch = false;
                }
            }
        }
        else if(e.type == GraffitiObjectEvent.DELETE)  {
            object_layer.removeChild(e.graffitiObject);
        }
        // stop event from rocking
        e.stopPropagation();
        // dispatch event if ok
        if(dispatch)  {
            dispatchEvent(e.clone());
        }
    }
    /**************************************************************************
    Method    : checkPropertyLimits()
    
    Purpose    : This method will make sure canvas width, canvas height and
      zoom level are within the bounds.
    ***************************************************************************/    
      function checkPropertyLimits() : Void {
        // check bounds of canvas width and height
        _canvasWidth = _canvasWidth <= (MAX_WIDTH) ? _canvasWidth : MAX_WIDTH;
        _canvasHeight = _canvasHeight <= (MAX_HEIGHT) ? _canvasHeight : MAX_HEIGHT;
        // calculate max zoom to avoid bitmap display problems
        _maxZoom = Math.floor(MAX_BITMAP_DIM / Math.max(_canvasWidth, _canvasHeight));
        // check zoom to make sure if not greater then max zoom
        if(_zoom > _maxZoom)  {
            this.zoom = _maxZoom;
        }
    }
    /**************************************************************************
    Method    : resizeCanvas()
    
    Purpose    : This method will resize the canvas assets.
    ***************************************************************************/    
    function resizeCanvas() : Void {
        /////////////////////////////////////////////////
        // Create Bitmap
        /////////////////////////////////////////////////
        if(_bmp != null)  {
            // make a copy of the canvas
            var bmpCopy : BitmapData = _bmp.clone();
            // kill current bitmap
            _bmp.dispose();
            // create new bitmapdata object with new width and height
            _bmp = new BitmapData(_canvasWidth, _canvasHeight, true, 0x00FFFFFF);
            // copy pixels back
            _bmp.copyPixels(bmpCopy, bmpCopy.rect, new Point(0, 0));
            // kill copy
            bmpCopy.dispose();
            // update canvas bitmapdata object
            canvas.bitmapData = _bmp;
        }
        // update scroll rect
        this.scrollRect = new Rectangle(0, 0, _canvasWidth, _canvasHeight);
    }
    /**************************************************************************
    Method    : initHistory()
    
    Purpose    : This method will initialize our drawing history.
    
    Params    : levels -- number of levels of history to keep.
    ***************************************************************************/    
    function initHistory(levels : Int) : Void {
        _maxHistoryLength = levels;
        if(_maxHistoryLength != 0)  {
            // create history vector
            _history = new Array<BitmapData>();
            // record blank canvas to history
            writeToHistory();
        }
    }
    /**************************************************************************
    Method    : restoreFromHistory()
    
    Purpose    : This method will restore the drawing to a store history
      drawing.
    ***************************************************************************/    
      function restoreFromHistory() : Void {
        // get history bitmap rectangle
        var historyRect : Rectangle = _history[_historyPosition].rect;
        // check to see if the dims of history bitmap and the current canas size don't match
        if(historyRect.width != _canvasWidth || historyRect.height != _canvasHeight)  {
            // create a tempory bitmapdata object the size of the canvas width and height
            var temp : BitmapData = new BitmapData(_canvasWidth, _canvasHeight, true, 0x00FFFFFF);
            // merge new tempory and history bitmapdata objects
            temp.copyPixels(_history[_historyPosition], _history[_historyPosition].rect, new Point(0, 0));
            // copy pixels to canvas bitmapdata
            _bmp.copyPixels(temp, temp.rect, new Point(0, 0));
            // kill temp bitmapdata
            temp.dispose();
        }
        else  {
            // restore history
            _bmp.copyPixels(_history[_historyPosition], _history[_historyPosition].rect, new Point(0, 0));
        }
    }
    /**************************************************************************
    Method    : writeToHistory()
    
    Purpose    : This method will record the current drawing to history.
    ***************************************************************************/    
    function writeToHistory() : Void {
        var historyLength : Int = _history.length;
        // if the history position is not at the end then
        // we need to dispose of the top of the history queue.
        if(_historyPosition != historyLength - 1)  {
            var i : Int;
            i = (historyLength - 1);
            while(i > _historyPosition) {
                _history[i].dispose();
                _history.splice(i, 1);
                --i;
            }
        }
        // if we have reached the max history length
        if(_history.length == _maxHistoryLength)  {
            _history[0].dispose();
            _history.splice(0, 1);
        }
        // write current drawing to history
        _history.push(_bmp.clone());
        // set history index to end
        _historyPosition = _history.length - 1;
        // dispatch event for history length change
        dispatchEvent(new Event(GraffitiCanvas.HISTORY_LENGTH_CHANGE));
    }
    /**************************************************************************
    Method    : mouseHandler()
    
    Purpose    : This method will handle the mouse events used for drawing.
    
    Params    : e -- MouseEvent object.
    ***************************************************************************/    
    function mouseHandler(e : MouseEvent) : Void {
        if(_canvasEnabled && (_tool != null || _mouseDrag))  {
            if(e.type == MouseEvent.MOUSE_DOWN)  {
                // if mousedrag is true then user can click and drag canvas, only used if zoomed in on canvas.
                if(_mouseDrag)  {
                    container.startDrag(false, new Rectangle(-(container.width - _canvasWidth), -(container.height - _canvasHeight), (container.width - _canvasWidth), (container.height - _canvasHeight)));
                    stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
                    stage.addEventListener(MouseEvent.MOUSE_MOVE, dragEventUpdater);
                }
                else  {
                    if(_tool.renderType == ToolRenderType.SINGLE_CLICK)  {
                        if(Std.is(_tool, FillBucketTool))  {
                            fill(new Point(container.mouseX, container.mouseY), cast((_tool), FillBucketTool).fillColor, cast((_tool), FillBucketTool).useEntireCanvas, cast((_tool), FillBucketTool).useAdvancedFill, cast((_tool), FillBucketTool).smoothStrength);
                        }
                        else  {
                            // Get any objects under the mouse position.
                            // We will use this to decide if we clicked on an object or just canvas
                            var objs : Array<Dynamic> = this.object_layer.getObjectsUnderPoint(new Point(container.mouseX, container.mouseY));
                            var selectedObjects : Array<GraffitiObject>;
                            var text : Text;
                            // if no objects where click on...
                            if(objs.length == 0)  {
                                if(Std.is(_tool, TextTool))  {
                                    if(_objectManager.areObjectsSelected())  {
                                        _objectManager.deselectAll();
                                    }
                                    else  {
                                        text = new Text(cast((_tool), TextTool).textSettings);
                                        text.x = container.mouseX;
                                        text.y = container.mouseY - (text.height / 2);
                                        object_layer.addChild(text);
                                        _objectManager.deselectAll();
                                        _objectManager.addObject(text);
                                        // set the object as selection
                                        selectedObjects = new Array<GraffitiObject>();
                                        selectedObjects.push(text);
                                        _objectManager.setSelection(selectedObjects);
                                    }
                                }
                                else if(Std.is(_tool, SelectionTool))  {
                                    if(_objectManager.areObjectsSelected())  {
                                        _objectManager.deselectAll();
                                    }
                                }
                            }
                            else  {
                                if(Std.is(_tool, TextTool))  {
                                    // get Text Reference
                                    if(Std.is(e.target, TextField))  {
                                        text = cast((e.target.parent), Text);
                                    }
                                    else  {
                                        text = cast((e.target), Text);
                                    }
                                    if(!text.editing)  {
                                        selectedObjects = new Array<GraffitiObject>();
                                        selectedObjects.push(text);
                                        _objectManager.setSelection(selectedObjects);
                                        text.editing = true;
                                    }
                                }
                                else if(Std.is(_tool, SelectionTool))  {
                                    var go : GraffitiObject=null;
                                    // get graffiti object Reference
                                    if(e.target.parent == this.object_layer)  {
                                        go = cast((e.target), GraffitiObject);
                                    }
                                    else if(e.target.parent.parent == this.object_layer)  {
                                        go = cast((e.target.parent), GraffitiObject);
                                    }
                                    selectedObjects = new Array<GraffitiObject>();
                                    selectedObjects.push(go);
                                    _objectManager.setSelection(selectedObjects);
                                    if(!go.editing)  {
                                        go.startDrag();
                                    }
                                }
                                stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
                            }
                        }
                    }
                    else  {
                        if(_tool.renderType == ToolRenderType.CLICK_DRAG)  {
                            _prevPoint = new Point(container.mouseX, container.mouseY);
                        }
                        stage.addEventListener(MouseEvent.MOUSE_MOVE, draw);
                        draw();
                        stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
                    }
                }
            }
            else if(e.type == MouseEvent.MOUSE_UP)  {
                stopDrag();
                // prevPoint will be defined if in drawing mode
                if(_prevPoint != null)  {
                    // if filters are present, this is a blur on a brush
                    // need to divide the blur value by zoom for better effect.
                    if(drawing_layer.filters.length > 0)  {
                        var modBrushBlur : Float = cast((_tool), BrushTool).blur / _zoom;
                        drawing_layer.filters = [new BlurFilter(modBrushBlur, modBrushBlur, 2)];
                    }
                    // draw to bitmap
                    _bmp.draw(drawing_layer, new Matrix(), null, cast((_tool), BitmapTool).mode == ToolMode.NORMAL ? BlendMode.NORMAL : BlendMode.ERASE);
                    // clear vectors from drawing space
                    drawing_layer.graphics.clear();
                    // reset tool data
                    cast((_tool), BitmapTool).resetTool();
                    // clear filters if they exist
                    if(drawing_layer.filters.length > 0)  {
                        drawing_layer.filters = [];
                    }
                    // record to history if one is being recorded
                    if(_maxHistoryLength != 0)  {
                        writeToHistory();
                    }
                    // clear prev point
                    _prevPoint = null;
                    // remove drawing event
                    stage.removeEventListener(MouseEvent.MOUSE_MOVE, draw);
                }
                else  {
                    // remove drag event dispatcher
                    stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragEventUpdater);
                }
                // remove mouse up event
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
            }
        }
    }
    /**************************************************************************
    Method    : dragEventUpdater()
    
    Purpose    : This method will dispatch the DRAG event for the canvas.
    
    Params    : e -- MouseEvent object.
    ***************************************************************************/    
    function dragEventUpdater(e : MouseEvent) : Void {
        // dispatch zoom event
        dispatchEvent(new CanvasEvent(CanvasEvent.DRAG, _zoom, _canvasWidth, _canvasHeight, getViewableRect()));
    }
    /**************************************************************************
    Method    : draw()
    
    Purpose    : This method will draw a new line.
    
    Params    : e -- MouseEvent object that can be null.
    ***************************************************************************/    
    function draw(e : MouseEvent = null) : Void {
        var toolRef : BitmapTool = cast((_tool), BitmapTool);
        var nextPoint : Point = new Point(container.mouseX, container.mouseY);
        if(toolRef.renderType == ToolRenderType.CLICK_DRAG)  {
            // clear vectors from drawing space
            drawing_layer.graphics.clear();
        }
        if(_prevPoint == null)  {
            // apply tool
            toolRef.apply(drawing_layer, nextPoint);
        }
        else  {
            ///////////////////////////////////////////////////////
            // Check to see if SHIFT is down to enforce limits
            // on the Line or Shape tools.
            ///////////////////////////////////////////////////////
            if(Std.is(toolRef, LineTool) && e != null)  {
                // if shift then limit line to 90 degree angles
                if(e.shiftKey)  {
                    // calculate abs x and y difference values
                    var xDiff : Float = nextPoint.x - _prevPoint.x;
                    var yDiff : Float = nextPoint.y - _prevPoint.y;
                    var absXDiff : Float = xDiff > (0.0) ? xDiff : -xDiff;
                    var absYDiff : Float = yDiff > (0.0) ? yDiff : -yDiff;
                    // lock to 45, 135, 225, or 295 angle
                    if(xDiff > yDiff * .5 && xDiff * .5 < yDiff)  {
                        // take the lowest diff as the value to use
                        var finalOffSet : Float = xDiff < (yDiff) ? xDiff : yDiff;
                        // determine the new x & y values to give us a 45 degree angle value
                        var xDiffRaw : Float = nextPoint.x - _prevPoint.x;
                        var yDiffRaw : Float = nextPoint.y - _prevPoint.y;
                        var xOffSet : Float = xDiffRaw < (0) ? -finalOffSet : finalOffSet;
                        var yOffSet : Float = yDiffRaw < (0) ? -finalOffSet : finalOffSet;
                        // update next point to be on a 45 degree angle
                        nextPoint.x = _prevPoint.x + xOffSet;
                        nextPoint.y = _prevPoint.y + yOffSet;
                    }
                    else if(absXDiff < absYDiff)  {
                        nextPoint.x = _prevPoint.x;
                    }
                    else  {
                        nextPoint.y = _prevPoint.y;
                    }
                }
            }
            else if(Std.is(toolRef, ShapeTool) && e != null)  {
                // if shift then make RECTANGLE -> SQUARE or OVAL -> CIRCLE
                if(e.shiftKey)  {
                    if(toolRef.type == ShapeType.OVAL)  {
                        toolRef.type = ShapeType.CIRCLE;
                    }
                    else if(toolRef.type == ShapeType.RECTANGLE)  {
                        toolRef.type = ShapeType.SQUARE;
                    }
                    // set flag
                    _shiftKeyWasDown = true;
                }
                else  {
                    if(_shiftKeyWasDown)  {
                        // reset flag
                        _shiftKeyWasDown = false;
                        // check to see if we need to switch shapes back
                        if(toolRef.type == ShapeType.CIRCLE)  {
                            toolRef.type = ShapeType.OVAL;
                        }
                        else if(toolRef.type == ShapeType.SQUARE)  {
                            toolRef.type = ShapeType.RECTANGLE;
                        }
                    }
                }
            }
            // apply tool
            toolRef.apply(drawing_layer, _prevPoint, nextPoint);
        }
        // if render type is continuous then write image to
        if(_tool.renderType == ToolRenderType.CONTINUOUS)  {
            // store prev point for next time
            _prevPoint = new Point(nextPoint.x, nextPoint.y);
            // erase modes need to be draw here and not on mouse up.
            if(toolRef.mode == ToolMode.ERASE)  {
                // draw to bitmap
                _bmp.draw(drawing_layer, new Matrix(), null, toolRef.mode == ToolMode.NORMAL ? BlendMode.NORMAL : BlendMode.ERASE);
                // clear vectors from drawing space
                drawing_layer.graphics.clear();
                // reset tool data
                toolRef.resetTool();
            }
        }
        // force screen update if event object is defined
        if(e != null)  {
            e.updateAfterEvent();
        }
    }
}