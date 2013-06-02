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

import hu.vpmedia.components.BaseStyleSheet;

class PanelStyleSheet extends BaseStyleSheet
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
        
        setStyle("ellipse",0);
    }
}