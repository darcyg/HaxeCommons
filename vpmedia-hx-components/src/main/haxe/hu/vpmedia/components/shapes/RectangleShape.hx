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

class RectangleShape extends BaseShape
{
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(parent:DisplayObjectContainer,x:Int,y:Int,width:Float,height:Float,?fill:IBaseGraphicsTexture=null,?stroke:IBaseGraphicsTexture=null, ?drawAfter:Bool=true)
    {        
        type = EShapeType.RECTANGLE;
        super(parent, x, y, width, height, fill, stroke, drawAfter);
    }
    
    override function drawGeometry():Void
    {
        canvas.graphics.drawRect(0, 0, width, height);                    
    }
}