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
 * Button
 */
class Button extends BaseComponent implements IBaseTextField
{
    var _currentText:String;
        
    public var text(get_text, set_text):String;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
     * Constructor
     */
    public function new(?parent:Dynamic = null, ?width:Float=100,?height:Float=20)
    {
        type = ComponentName.BUTTON;
        _currentText = Std.string(type);
        _width = width;
        _height = height;
        if (skinClass == null)
        {
            skinClass = ButtonSkin;
        }
        super(parent, width, height);
    }

    //--------------------------------------
    //  Core
    //--------------------------------------
    
    override function initStates():Void
    {        
        addState(ComponentState.OVER);
        addState(ComponentState.DOWN);
        addState(ComponentState.DISABLED);
    }
    
    override function initBehaviors():Void
    {
        addBehavior(new MouseBehavior(this));
    }
    
    //--------------------------------------
    //  Getters/setters
    //--------------------------------------
    /**
     * Sets label
     * @param value String
     */
    function set_text(value:String):String
    {
        //trace(this, "set", "text", value);
        if(_currentText==value)
        {
            return _currentText;
        }
        _currentText=value;
        invalidate(ComponentChange.DATA);
        return _currentText;
    }

     function get_text():String
    {
        return _currentText;
    }
    
}