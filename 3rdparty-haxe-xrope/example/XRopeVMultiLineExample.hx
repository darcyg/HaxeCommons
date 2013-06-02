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

import xrope.ILayoutGroup;
import xrope.LayoutAlign;
import xrope.VMultiLineLayout;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Sprite;  
import flash.Lib;

class XRopeVMultiLineExample extends Sprite {

    var multiLineLayout : VMultiLineLayout;
    //var drawLineSelector : CheckBox;
    public function new()  {
  super();
  Lib.current.addChild(this);
        var MARGIN : Float = 10;
        var BOX_Y : Float = 50;
        var BOX_WIDTH : Float = 380;
        var BOX_HEIGHT : Float = 330;
        var LINE_WIDTH : Float = 50;
        multiLineLayout = new VMultiLineLayout(this, BOX_WIDTH, BOX_HEIGHT, LINE_WIDTH, MARGIN, BOX_Y);
        multiLineLayout.useBounds = true;
        var shapes:Array<Dynamic> = [];
    var i : Int = 0;
        while(i < 50) {
            shapes.push(ExampleHelper.getShape());
            i++;
        } 
    multiLineLayout.add(shapes);
        multiLineLayout.layout();
        drawGroups();
    }

    function drawGroups() : Void {
        ExampleHelper.clearGroupGraphics(multiLineLayout);
        ExampleHelper.fillGroup(multiLineLayout);
        //if(drawLineSelector.selected)  {
            for(line in multiLineLayout.lines/* AS3HX WARNING could not determine type for var: line exp: EField(EIdent(multiLineLayout),lines) type: null*/) {
                ExampleHelper.drawGroupRim(line);
            }

        //}
    }  

}

