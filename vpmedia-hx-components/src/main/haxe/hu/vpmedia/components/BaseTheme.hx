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

import hu.vpmedia.components.BaseSkin;

/**
 * @author Andras Csizmadia
 * @version 1.0
 */
class BaseTheme
{
    private var model:Map<String, BaseStyleSheet>;

    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new()
    {
        model=new Map();
        initialize();
    }

    //--------------------------------------
    //  Private(protected)
    //--------------------------------------
    /**
     * Abstract
     */
    function initialize():Void
    {
        // override with own stylesheets
    }

    //--------------------------------------
    //  Public
    //--------------------------------------
    /**
     * Gets a stylesheet
     */
    public function getStyle(value:String):BaseStyleSheet
    {
        return model.get(value);
    }

    /**
     * Sets a stylesheet
     */
    public function setStyle(name:String, value:BaseStyleSheet):Void
    {
        model.set(name,value);
    }
    
    /**
     * Checks for a stylesheet
     */
    public function hasStyle(name:String):Bool
    {
        return model.exists(name);
    }
}