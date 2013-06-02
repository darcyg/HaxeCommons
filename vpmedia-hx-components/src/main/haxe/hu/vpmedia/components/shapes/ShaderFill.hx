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
import flash.display.Shader;
import flash.geom.Matrix;
class ShaderFill extends BaseGraphicsTexture
{
public var shader:Shader;
public var matrix:Matrix;

//--------------------------------------
//  Constructor
//--------------------------------------
public function new()
{
    super();
    matrix=new Matrix();
    colorType=EGraphicsTextureType.SHADER;
}

override function draw(graphics:Graphics):Void
{
    graphics.beginShaderFill(shader, matrix);
    graphics.endFill();
}
}