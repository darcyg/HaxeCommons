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

import hu.vpmedia.components.BaseSkin;

/**
 * @author Andras Csizmadia
 * @version 1.0
 */
class BaseTheme
{
    private var model:Map<String, BaseStyleSheet>;

    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new()
    {
        model=new Map();
        initialize();
    }

    //--------------------------------------
    //  Private(protected)
    //--------------------------------------
    /**
     * Abstract
     */
    function initialize():Void
    {
        // override with own stylesheets
    }

    //--------------------------------------
    //  Public
    //--------------------------------------
    /**
     * Gets a stylesheet
     */
    public function getStyle(value:String):BaseStyleSheet
    {
        return model.get(value);
    }

    /**
     * Sets a stylesheet
     */
    public function setStyle(name:String, value:BaseStyleSheet):Void
    {
        model.set(name,value);
    }
    
    /**
     * Checks for a stylesheet
     */
    public function hasStyle(name:String):Bool
    {
        return model.exists(name);
    }
}