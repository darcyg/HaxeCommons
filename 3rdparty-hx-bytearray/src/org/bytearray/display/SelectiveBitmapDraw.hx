////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Moses Gunesch
// Original author : Didier BRUN -  http://www.bytearray.org
// Contributors: 
//              Andras Csizmadia -  http://www.vpmedia.eu
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
package org.bytearray.display;

import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.IBitmapDrawable;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
//import flash.utils.Dictionary;
import openfl.ObjectHash;
/**
 * Allows the capture of selective children within a DisplayObject.
 * 
 * <p>It works by toggling visibility off for other children,
 * then immediately restoring their visibility after draw().</p>
 * 
 * @version 1.0
 * @author moses gunesch
 */class SelectiveBitmapDraw {

    public var bitmapData : BitmapData;
    var protectedNodes : ObjectHash<Dynamic,Dynamic>;
    var nodesToggled : ObjectHash<Dynamic,Dynamic>;
    public function new(bitmapData : BitmapData) {
        protectedNodes = new ObjectHash();
        nodesToggled = new ObjectHash();
        this.bitmapData = bitmapData;
    }

    public function draw(source : IBitmapDrawable, selectiveChildren : Array<Dynamic>, matrix : Matrix = null, colorTransform : ColorTransform = null, blendMode : String = null, clipRect : Rectangle = null, smoothing : Bool = false) : Void {
        var protectCount : Int = protectNodes(source, selectiveChildren);
        prepareNodes(source);
        bitmapData.draw(source, matrix, colorTransform, blendMode, clipRect, smoothing);
        restoreNodes();
    }

    function protectNodes(source : Dynamic, selectiveChildren : Array<Dynamic>) : Int {
        var protectCount : Int = 0;
        for(node in selectiveChildren/* AS3HX WARNING could not determine type for var: node exp: EIdent(selectiveChildren) type: Array<Dynamic>*/) {
            if(node == source)  {
                continue;
            }
            do {
                if(protectedNodes[node] == null)  {
                    protectedNodes[node] = 1;
                    protectCount++;
                }
                node = ((node.hasOwnProperty("parent")) ? node.parent : null);
            }
while((node != null));
        }

        return protectCount;
    }

    function prepareNodes(target : Dynamic) : Void {
        if((Std.is(target, DisplayObjectContainer)) == false)  {
            return;
        }
        var node : Dynamic;
        var i : Int = 0;
        while(i < target.numChildren) {
            node = target.getChildAt(i);
            if(Reflect.field(protectedNodes, Std.string(node)) == null)  {
                if(node.visible == false)  {
                    // ignore already-invisible nodes
                     {
                        i++;
                        continue;
                    }
                }
                Reflect.setField(nodesToggled, Std.string(node), 1);
                node.visible = false;
            }
            if(Std.is(node, DisplayObjectContainer && node.numChildren > 0))  {
                prepareNodes(node);
            }
            i++;
        }
    }

    function restoreNodes() : Void {
        if(nodesToggled == null)  {
            return;
        }
        var target : Dynamic;
        for(target in Reflect.fields(nodesToggled)) {
            target.visible = true;
            nodesToggled.remove(target);
            //delete Reflect.field(nodesToggled, Std.string(target));
        }

        for(target in Reflect.fields(protectedNodes)) {
            protectedNodes.remove(target);
            //delete Reflect.field(protectedNodes, Std.string(target));
        }

    }

}

