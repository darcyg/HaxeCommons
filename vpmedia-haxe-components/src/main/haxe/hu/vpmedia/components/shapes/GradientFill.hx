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

import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.InterpolationMethod;
import flash.display.SpreadMethod;
import flash.geom.Matrix;
class GradientFill extends BaseGraphicsTexture
{
public var colors:Array<GradientItem>;
public var matrix:Matrix;
public var rotation:Float;
public var type:GradientType;
public var spreadMethod:SpreadMethod;
public var interpolationMethod:InterpolationMethod;
public var focalPtRatio:Float;
public var gradientColors:Array<UInt>;
public var gradientAlphas:Array<Float>;
public var gradientRatios:Array<UInt>;

//--------------------------------------
//  Constructor
//--------------------------------------
public function new(colors:Array<GradientItem>)
{
    super();
    setColors(colors);
    rotation=90;
    focalPtRatio=0;
    type=GradientType.LINEAR;
    spreadMethod=SpreadMethod.PAD;
    interpolationMethod=InterpolationMethod.RGB;
    colorType=EGraphicsTextureType.GRADIENT;
}

public function setColors(value:Array<GradientItem>):Void
{
    colors=value;
    gradientColors=[];
    gradientAlphas=[];
    gradientRatios=[];
    var item:GradientItem;
    var n:Int = value.length;
    for (i in 0...n)
    {
        item=value[i];
        gradientColors.push(item.color);
        gradientAlphas.push(item.alpha);
        gradientRatios.push(item.ratio);
    }
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
    graphics.beginGradientFill(type, gradientColors, gradientAlphas, gradientRatios, matrix, spreadMethod, interpolationMethod, focalPtRatio);
}
}