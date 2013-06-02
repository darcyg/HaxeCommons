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
class ARC4
{
private var i:Int;
private var j:Int;
private var S:ByteArray;
private static inline var psize:Int=256;

public function new(key:ByteArray=null)
{
    i = 0;
    j = 0;    
    S=new ByteArray();
    if (key != null)
    {
        init(key);
    }
}

public function getPoolSize():Int
{
    return psize;
}

public function init(key:ByteArray):Void
{
    var i:Int;
    var j:Int;
    var t:Int;
    for (i in 0...256)
    {
    S[i]=i;
    }
    j=0;
    for (i in 0...256)
    {
    j=(j + S[i] + key[i % key.length]) & 255;
    t=S[i];
    S[i]=S[j];
    S[j]=t;
    }
    this.i=0;
    this.j=0;
}

public function next():Int
{
    var t:Int;
    i=(i + 1) & 255;
    j=(j + S[i]) & 255;
    t=S[i];
    S[i]=S[j];
    S[j]=t;
    return S[(t + S[i]) & 255];
}

public function getBlockSize():Int
{
    return 1;
}

public function encrypt(block:ByteArray):Void
{
    var i:Int = 0;
    var n:Int = Std.int(block.length);
    while (i < n)
    {
    block[i++]^=next();
    }
}

public function decrypt(block:ByteArray):Void
{
    encrypt(block); // the beauty of XOR.
}

public function dispose():Void
{
    var i:Int=0;
    if (S != null)
    {
    for (i in 0...S.length)
    {
        S[i]=Std.int(Math.random() * 256);
    }
    S.length=0;
    S=null;
    }
    this.i=0;
    this.j=0;
}

public function toString():String
{
    return "rc4";
}
}