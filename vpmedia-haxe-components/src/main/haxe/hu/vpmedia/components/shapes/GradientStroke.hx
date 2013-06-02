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
import flash.geom.Matrix;
class GradientStroke extends GradientFill
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
public function new(colors:Array<GradientItem>,?thickness:Float=1)
{
    super(colors);
    colorType=EGraphicsTextureType.GRADIENT;
    this.thickness=thickness;
    hinting=true;
    scaleMode=LineScaleMode.NONE;
    caps=CapsStyle.NONE;
    joints=JointStyle.MITER;
    miterLimit=3;
}

override function draw(graphics:Graphics):Void
{
    if (colors == null)
    {
        return;    
    }
    if (matrix == null)
    {
        matrix=new Matrix();
    }
    //convert rotation to radians
    var r:Float=rotation * (Math.PI / 180);
    matrix.createGradientBox(_width, _height, r);
    graphics.lineStyle(thickness, 0, 1, hinting, scaleMode, caps, joints, miterLimit);
    graphics.lineGradientStyle(type, gradientColors, gradientAlphas, gradientRatios, matrix, spreadMethod, interpolationMethod, focalPtRatio);
}
}