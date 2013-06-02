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

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.events.MouseEvent;
import flash.display.InteractiveObject;
import flash.display.Stage;

class MouseGesture extends EventDispatcher {

    // ------------------------------------------------
        //
        // ---o static
        //
        // ------------------------------------------------
        static public inline var DEFAULT_NB_SECTORS : Int = 8;
    // Number of sectors
        static public inline var DEFAULT_TIME_STEP : Int = 20;
    // Capture interval in ms
        static public inline var DEFAULT_PRECISION : Int = 8;
    // Precision of catpure in pixels
        static public inline var DEFAULT_FIABILITY : Int = 30;
    // Default fiability level
        // ------------------------------------------------
        //
        // ---o properties
        //
        // ------------------------------------------------
        var moves : Array<Dynamic>;
    // Mouse gestures
        var lastPoint : Point;
    // Last mouse point
        var mouseZone : InteractiveObject;
    // Mouse zone
        var captureDepth : Int;
    // Current capture depth
        var gestures : Array<Dynamic>;
    // Gestures to match
        var rect : Dynamic;
    // Rectangle zone
        var points : Array<Dynamic>;
    // Mouse points
        var timer : Timer;
    // Timer
        var sectorRad : Float;
    // Angle of one sector
        var anglesMap : Array<Dynamic>;
    // Angles map
        // ------------------------------------------------
        //
        // ---o constructor
        //
        // ------------------------------------------------
        function new(pZone : InteractiveObject) {
        // parametters
        mouseZone = pZone;
        // initialization
        init();
    }

    // ------------------------------------------------
        //
        // ---o public methods
        //
        // ------------------------------------------------
        /**

    *    Add a gesture

    */    public function addGesture(o : Dynamic, gesture : String, matchHandler : Dynamic = null) : Void {
        var g : Array<Dynamic> = [];
        var i : Int = 0;
        while(i < gesture.length) {
            g.push(gesture.charAt(i) == (".") ? -1 : parseInt(gesture.charAt(i), 16));
            i++;
        }
        gestures.push({
            datas : o,
            moves : g,
            match : matchHandler,

        });
    }

    // ------------------------------------------------
        //
        // ---o private methods
        //
        // ------------------------------------------------
        /**

    *    Initialisation

    */    function init() : Void {
        // Build the angles map
        buildAnglesMap();
        // Timer
        timer = new Timer(DEFAULT_TIME_STEP);
        timer.addEventListener(TimerEvent.TIMER, captureHandler, false, 0, true);
        // Gesture Spots
        gestures = [];
        // Mouse Events
        mouseZone.addEventListener(MouseEvent.MOUSE_DOWN, startCapture, false, 0, true);
        mouseZone.addEventListener(MouseEvent.MOUSE_UP, stopCapture, false, 0, true);
    }

    /**

    *    Build the angles map

    */    function buildAnglesMap() : Void {
        // Angle of one sector
        sectorRad = Math.PI * 2 / DEFAULT_NB_SECTORS;
        // map containing sectors no from 0 to PI*2
        anglesMap = [];
        // the precision is Math.PI*2/100
        var step : Float = Math.PI * 2 / 100;
        // memorize sectors
        var sector : Float;
        var i : Float = -sectorRad / 2;
        while(i <= Math.PI * 2 - sectorRad / 2) {
            sector = Math.floor((i + sectorRad / 2) / sectorRad);
            anglesMap.push(sector);
            i += step;
        }
    }

    /**

    *    Time Handler

    */    function captureHandler(e : TimerEvent) : Void {
        // calcul dif
        var msx : Int = mouseZone.mouseX;
        var msy : Int = mouseZone.mouseY;
        var difx : Int = msx - lastPoint.x;
        var dify : Int = msy - lastPoint.y;
        var sqDist : Float = difx * difx + dify * dify;
        var sqPrec : Float = DEFAULT_PRECISION * DEFAULT_PRECISION;
        if(sqDist > sqPrec)  {
            points.push(new Point(msx, msy));
            addMove(difx, dify);
            lastPoint.x = msx;
            lastPoint.y = msy;
            if(msx < rect.minx) 
                rect.minx = msx;
            if(msx > rect.maxx) 
                rect.maxx = msx;
            if(msy < rect.miny) 
                rect.miny = msy;
            if(msy > rect.maxy) 
                rect.maxy = msy;
        }
        // event
        dispatchEvent(new GestureEvent(GestureEvent.CAPTURING));
    }

    /**

    *    Add a move 

    */    function addMove(dx : Int, dy : Int) : Void {
        var angle : Float = Math.atan2(dy, dx) + sectorRad / 2;
        if(angle < 0) 
            angle += Math.PI * 2;
        var no : Int = Math.floor(angle / (Math.PI * 2) * 100);
        moves.push(anglesMap[no]);
    }

    /**

    *    Start the capture phase

    */    function startCapture(e : MouseEvent) : Void {
        // moves
        moves = [];
        points = [];
        rect = {
            minx : Number.POSITIVE_INFINITY,
            maxx : Number.NEGATIVE_INFINITY,
            miny : Number.POSITIVE_INFINITY,
            maxy : Number.NEGATIVE_INFINITY,

        };
        // event
        dispatchEvent(new GestureEvent(GestureEvent.START_CAPTURE));
        // last point
        lastPoint = new Point(mouseZone.mouseX, mouseZone.mouseY);
        // start the timer
        timer.start();
    }

    /**

    *    Stop the capture phase

    */    function stopCapture(e : MouseEvent) : Void {
        // match
        matchGesture();
        // event
        dispatchEvent(new GestureEvent(GestureEvent.STOP_CAPTURE));
        // stop the timer
        timer.stop();
    }

    /**

    *    Match the gesture

    */    function matchGesture() : Void {
        var bestCost : Int = 1000000;
        var nbGestures : Int = gestures.length;
        var cost : Int;
        var gest : Array<Dynamic>;
        var bestGesture : Dynamic = null;
        var infos : Dynamic = {
            points : points,
            moves : moves,
            lastPoint : lastPoint,
            rect : new Rectangle(rect.minx, rect.miny, rect.maxx - rect.minx, rect.maxy - rect.miny),

        };
        var i : Int = 0;
        while(i < nbGestures) {
            gest = gestures[i].moves;
            infos.datas = gestures[i].datas;
            cost = costLeven(gest, moves);
            if(cost <= DEFAULT_FIABILITY)  {
                if(gestures[i].match != null)  {
                    infos.cost = cost;
                }
                if(cost < bestCost)  {
                    bestCost = cost;
                    bestGesture = gestures[i];
                }
            }
            i++;
        }
        if(bestGesture != null)  {
            var evt : GestureEvent = new GestureEvent(GestureEvent.GESTURE_MATCH);
            evt.datas = bestGesture.datas;
            evt.fiability = bestCost;
            dispatchEvent(evt);
        }

        else  {
            dispatchEvent(new GestureEvent(GestureEvent.NO_MATCH));
        }

    }

    /**

    *    dif angle

    */    function difAngle(a : Int, b : Int) : Int {
        var dif : Int = Math.abs(a - b);
        if(dif > DEFAULT_NB_SECTORS / 2) 
            dif = DEFAULT_NB_SECTORS - dif;
        return dif;
    }

    /**

    *    return a filled 2D table

    */    function fill2DTable(w : Int, h : Int, f : Dynamic) : Array<Dynamic> {
        var o : Array<Dynamic> = new Array<Dynamic>(w);
        var x : Int = 0;
        while(x < w) {
            o[x] = new Array<Dynamic>(h);
            var y : Int = 0;
            while(y < h) {
                o[x][y] = f;
                y++;
            }
            x++;
        }
        return o;
    }

    /**

    *    cost Levenshtein

    */    function costLeven(a : Array<Dynamic>, b : Array<Dynamic>) : Int {
        // point
        if(a[0] == -1)  {
            return b.length == (0) ? 0 : 100000;
        }
;
        // precalc difangles
        var d : Array<Dynamic> = fill2DTable(a.length + 1, b.length + 1, 0);
        var w : Array<Dynamic> = d.slice();
        var x : Int = 1;
        while(x <= a.length) {
            var y : Int = 1;
            while(y < b.length) {
                d[x][y] = difAngle(a[x - 1], b[y - 1]);
                y++;
            }
            x++;
        }
        // max cost
        y = 1;
        while(y <= b.length) {
            w[0][y] = 100000;
            y++;
        }
;
        x = 1;
        while(x <= a.length) {
            w[x][0] = 100000;
            x++;
        }
        w[0][0] = 0;
        // levensthein application
        var cost : Int = 0;
        var pa : Int;
        var pb : Int;
        var pc : Int;
        x = 1;
        while(x <= a.length) {
            y = 1;
            while(y < b.length) {
                cost = d[x][y];
                pa = w[x - 1][y] + cost;
                pb = w[x][y - 1] + cost;
                pc = w[x - 1][y - 1] + cost;
                w[x][y] = Math.min(Math.min(pa, pb), pc);
                y++;
            }
            x++;
        }
        return w[x - 1][y - 1];
    }

}

