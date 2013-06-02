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
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.AntiAliasType;
#if flash
import flash.text.GridFitType;
#end
import hu.vpmedia.components.ComponentState;  
import hu.vpmedia.components.BaseStyleSheet;

class LabelStyleSheet extends BaseStyleSheet
{
    public function new()
    {
        super();
    }

    override function initialize():Void
    {      
        setStyle("selectable",false);
        setStyle("multiline",false);
        setStyle("wordWrap",false);
        setStyle("embedFonts",false);
        setStyle("autoSize",TextFieldAutoSize.LEFT);
        setStyle("type", TextFieldType.DYNAMIC);        
        setStyle("antiAliasType",AntiAliasType.ADVANCED);   
        #if flash
        setStyle("gridFitType",GridFitType.SUBPIXEL);
        #end
        setStyle("textFormat:DEFAULT",new TextFormat("Arial", 11, Color.GREY_DARK_1));
    }
}