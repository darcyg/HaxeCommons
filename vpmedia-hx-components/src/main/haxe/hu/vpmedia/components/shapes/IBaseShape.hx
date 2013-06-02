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

import flash.display.Sprite;
import hu.vpmedia.framework.IBaseTransformable;

interface IBaseShape extends IBaseTransformable
{
    var type:EShapeType;
    var fill:IBaseGraphicsTexture;
    var stroke:IBaseGraphicsTexture;
    function draw():Void;
}