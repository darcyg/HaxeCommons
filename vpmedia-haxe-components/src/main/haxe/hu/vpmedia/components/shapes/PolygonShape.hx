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

import flash.display.IGraphicsData;
import flash.display.Graphics;
import flash.display.DisplayObjectContainer;
import flash.display.GraphicsPathWinding;
import flash.Vector;

class PolygonShape extends BaseShape
{
    public var commands:Vector<Int>;
    public var data:Vector<Float>;
    public var winding:GraphicsPathWinding;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(parent:DisplayObjectContainer,x:Int,y:Int,commands:Vector<Int>,data:Vector<Float>,?fill:IBaseGraphicsTexture=null,?stroke:IBaseGraphicsTexture=null, ?drawAfter:Bool=true)
    {        
        type = EShapeType.POLYGON;
        this.commands =commands;
        this.data = data;
        winding = GraphicsPathWinding.NON_ZERO;
        super(parent, x, y, 1, 1, fill, stroke, drawAfter);
    }
    
    override function drawGeometry():Void
    {
        canvas.graphics.drawPath(commands, data, winding);        
    }
}