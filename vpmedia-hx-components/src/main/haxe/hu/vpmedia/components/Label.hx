////////////////////////////////////////////////////////////////////////////////
//=BEGIN MIT LICENSE
//
// The MIT License
// 
// Copyright (c) 2012-2013 Andras Csizmadia
// http://www.vpmedia.eu
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//=END MIT LICENSE
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