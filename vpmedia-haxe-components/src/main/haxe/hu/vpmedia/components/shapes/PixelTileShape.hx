////////////////////////////////////////////////////////////////////////////////
//=BEGIN CLOSED LICENSE
//
// Copyright(c) 2012-2013 Andras Csizmadia.
// http://www.vpmedia.eu
//
// For information about the licensing and copyright please 
// contact Andras Csizmadia at andras@vpmedia.eu.
//
//=END CLOSED LICENSE
////////////////////////////////////////////////////////////////////////////////
package hu.vpmedia.components.shapes;

import flash.display.Graphics;
import flash.display.DisplayObjectContainer;

class PixelTileShape extends BaseShape
{
    public static var ZOOM:Int = 1;
    public var data:Array<String>;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(parent:DisplayObjectContainer,x:Int,y:Int,data:Array<String>,?fill:IBaseGraphicsTexture=null, ?drawAfter:Bool=true)
    {        
        type = EShapeType.PIXEL_TILE;
        this.data = data;
        super(parent, x, y, 1, 1, fill, null, drawAfter);
    }
    
    override function drawGeometry():Void
    {
        var maxRows:Int=data.length;
        var maxColumns:Int=0;
        var row:Int;
        var col:Int;
        var s:String;
        for(row in 0...maxRows)
        {
            maxColumns=data[row].length;
            for(col in 0...maxColumns)
            {
                s = cast(data[row], String);
                if(s.charAt(col)!=" ")
                {
                    canvas.graphics.drawRect(col*ZOOM, row*ZOOM, ZOOM, ZOOM);
                }
            }
        }
        width = maxColumns * ZOOM;
        height = maxRows*ZOOM;

    }
}