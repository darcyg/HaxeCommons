////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012-2013, Original author & contributors
// Original author : www.nocircleno.com/graffiti/
// Contributors: Andras Csizmadia <andras@vpmedia.eu>
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////
package com.nocircleno.graffiti.tools;
/**
* Class provides constant values used to define the types of shapes available.
*
* @langversion 3.0
* @playerversion Flash 10 AIR 1.5 
*/
class ShapeType {
    /**
    * Rectangle Shape
    */    
    static public inline var RECTANGLE : String = "rectangle";
    /**
    * Square Shape
    */    
    static public inline var SQUARE : String = "square";
    /**
    * Oval Shape
    */    
    static public inline var OVAL : String = "oval";
    /**
    * Circle Shape
    */    
    static public inline var CIRCLE : String = "circle";
    /**
    * The <code>validType</code> method is used to validate a shape type.
    * 
    * @param type String to check to see if it is a valid Shape Type.
    * 
    */    
    static public function validType(type : String) : Bool {
        var valid : Bool = false;
        if(type == ShapeType.RECTANGLE || type == ShapeType.SQUARE || type == ShapeType.OVAL || type == ShapeType.CIRCLE)  {
            valid = true;
        }
        return valid;
    }
}