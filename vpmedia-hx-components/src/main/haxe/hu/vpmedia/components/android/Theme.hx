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

import hu.vpmedia.components.BaseComponent;
import hu.vpmedia.components.ButtonSkin;
import hu.vpmedia.components.LabelSkin;
import hu.vpmedia.components.PanelSkin;

// Themes should be: Simple, DesktopOSX, DesktopWin, DesktopLin, MobileAndroid, MobileIOS, MobileWin
class Theme extends BaseTheme
{
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new()
    {
        super();
    }

    //--------------------------------------
    //  Private
    //--------------------------------------
    override function initialize():Void
    {
        setStyle("hu.vpmedia.components.LabelSkin",new LabelStyleSheet());
        setStyle("hu.vpmedia.components.ButtonSkin",new ButtonStyleSheet());
        setStyle("hu.vpmedia.components.PanelSkin",new PanelStyleSheet());
    }
}