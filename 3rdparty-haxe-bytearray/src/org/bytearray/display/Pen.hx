////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Didier Brun - www.foxaweb.com
// Contributors: 
//              Thibault Imbert - http://www.bytearray.org
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

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.ui.Mouse;

class Pen extends MovieClip {

    var __isDown : Bool;
    var __canvas : Sprite;
    var __nFrame : Int;
    var __nIndex : Int;
    static var __arrayColors : Array<Int> = [0x5BBA48, 0xEA312F, 0x00B7F1, 0xFFF035, 0xD86EA3, 0xFBAE34];
    function new() {
        super();
    addEventListener(Event.ADDED_TO_STAGE, onAdded);
        __nFrame = 0;
        __nIndex = 1;
    }

    function onAdded(pEvt : Event) : Void {
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
        stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
    }

    function onMove(pEvt : MouseEvent) : Void {
        var posMouseX : Float = pEvt.stageX;
        var posMouseY : Float = pEvt.stageY;
        var limitY : Float = 140;
        if(!(posMouseX > 450 && posMouseY > 370))  {
            Mouse.hide();
            x = posMouseX;
            y = posMouseY;
            pEvt.updateAfterEvent();
            rotation -= ((posMouseY < limitY)) ? (rotation - (limitY - posMouseY)) * .09 : (rotation - 0) * .1;
            if(__isDown) 
                __canvas.graphics.lineTo(posMouseX, posMouseY);
        }

        else Mouse.show();
    }

    function onDown(pEvt : MouseEvent) : Void {
        var posMouseX : Float = pEvt.stageX;
        var posMouseY : Float = pEvt.stageY;
        __canvas.graphics.lineStyle(4, __arrayColors[__nIndex - 1], 1);
        __canvas.graphics.moveTo(posMouseX, posMouseY);
        __isDown = true;
    }

    function onUp(pEvt : MouseEvent) : Void {
        __isDown = false;
    }

    function onWheel(pEvt : MouseEvent) : Void {
        this.gotoAndStop(__nIndex = (++__nFrame % totalFrames) + 1);
    }

    public function setView(pView : Sprite) : Void {
        __canvas = pView;
    }

}

