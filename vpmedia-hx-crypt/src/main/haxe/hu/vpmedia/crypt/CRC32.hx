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
/**
 * Computes CRC32 data checksum of a data stream.
 * The actual CRC32 algorithm is described in RFC 1952
 * (GZIP file format specification version 4.3).
 */
class CRC32
{
/** The crc data checksum so far. */
private var crc:Int;
/** The fast CRC table. Computed once when the CRC32 class is loaded. */
private static var crcTable:Array<Int>=makeCrcTable();

public function new():Void
{
}

/** Make the table for a fast CRC. */
private static function makeCrcTable():Array<Int>
{
    var crcTable:Array<Int>=new Array();//new Array(256);
    for (n in 0...256)
    {
    var c:Int=n;
    var k:Int=8;
    while (k>=0 )
    {
        if ((c & 1) != 0)
        c=0xedb88320 ^ (c >>> 1);
        else
        c = c >>> 1;
        k--;
    }
    crcTable[n]=c;
    }
    return crcTable;
}

/**
 * Returns the CRC32 data checksum computed so far.
 */
public function getValue():Int
{
    return crc & 0xffffffff;
}

/**
 * Resets the CRC32 data checksum as if no update was ever called.
 */
public function reset():Void
{
    crc=0;
}

/**
 * Adds the complete byte array to the data checksum.
 *
 * @param buf the buffer which contains the data
 */
public function update(buf:ByteArray):Void
{
    var off:Int=0;
    var len:Int=buf.length;
    var c:Int=~crc;
    while (--len >= 0)
    c=crcTable[(c ^ buf[off++]) & 0xff] ^ (c >>> 8);
    crc=~c;
}
}