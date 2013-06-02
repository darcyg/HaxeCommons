////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Didier BRUN -  http://www.bytearray.org
// Contributors: 
//              Alexandre LEGOUT - http://blog.lalex.com
//              Pleh                            
//              Andras Csizmadia -  http://www.vpmedia.eu
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
package org.bytearray.display;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Matrix;
import flash.geom.Rectangle;
class ScaleBitmap extends Sprite
{
    private var _canvas:Bitmap;
    private var _originalBitmap:BitmapData;
    private var _scale9Grid:Rectangle;
    //add to class properties
    private var _originalWidth:Float;
    private var _originalHeight:Float;
    private var _scaleX:Float;
    private var _scaleY:Float;
    
    public var bitmapData(getBitmapData, setBitmapData):BitmapData;
     public var bitmapScale9Grid(getScale9Grid, setScale9Grid):Rectangle;
    public var bitmapScaleX(getScaleX, setScaleX):Float;
    public var bitmapScaleY(getScaleY, setScaleY):Float;
    public var bitmapHeight(getHeight, setHeight):Float;
    public var bitmapWidth(getWidth, setWidth):Float;

    public function new(bmpData:BitmapData=null, ?pixelSnapping:PixelSnapping, ?smoothing:Bool=false)
    {
        super();
        if (pixelSnapping == null)
        {
            pixelSnapping = PixelSnapping.AUTO;
        }
        _scaleX = _scaleY = 1;
        // canvas
        _canvas = new Bitmap(bmpData, pixelSnapping, smoothing);
        addChild(_canvas);
        // original bitmap
        _originalBitmap=bmpData.clone();
        //add to constructor
        _originalWidth=bmpData.width;
        _originalHeight=bmpData.height;
    }
    
    private function getBitmapData():BitmapData
    {
        return _canvas.bitmapData;
    }

    /**
     * setter bitmapData
     */
    private function setBitmapData(bmpData:BitmapData):BitmapData
    {
        _originalBitmap=bmpData.clone();
        _originalWidth=bmpData.width;
        _originalHeight=bmpData.height;
        if(_scale9Grid !=null)
        {
            if(!validGrid(_scale9Grid))
            {
                _scale9Grid=null;
            }
            setSize(bmpData.width, bmpData.height);
        }
        else
        {
            assignBitmapData(_originalBitmap.clone());
        }
        return _originalBitmap;
    }

    /**
     * setter width
     */
     private function setWidth(w:Float):Float
    {
        if(w !=width)
        {
            setSize(w, height);
        }
        return width;
    }

    private function getWidth():Float
    {
        return width;
    }
    /**
     * setter height
     */
     private function setHeight(h:Float):Float
    {
        if(h !=height)
        {
            setSize(width, h);
        }
        return height;
    }
    
    private function getHeight():Float
    {
        return height;
    }

    /**
     * set scale9Grid
     */
    

    /**
     * get scale9Grid
     */
     private function getScale9Grid():Rectangle
    {
        return _scale9Grid;
    }
    
    private function setScale9Grid(r:Rectangle):Rectangle
    {
        // Check if the given grid is different from the current one
        if((_scale9Grid==null && r !=null)||(_scale9Grid !=null && !_scale9Grid.equals(r)))
        {
            if(r==null)
            {
                // If deleting scalee9Grid, restore the original bitmap
                // then resize it(streched)to the previously set dimensions
                var currentWidth:Float=width;
                var currentHeight:Float=height;
                _scale9Grid=null;
                assignBitmapData(_originalBitmap.clone());
                setSize(currentWidth, currentHeight);
            }
            else
            {
                if(!validGrid(r))
                {
                    trace("#001 - The _scale9Grid does not match the original BitmapData");
                    return _scale9Grid;
                }
                _scale9Grid=r.clone();
                resizeBitmap(width, height);
                scaleX=1;
                scaleY=1;
            }
        }
        return _scale9Grid;
    }

    /**
     * assignBitmapData
     * Update the effective bitmapData
     */
    private function assignBitmapData(bmp:BitmapData):Void
    {
        _canvas.bitmapData.dispose();
        _canvas.bitmapData=bmp;
    }

    private function validGrid(r:Rectangle):Bool
    {
        return r.right<=_originalBitmap.width && r.bottom<=_originalBitmap.height;
    }

    /**
     * setSize
     */
    public function setSize(w:Float, h:Float):Void
    {
        if(_scale9Grid==null)
        {
            width=w;
            height=h;
        }
        else
        {
            w=Std.int(Math.max(w, _originalBitmap.width - _scale9Grid.width));
            h=Std.int(Math.max(h, _originalBitmap.height - _scale9Grid.height));
            resizeBitmap(w, h);
        }
    }

    /**
     * get original bitmap
     */
    public function getOriginalBitmapData():BitmapData
    {
        return _originalBitmap;
    }

     private function getScaleX():Float
    {
        return _scaleX;
    }

    private function setScaleX(value:Float):Float
    {
        if(value !=_scaleX)
        {
            _scaleX=value;
            var w:Float=Std.int(_originalWidth * value);
            setSize(w, height);
        }
        return _scaleX;
    }

     private function getScaleY():Float
    {
        return _scaleY;
    }

    private function setScaleY(value:Float):Float
    {
        if(value !=scaleY)
        {
            _scaleY=value;
            var h:Float=Std.int(_originalHeight * value);
            setSize(width, h);
        }
        return _scaleY;
    }

    // ------------------------------------------------
    //
    // ---o protected methods
    //
    // ------------------------------------------------
    /**
     * resize bitmap
     */
    private function resizeBitmap(w:Float, h:Float):Void
    {
        var bmpData:BitmapData=new BitmapData(Std.int(w), Std.int(h), true, 0x00000000);
        var rows:Array<Dynamic>=[0, _scale9Grid.top, _scale9Grid.bottom, _originalBitmap.height];
        var cols:Array<Dynamic>=[0, _scale9Grid.left, _scale9Grid.right, _originalBitmap.width];
        var dRows:Array<Dynamic>=[0, _scale9Grid.top, h -(_originalBitmap.height - _scale9Grid.bottom), h];
        var dCols:Array<Dynamic>=[0, _scale9Grid.left, w -(_originalBitmap.width - _scale9Grid.right), w];
        var origin:Rectangle;
        var draw:Rectangle;
        var mat:Matrix=new Matrix();
        var cx:Int;
        var cy:Int;
        for(cx in 0...3)
        {
            for(cy in 0...3)
            {
                origin=new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
                draw=new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
                mat.identity();
                mat.a=draw.width / origin.width;
                mat.d=draw.height / origin.height;
                mat.tx=draw.x - origin.x * mat.a;
                mat.ty=draw.y - origin.y * mat.d;
                bmpData.draw(_originalBitmap, mat, null, null, draw, _canvas.smoothing);
            }
        }
        assignBitmapData(bmpData);
    }
}