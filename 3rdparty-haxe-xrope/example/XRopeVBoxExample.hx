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

import xrope.LayoutAlign;
import xrope.VBoxLayout;
import flash.events.MouseEvent;
import flash.display.Sprite;  
import flash.Lib;

class XRopeVBoxExample extends Sprite {

    var boxLayout : VBoxLayout;

    public function new() {
        super();
        Lib.current.addChild(this);
        var MARGIN : Float = 10;
        var BOX_Y : Float = 25;
        var BOX_WIDTH : Float = 380;
        var BOX_HEIGHT : Float = 350;
        boxLayout = new VBoxLayout(this, BOX_WIDTH, BOX_HEIGHT, MARGIN, BOX_Y);
        boxLayout.useBounds = true;        
        var shapes:Array<Dynamic> = [];
        var i : Int = 0;
        while(i < 40) {
            shapes.push(ExampleHelper.getShape());
            i++;
        }
        boxLayout.add(shapes);
        boxLayout.layout();
        ExampleHelper.fillGroup(boxLayout);

    }

}

