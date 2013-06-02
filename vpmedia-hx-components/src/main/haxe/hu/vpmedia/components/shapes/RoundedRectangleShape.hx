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

class RoundedRectangleShape extends BaseShape
{    
    public var ellipse:Float;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(parent:DisplayObjectContainer,x:Int,y:Int,width:Float,height:Float,ellipse:Float,?fill:IBaseGraphicsTexture=null,?stroke:IBaseGraphicsTexture=null, ?drawAfter:Bool=true)
    {        
        type = EShapeType.ROUNDED_RECTANGLE;
        this.ellipse = ellipse;
        super(parent, x, y, width, height, fill, stroke, drawAfter);
    }
    
    override function drawGeometry():Void
    {
        canvas.graphics.drawRoundRect(0,0,width,height,ellipse,ellipse);        
    }
}