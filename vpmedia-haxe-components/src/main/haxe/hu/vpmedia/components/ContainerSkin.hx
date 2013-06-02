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

/**
 * Container
 */
class ContainerSkin extends BaseSkin
{       
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