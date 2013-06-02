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
import xrope.ILayoutElement;
import xrope.LayoutAlign;
import xrope.VLineLayout;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;  
import flash.Lib;

class XRopeFormExample extends Sprite{

    public function new() {
  super();
    Lib.current.addChild(this);

        var topGroup : VLineLayout = new VLineLayout(this, 10, 10);
        addLine(topGroup);
        addLine(topGroup);
        addLine(topGroup);
        addLine(topGroup);
        addLine(topGroup);
        topGroup.layout();
    }

    function getLabel(text : String, w : Float = -1) : DisplayObject {
        var tf : TextField = new TextField();
        tf.text = text;
        tf.width = w > (0) ? w : tf.textWidth + 4;
        tf.height = tf.textHeight + 4;
        tf.mouseEnabled = false;
        return tf;
    }

    function getInput(w : Float = 200, h : Float = 20) : DisplayObject {
        var result : Shape = new Shape();
        result.graphics.beginFill(0xFFCDFF);
        result.graphics.drawRoundRect(0, 0, w, h, 10,10);
        result.graphics.endFill();
    return result;
    }

    function getButton(label : String) : DisplayObject {
        var result : Sprite = new Sprite();
        result.graphics.beginFill(0xFFCDFF);
        result.graphics.drawRoundRect(0, 0, 80, 20, 5,5);
        result.graphics.endFill();
        
        var layout : HLineLayout = new HLineLayout(result, 0, 0, result.width, result.height, LayoutAlign.CENTER);
        layout.add([getLabel(label)]);
        layout.layout();
        return result;
    }

    function addLine(group : ILayoutGroup,elements:Array<ILayoutElement>=null) : HLineLayout {
        var result : HLineLayout = new HLineLayout(group.container, 0, 0, group.width, -1, LayoutAlign.CENTER);
    /*    for(element in elements) {
            result.add(element);
        }  */
        result.add(elements);

        result.layout();
        group.add([result]);
        return result;
    }

}

