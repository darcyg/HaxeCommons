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
class SolidFill extends BaseGraphicsTexture
{
    public var alpha:Float;
    public var color:Int;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(?color:Int=0x000000,?alpha:Float=1)
    {
        super();
        this.alpha=alpha;
        this.color=color;
        colorType=EGraphicsTextureType.SOLID;
    }
    
    override function draw(graphics:Graphics):Void
    {
        graphics.beginFill(color, alpha);
    }
}