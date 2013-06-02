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
import flash.display.BitmapData;
import flash.geom.Matrix;
class BitmapFill extends BaseGraphicsTexture
{
    public var bitmapData:BitmapData;
    public var matrix:Matrix;
    public var repeat:Bool;
    public var smooth:Bool;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new()
    {
        super();
        matrix=new Matrix();
        colorType=EGraphicsTextureType.BITMAP;
    }
    
    //--------------------------------------
    //  Public
    //--------------------------------------
    override function draw(graphics:Graphics):Void
    {
        graphics.beginBitmapFill(bitmapData, matrix, repeat, smooth);
    }
}