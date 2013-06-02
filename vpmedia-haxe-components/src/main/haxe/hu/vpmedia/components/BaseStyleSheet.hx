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
 * @author Andras Csizmadia
 * @version 1.0
 */
class BaseStyleSheet
{
   // private var model:Map<String, Dynamic>;
   private var model:Dynamic;

    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new()
    {
        reset();
        initialize();
    }
    
    public function reset()
    {
       // model=new Map();
       model = { };
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
    public function getStyle(value:String):Dynamic
    {
       // return model.get(value);
       return model.value;
    }

    /**
     * Sets a stylesheet
     */
    public function setStyle(name:String, value:Dynamic):Void
    {
        //model.set(name,value);
        model.name = value;
    }
    
    /**
     * Checks for a stylesheet
     */
    public function hasStyle(name:String):Bool
    {
       // return model.exists(name);
       return model.name != null;
    }
}