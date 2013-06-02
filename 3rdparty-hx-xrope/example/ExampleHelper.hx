////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : eidiot <http://eidiot.github.com/xrope/>
// Contributors: Andras Csizmadia -  http://www.vpmedia.eu (HaXe port)
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
package;

import xrope.ILayoutElement;
import xrope.ILayoutGroup;
import xrope.LayoutAlign;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;

class ExampleHelper {

    static public var ALL_ALIGNS : Array<Dynamic> = [LayoutAlign.TOP_LEFT, LayoutAlign.TOP, LayoutAlign.TOP_RIGHT, LayoutAlign.RIGHT, LayoutAlign.BOTTOM_RIGHT, LayoutAlign.BOTTOM, LayoutAlign.BOTTOM_LEFT, LayoutAlign.LEFT, LayoutAlign.CENTER];
    static public function getShape() : Shape {
        var x : Float = 15 - Math.random() * 30;
        var y : Float = 15 - Math.random() * 30;
        var width : Float = 15 + Math.random() * 15;
        var height : Float = 15 + Math.random() * 15;
        var s : Shape = new Shape();
    
            s.graphics.beginFill(Std.int(Math.random() * 0xFFFFFF));
            s.graphics.drawRect(x, y, width, height);
            s.graphics.endFill();

        return s;
    }

    static public function clearGroupGraphics(target : ILayoutGroup) : Void {
        cast((target.container), Sprite).graphics.clear();
    }

    static public function fillGroup(target : ILayoutGroup, color : Int = 0xEEEFF0, alpha : Float = 0.5) : Void {
        var s:Sprite = cast(target.container, Sprite);
    
            s.graphics.beginFill(color, alpha);
            s.graphics.drawRect(target.x, target.y, target.width, target.height);
            s.graphics.endFill();

    }

    static public function drawGroupRim(target : ILayoutGroup, color : Int = 0xBBBBBB) : Void {
  var s:Sprite = cast(target.container, Sprite);
            s.graphics.lineStyle(0, color);
            s.graphics.drawRect(target.x, target.y, target.width, target.height);
    
    }

    static public function drawElementsRim(target : ILayoutGroup, color : Int = 0xBBBBBB) : Void {
        var graphics : Graphics = cast((target.container), Sprite).graphics;
        graphics.lineStyle(0, color);
        for(element in target.elements/* AS3HX WARNING could not determine type for var: element exp: EField(EIdent(target),elements) type: null*/) {
            graphics.drawRect(element.x, element.y, element.width, element.height);
        }

    }


    public function new() {
    }
}

