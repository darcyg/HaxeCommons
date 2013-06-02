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
package hu.vpmedia.components.android;

import flash.text.TextFormat;
import hu.vpmedia.components.BaseStyleSheet;

class ButtonStyleSheet extends BaseStyleSheet
{
    public function new()
    {
        super();
    }

    override function initialize():Void
    {      
        setStyle("bgColor1:DEFAULT",Color.GREY_LIGHT_1);
        setStyle("bgColor2:DEFAULT",Color.GREY_LIGHT_2);
        setStyle("borderColor1:DEFAULT",Color.GREY_LIGHT_1);
        setStyle("borderColor2:DEFAULT", Color.WHITE);
        
        setStyle("bgColor1:OVER",Color.GREY_LIGHT_2);
        setStyle("bgColor2:OVER",Color.GREY_LIGHT_1);
        setStyle("borderColor1:OVER",Color.WHITE);
        setStyle("borderColor2:OVER", Color.GREY_LIGHT_1);
        
        setStyle("bgColor1:DOWN",Color.GREY_DARK_2);
        setStyle("bgColor2:DOWN",Color.GREY_MID_1);
        setStyle("borderColor1:DOWN",Color.GREY_LIGHT_1);
        setStyle("borderColor2:DOWN", Color.GREY_LIGHT_2);
                
        setStyle("textFormat:DEFAULT",new TextFormat("Arial", 11, Color.GREY_MID_1));
        setStyle("textFormat:OVER",new TextFormat("Arial", 11, Color.GREY_MID_2));
        setStyle("textFormat:DOWN",new TextFormat("Arial", 11, Color.WHITE));
        
        setStyle("ellipse",10);
    }
}