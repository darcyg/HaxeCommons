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
/**
 * @author Andras Csizmadia
 * @version 1.0
 */
    
class BaseGraphicsTexture implements IBaseGraphicsTexture
{
private var _width:Float;
private var _height:Float;
public var colorType:EGraphicsTextureType;

//--------------------------------------
//  Constructor
//--------------------------------------
public function new()
{
}

public var width(get, set):Float;
public var height(get, set):Float;

function set_width(value:Float):Float
{
    return _width=value;
}
function get_width():Float
{
    return _width;
}

function set_height(value:Float):Float
{
    return _height=value;
}
function get_height():Float
{
    return _height;
}

public function setSize(w:Float,h:Float):Void
{
    _width = w;
    _height = h;
}

public function draw(graphics:Graphics):Void
{
    // Override
}
}