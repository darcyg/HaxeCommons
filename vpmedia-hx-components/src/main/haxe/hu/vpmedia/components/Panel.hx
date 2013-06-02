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
 * Panel
 */
class Panel extends BaseComponent
{       
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
    * Constructor
    */
    public function new(?parent:Dynamic = null, ?width:Float=100,?height:Float=20)
    {
        type = ComponentName.ICON;
        if (skinClass == null)
        {
            skinClass = PanelSkin;
        }
        super(parent, width, height);
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