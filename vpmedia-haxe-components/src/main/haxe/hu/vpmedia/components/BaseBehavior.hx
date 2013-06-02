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

class BaseBehavior
{
    var owner:BaseComponent;
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(owner:BaseComponent)
    {
        this.owner = owner;
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
    }
    
    public function dispose():Void
    {
    }

}