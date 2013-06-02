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

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
/**
 * Label class(textfield wrapper)
 */
class LabelSkin extends BaseSkin
{
    public var textField:TextField;
    
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
            
        textField = new TextField();
        owner.addChild(textField);         
    }
    
    override function updateData():Void
    {
        super.updateData();
        
        textField.htmlText = cast(owner, IBaseTextField).text;  
        //trace(textField.text);
    }
        
    override function updateStyle():Void
    {
        super.updateStyle();
        
        textField.selectable = owner.getStyleValue("selectable");
        textField.multiline = owner.getStyleValue("multiline");
        textField.defaultTextFormat = owner.getStyleValue("textFormat",true);
        textField.setTextFormat(owner.getStyleValue("textFormat",true));
        textField.autoSize = owner.getStyleValue("autoSize");
        textField.type = owner.getStyleValue("type");
        
       /* if (textField.autoSize != TextFieldAutoSize.NONE)
        {
            owner.invalidate(ComponentChange.SIZE);
        }*/
    }
        
    override function updateSize():Void
    {
        super.updateSize();
        
        if (textField.autoSize == TextFieldAutoSize.NONE)
        {
            textField.width = owner.width;
            textField.height = owner.height;    
        }        
    }
}