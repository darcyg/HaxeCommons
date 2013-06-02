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
interface IBaseGraphicsTexture
{
    var width(get,set):Float;
    var height(get, set):Float;
    function setSize(width:Float, height:Float):Void;

    var colorType:EGraphicsTextureType;
    function draw(graphics:Graphics):Void;
}