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

import xrope.HLineLayout;
import xrope.ILayoutGroup;
import xrope.VLineLayout;
import flash.text.TextField;
import flash.display.Sprite;  
import flash.Lib;

class XRopeHLineExample extends Sprite {

    public function new() {
  super();
  Lib.current.addChild(this);
        var topGroup : ILayoutGroup = new VLineLayout(this, 30, 20, 360);
        for(align in ExampleHelper.ALL_ALIGNS/* AS3HX WARNING could not determine type for var: align exp: EField(EIdent(ExampleHelper),ALL_ALIGNS) type: null*/) {
            topGroup.add([new HLineLayout(this, 0, 0, topGroup.width, 35, align, 5, true)]);
        }

        topGroup.layout();
        for(element in topGroup.elements) {
            var subGroup:ILayoutGroup = cast(element, ILayoutGroup);
            fillSubGroup(subGroup);
            ExampleHelper.fillGroup(subGroup);
            titleSubGroup(subGroup);
        }

    }

    function fillSubGroup(target : ILayoutGroup) : Void {
        var shapes:Array<Dynamic> = [];
        var i : Int = 0;
        while(i < 3) {
            shapes.push(ExampleHelper.getShape());
            i++;
        }
        target.add(shapes);
        target.layout();
    }

    function titleSubGroup(target : ILayoutGroup) : Void {
        var alignTf : TextField = new TextField();
        alignTf.text = target.align;
        alignTf.width = alignTf.textWidth + 4;
        alignTf.height = alignTf.textHeight + 4;
    //    XFace.display(alignTf, (target.x - alignTf.width) / 2, target.y + (target.height - alignTf.height) / 2);
    }
}

