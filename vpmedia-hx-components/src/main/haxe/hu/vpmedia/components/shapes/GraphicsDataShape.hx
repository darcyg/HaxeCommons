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
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
import flash.display.IGraphicsData;
import flash.Vector;
import hu.vpmedia.framework.BaseDisplayObject;

/*
 * http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/display/Graphics.html#drawGraphicsData%28%29 
 */
class GraphicsDataShape extends BaseDisplayObject implements IBaseShape
{    
    public var data:Vector<IGraphicsData>;
    
    public var type:EShapeType;
    
    public var fill:IBaseGraphicsTexture;
    public var stroke:IBaseGraphicsTexture;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(parent:DisplayObjectContainer,x:Int,y:Int,data:Vector<IGraphicsData>, ?drawAfter:Bool=true)
    {   
        super();
        type = EShapeType.GRAPHICS_DATA;
        this.data = data;
        
        canvas=new Sprite();
        move(x, y);
        parent.addChild(canvas);
        if(drawAfter)
        {
            draw();
        }
    }
        
    public function clear():Void
    {
        canvas.graphics.clear();
    }
            
    public function draw():Void
    {
        canvas.graphics.clear();
        canvas.graphics.drawGraphicsData(data);        
    }
}