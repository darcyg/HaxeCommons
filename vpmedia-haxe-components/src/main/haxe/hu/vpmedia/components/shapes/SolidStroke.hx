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

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
class SolidStroke extends SolidFill
{
    public var thickness:Float;
    public var hinting:Bool;
    public var scaleMode:LineScaleMode;
    public var caps:CapsStyle;
    public var joints:JointStyle;
    public var miterLimit:Float;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(?color:Int=0x000000,?thickness:Float=1,?alpha:Float=1)
    {
        super(color,alpha);
        colorType=EGraphicsTextureType.SOLID;
        this.thickness=thickness;
        hinting=true;
        scaleMode=LineScaleMode.NONE;
        caps=CapsStyle.NONE;
        joints=JointStyle.MITER;
        miterLimit=3;
    }
    
    override function draw(graphics:Graphics):Void
    {
        graphics.lineStyle(thickness, color, alpha, hinting, scaleMode, caps, joints, miterLimit);
    }
}