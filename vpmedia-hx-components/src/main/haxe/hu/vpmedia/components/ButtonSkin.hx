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

import flash.display.Sprite;
import flash.text.TextField;

/**
 * Label class(textfield wrapper)
 */
class ButtonSkin extends BaseSkin
{
    public var background:Panel;
    public var icon:Icon;
    public var label:Label;
    
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
        
        owner.canvas.buttonMode = true;
        owner.canvas.mouseChildren = false;
        
        // Background
        background = new Panel(owner, owner.width, owner.height);
        background.addStatesFrom(owner);
       ///*                 
        // Label
        label = new Label(owner);
        label.addStatesFrom(owner);
                
        // Icon
        icon = new Icon(owner);
        //*/
        //icon.addStatesFrom(owner);
        //icon = new Icon(content);
        //icon.setParent(owner);       
    }
    
    override function updateData():Void
    {
        super.updateData();
       ///* 
        label.text = cast(owner, IBaseTextField).text;
        label.invalidate(ComponentChange.DATA, true, false);
        //*/
    }
    
    override function updateStyle():Void
    { 
        super.updateStyle();
        
        //background.draw();
       /* background.setStyle("bgColor1",owner.getStyleValue("bgColor1", true),true);
        background.setStyle("bgColor2",owner.getStyleValue("bgColor2", true),true);
        background.setStyle("borderColor1",owner.getStyleValue("borderColor1", true),true);
        background.setStyle("borderColor2",owner.getStyleValue("borderColor2", true),true);*/
    }
    
    override function updateState():Void
    {
        setCurrentStateToChilds();
    }
    
    override function updateSize():Void
    {       
        super.updateSize();
        
        background.width = owner.width;
        background.height = owner.height;
      // /*         
        label.x = (owner.width - label.canvas.width) / 2;
        label.y = (owner.height - label.canvas.height) / 2;
        
        icon.x = label.x - icon.canvas.width - 5;
        icon.y = (owner.height - icon.canvas.height) / 2;
        //*/
    }
}