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
class Container extends BaseComponent
{       
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
    * Constructor
    */
    public function new(?parent:Dynamic = null)
    {
        type = ComponentName.CONTAINER;
        if (skinClass == null)
        {
            skinClass = ContainerSkin;
        }
        super(parent);
    }
    
    //--------------------------------------
    //  Core
    //--------------------------------------
    
    override function initStates():Void
    {
    }
    
    override function initBehaviors():Void
    {
    }       
    
}