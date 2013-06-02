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
package hu.vpmedia.components;
import hu.vpmedia.components.shapes.IBaseShape;
import hu.vpmedia.components.shapes.PixelTileShape;
import hu.vpmedia.components.shapes.PixelTiles;
import hu.vpmedia.components.shapes.SolidFill;

/**
 * Icon
 */
class IconSkin extends BaseSkin
{     
    public var icon:IBaseShape;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
    * Constructor
    */
    public function new(owner:BaseComponent)
    {
        super(owner);
    }
    
    override function createChildren():Void
    {
        super.createChildren();     
        
        icon = new PixelTileShape(owner.canvas, 0, 0, PixelTiles.ZOOM_PLUS, new SolidFill(0xFFFFFF));
    }
    
    override function updateData():Void
    {
        super.updateData();
    }
        
    override function updateStyle():Void
    {
        super.updateStyle();
    }
        
    override function updateSize():Void
    {
        super.updateSize();       
    }
}