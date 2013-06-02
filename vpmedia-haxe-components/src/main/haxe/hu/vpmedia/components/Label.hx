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
 * Label
 */
class Label extends BaseComponent implements IBaseTextField
{
    //--------------------------------------
    //  Variables
    //--------------------------------------
    var _currentText:String;
    public var text(get_text, set_text):String;

    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
     * Constructor
     */
    public function new(?parent:Dynamic = null)
    {
        type = ComponentName.LABEL;  
        _currentText = Std.string(type);      
        if (skinClass == null)
        {
            skinClass = LabelSkin;
        }
        super(parent);
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
        //invalidate(ComponentChange.SIZE);
        return _currentText;
    }

     function get_text():String
    {
        return _currentText;
    }
}