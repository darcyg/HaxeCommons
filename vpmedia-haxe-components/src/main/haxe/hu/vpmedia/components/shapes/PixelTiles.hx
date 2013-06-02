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
package hu.vpmedia.components.shapes;

class PixelTiles
{
    public static var ARROW_1_UP:Array<String>   =["   *   ", "  ***  ", " ***** ", "*******"];
    public static var ARROW_1_DOWN:Array<String> =["*******", " ***** ", "  ***  ", "   *   "];
    public static var ARROW_2_UP:Array<String>   =["  *  ", " * * ", "*   *"];
    public static var ARROW_2_DOWN:Array<String> =["*   *", " * * ", "  *  "];
    public static var ARROW_2_LEFT:Array<String> =["  *", " * ", "*  ", " * ", "  *"];
    public static var ARROW_2_RIGHT:Array<String>=["*  ", " * ", "  *", " * ", "*  "];
    public static var ZOOM_PLUS:Array<String>    =["  *  ", "  *  ", "*****", "  *  ", "  *  "];
    public static var ZOOM_MINUS:Array<String>   =["     ", "     ", "*****", "     ", "     "];
    public static var ZOOM_DEFAULT:Array<String> =["   *   ", "  * *  ", " *   * ", "*  *  *", " *   * ", "  * *  ", "   *   "];
    public static var SCROLL_GRIP:Array<String>  =["*******", "       ", "*******", "       ", "*******", "       ", "*******", "       ", "*******"];
}