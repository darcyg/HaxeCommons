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

import xrope.AlignLayout;
import xrope.LayoutAlign;
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.display.Sprite;  
import flash.Lib;

class XRopeAlignExample extends Sprite{

    public function new() {
  super();
    Lib.current.addChild(this);

        var group : AlignLayout = new AlignLayout(this, 380, 380, 10, 10);
        group.addTo(getLabel("Name"), LayoutAlign.TOP_LEFT);
        group.addTo(getLabel("Logo"), LayoutAlign.TOP_LEFT);
        group.addTo(getLabel("Navigator 2"), LayoutAlign.TOP_RIGHT);
        group.addTo(getLabel("Navigator 1"), LayoutAlign.TOP_RIGHT);
        group.addTo(getLabel("Content"), LayoutAlign.CENTER);
        group.addTo(getLabel("Footer"), LayoutAlign.BOTTOM);
        group.addTo(getLabel("Copy Right"), LayoutAlign.BOTTOM_RIGHT);
        group.layout();
        ExampleHelper.fillGroup(group);
    }

    function getLabel(text : String, w : Float = -1) : DisplayObject {
        var tf : TextField = new TextField();
        tf.text = text;
        tf.width = w > (0) ? w : tf.textWidth + 4;
        tf.height = tf.textHeight + 4;
        tf.mouseEnabled = false;
        return tf;
    }
}

