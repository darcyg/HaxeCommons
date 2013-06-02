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
package hu.vpmedia.crypt;

import flash.utils.ByteArray;
class Hex
{
/**
 * Support straight hex, or colon-laced hex.
 * (that means 23:03:0e:f0, but *NOT* 23:3:e:f0)
 * Whitespace characters are ignored.
 */
public static function toArray(hex:String):ByteArray
{
    var ereg:EReg = ~/\s|:/gm;
    hex=ereg.replace(hex, '');
    var a:ByteArray=new ByteArray();
    if (hex.length & 1 == 1)
    hex = "0" + hex;
    var i:Int = 0;
    while (i < hex.length)
    {
        a[Std.int(i / 2)] = Std.parseInt(hex.substr(i, 2));
        i += 2;
    }
    return a;
}

public static function fromArray(array:ByteArray, colons:Bool=false):String
{
    var s:String="";
    for (i in 0...array.length)
    {
    s+=("0" + StringTools.hex(array[i])).substr(-2, 2);
    if (colons)
    {
        if (i < Std.int(array.length - 1))
        s+=":";
    }
    }
    return s;
}

/**
 *
 * @param hex
 * @return a UTF-8 string decoded from hex
 *
 */
public static function toString(hex:String):String
{
    var a:ByteArray=toArray(hex);
    return a.readUTFBytes(a.length);
}

/**
 *
 * @param str
 * @return a hex string encoded from the UTF-8 string str
 *
 */
public static function fromString(str:String, colons:Bool=false):String
{
    var a:ByteArray=new ByteArray();
    a.writeUTFBytes(str);
    return fromArray(a, colons);
}
}