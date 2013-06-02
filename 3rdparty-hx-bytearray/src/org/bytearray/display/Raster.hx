////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Didier Brun - www.foxaweb.com
// Contributors: 
//              Thibault Imbert - http://www.bytearray.org
//              Drew Cummins - http://blog.generalrelativity.org
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
import flash.geom.Rectangle;

class Raster extends BitmapData {

    var buffer : Array<Dynamic>;
    var r : Rectangle;
    public function new(width : Int, height : Int, transparent : Bool = true, color : Int = 0xFFFFFFFF) {
        buffer = new Array<Dynamic>();
        r = new Rectangle();
        super(width, height, transparent, color);
    }

    // ------------------------------------------------
        //
        // ---o public methods
        //
        // ------------------------------------------------
        /**

    * Draw a line

    * 

    * @param x0        first point x coord

    * @param y0        first point y coord 

    * @param x1        second point x coord

    * @param y1        second point y coord

    * @param c        color (0xaarrvvbb)

    */    public function line(x0 : Int, y0 : Int, x1 : Int, y1 : Int, color : Int) : Void {
        var dx : Int;
        var dy : Int;
        var i : Int;
        var xinc : Int;
        var yinc : Int;
        var cumul : Int;
        var x : Int;
        var y : Int;
        x = x0;
        y = y0;
        dx = x1 - x0;
        dy = y1 - y0;
        xinc = ((dx > 0)) ? 1 : -1;
        yinc = ((dy > 0)) ? 1 : -1;
        dx = dx < (0) ? -dx : dx;
        dy = dy < (0) ? -dy : dy;
        setPixel32(x, y, color);
        if(dx > dy)  {
            cumul = dx >> 1;
            i = 1;
            while(i <= dx) {
                x += xinc;
                cumul += dy;
                if(cumul >= dx)  {
                    cumul -= dx;
                    y += yinc;
                }
                setPixel32(x, y, color);
                ++i;
            }
        }

        else  {
            cumul = dy >> 1;
            i = 1;
            while(i <= dy) {
                y += yinc;
                cumul += dx;
                if(cumul >= dy)  {
                    cumul -= dy;
                    x += xinc;
                }
                setPixel32(x, y, color);
                ++i;
            }
        }

    }

    /**

    * Draw a triangle

    * 

    * @param x0        first point x coord

    * @param y0        first point y coord 

    * @param x1        second point x coord

    * @param y1        second point y coord

    * @param x2        third point x coord

    * @param y2        third point y coord

    * @param c        color (0xaarrvvbb)

    */    public function triangle(x0 : Int, y0 : Int, x1 : Int, y1 : Int, x2 : Int, y2 : Int, color : Int) : Void {
        line(x0, y0, x1, y1, color);
        line(x1, y1, x2, y2, color);
        line(x2, y2, x0, y0, color);
    }

    /**

    * Draw a filled triangle

    * 

    * @param x0        first point x coord

    * @param y0        first point y coord 

    * @param x1        second point x coord

    * @param y1        second point y coord

    * @param x2        third point x coord

    * @param y2        third point y coord

    * @param c        color (0xaarrvvbb)

    */    public function filledTri(x0 : Int, y0 : Int, x1 : Int, y1 : Int, x2 : Int, y2 : Int, color : Int) : Void {
        buffer = [];
        lineTri(buffer, x0, y0, x1, y1, color);
        lineTri(buffer, x1, y1, x2, y2, color);
        lineTri(buffer, x2, y2, x0, y0, color);
    }

    /**

    * Draw a circle

    * 

    * @param px        first point x coord

    * @param py        first point y coord 

    * @param r        radius

    * @param c        color (0xaarrvvbb)

    */    public function circle(px : Int, py : Int, r : Int, color : Int) : Void {
        var x : Int;
        var y : Int;
        var d : Int;
        x = 0;
        y = r;
        d = 1 - r;
        setPixel32(px + x, py + y, color);
        setPixel32(px + x, py - y, color);
        setPixel32(px - y, py + x, color);
        setPixel32(px + y, py + x, color);
        while(y > x) {
            if(d < 0)  {
                d += (x + 3) << 1;
            }

            else  {
                d += ((x - y) << 1) + 5;
                y--;
            }

            x++;
            setPixel32(px + x, py + y, color);
            setPixel32(px - x, py + y, color);
            setPixel32(px + x, py - y, color);
            setPixel32(px - x, py - y, color);
            setPixel32(px - y, py + x, color);
            setPixel32(px - y, py - x, color);
            setPixel32(px + y, py - x, color);
            setPixel32(px + y, py + x, color);
        }

    }

    /**

    * Draw an anti-aliased circle

    * 

    * @param px        first point x coord

    * @param py        first point y coord 

    * @param r        radius

    * @param c        color (0xaarrvvbb)

    */    public function aaCircle(px : Int, py : Int, r : Int, color : Int) : Void {
        var vx : Int;
        var vy : Int;
        var d : Int;
        vx = r;
        vy = 0;
        var t : Float = 0;
        var dry : Float;
        var buff : Int;
        setPixel(px + vx, py + vy, color);
        setPixel(px - vx, py + vy, color);
        setPixel(px + vy, py + vx, color);
        setPixel(px + vy, py - vx, color);
        while(vx > vy + 1) {
            vy++;
            buff = Math.sqrt(r * r - vy * vy) + 1;
            dry = buff - Math.sqrt(r * r - vy * vy);
            if(dry < t) 
                vx--;
            drawAlphaPixel(px + vx, py + vy, 1 - dry, color);
            drawAlphaPixel(px + vx - 1, py + vy, dry, color);
            drawAlphaPixel(px - vx, py + vy, 1 - dry, color);
            drawAlphaPixel(px - vx + 1, py + vy, dry, color);
            drawAlphaPixel(px + vx, py - vy, 1 - dry, color);
            drawAlphaPixel(px + vx - 1, py - vy, dry, color);
            drawAlphaPixel(px - vx, py - vy, 1 - dry, color);
            drawAlphaPixel(px - vx + 1, py - vy, dry, color);
            drawAlphaPixel(px + vy, py + vx, 1 - dry, color);
            drawAlphaPixel(px + vy, py + vx - 1, dry, color);
            drawAlphaPixel(px - vy, py + vx, 1 - dry, color);
            drawAlphaPixel(px - vy, py + vx - 1, dry, color);
            drawAlphaPixel(px + vy, py - vx, 1 - dry, color);
            drawAlphaPixel(px + vy, py - vx + 1, dry, color);
            drawAlphaPixel(px - vy, py - vx, 1 - dry, color);
            drawAlphaPixel(px - vy, py - vx + 1, dry, color);
            t = dry;
        }

    }

    /**

    * Draw an anti-aliased line

    * 

    * @param x0        first point x coord

    * @param y0        first point y coord 

    * @param x1        second point x coord

    * @param y1        second point y coord

    * @param c        color (0xaarrvvbb)

    */    public function aaLine(x1 : Int, y1 : Int, x2 : Int, y2 : Int, color : Int) : Void {
        var steep : Bool = (y2 - y1) < (0) ? -(y2 - y1) : (y2 - y1) > (x2 - x1) < (0) ? -(x2 - x1) : (x2 - x1);
        var swap : Int;
        if(steep)  {
            swap = x1;
            x1 = y1;
            y1 = swap;
            swap = x2;
            x2 = y2;
            y2 = swap;
        }
        if(x1 > x2)  {
            swap = x1;
            x1 = x2;
            x2 = swap;
            swap = y1;
            y1 = y2;
            y2 = swap;
        }
        var dx : Int = x2 - x1;
        var dy : Int = y2 - y1;
        var gradient : Float = dy / dx;
        var xend : Int = x1;
        var yend : Float = y1 + gradient * (xend - x1);
        var xgap : Float = 1 - ((x1 + 0.5) % 1);
        var xpx1 : Int = xend;
        var ypx1 : Int = yend;
        var alpha : Float;
        alpha = ((yend) % 1) * xgap;
        var intery : Float = yend + gradient;
        xend = x2;
        yend = y2 + gradient * (xend - x2);
        xgap = (x2 + 0.5) % 1;
        var xpx2 : Int = xend;
        var ypx2 : Int = yend;
        alpha = (1 - ((yend) % 1)) * xgap;
        if(steep) 
            drawAlphaPixel(ypx2, xpx2, alpha, color)
        else drawAlphaPixel(xpx2, ypx2, alpha, color);
        alpha = ((yend) % 1) * xgap;
        if(steep) 
            drawAlphaPixel(ypx2 + 1, xpx2, alpha, color)
        else drawAlphaPixel(xpx2, ypx2 + 1, alpha, color);
        var x : Int = xpx1;
        while(x++ < xpx2) {
            alpha = 1 - ((intery) % 1);
            if(steep) 
                drawAlphaPixel(intery, x, alpha, color)
            else drawAlphaPixel(x, intery, alpha, color);
            alpha = intery % 1;
            if(steep) 
                drawAlphaPixel(intery + 1, x, alpha, color)
            else drawAlphaPixel(x, intery + 1, alpha, color);
            intery = intery + gradient;
        }

    }

    /**

     * Draws a Rectangle

     * 

     * @param rect             Rectangle dimensions

     * @param color            color

     * */    public function drawRect(rect : Rectangle, color : Int) : Void {
        line(rect.x, rect.y, rect.x + rect.width, rect.y, color);
        line(rect.x + rect.width, rect.y, rect.x + rect.width, rect.y + rect.height, color);
        line(rect.x + rect.width, rect.y + rect.height, rect.x, rect.y + rect.height, color);
        line(rect.x, rect.y + rect.height, rect.x, rect.y, color);
    }

    /**

     * Draws a rounded Rectangle

     * 

     * @param rect             Rectangle dimensions

     * @param ellipseWidth  Rectangle corners width

     * @param color            color

     * */    public function drawRoundRect(rect : Rectangle, ellipseWidth : Int, color : Int) : Void {
        var arc : Float = 4 / 3 * (Math.sqrt(2) - 1);
        var xc : Float = rect.x + rect.width - ellipseWidth;
        var yc : Float = rect.y + ellipseWidth;
        line(rect.x + ellipseWidth, rect.y, xc, rect.y, color);
        cubicBezier(xc, rect.y, xc + ellipseWidth * arc, yc - ellipseWidth, xc + ellipseWidth, yc - ellipseWidth * arc, xc + ellipseWidth, yc, color);
        xc = rect.x + rect.width - ellipseWidth;
        yc = rect.y + rect.height - ellipseWidth;
        line(xc + ellipseWidth, rect.y + ellipseWidth, rect.x + rect.width, yc, color);
        cubicBezier(rect.x + rect.width, yc, xc + ellipseWidth, yc + ellipseWidth * arc, xc + ellipseWidth * arc, yc + ellipseWidth, xc, yc + ellipseWidth, color);
        xc = rect.x + ellipseWidth;
        yc = rect.y + rect.height - ellipseWidth;
        line(rect.x + rect.width - ellipseWidth, rect.y + rect.height, xc, yc + ellipseWidth, color);
        cubicBezier(xc, yc + ellipseWidth, xc - ellipseWidth * arc, yc + ellipseWidth, xc - ellipseWidth, yc + ellipseWidth * arc, xc - ellipseWidth, yc, color);
        xc = rect.x + ellipseWidth;
        yc = rect.y + ellipseWidth;
        line(xc - ellipseWidth, rect.y + rect.height - ellipseWidth, rect.x, yc, color);
        cubicBezier(rect.x, yc, xc - ellipseWidth, yc - ellipseWidth * arc, xc - ellipseWidth * arc, yc - ellipseWidth, xc, yc - ellipseWidth, color);
    }

    /**

         * Draws a Quadratic Bezier Curve (equivalent to a DisplayObject's graphics#curveTo)

         * 

         * @param x0             x position of first anchor

         * @param y0             y position of first anchor

         * @param x1             x position of control point

         * @param y1             y position of control point

         * @param x2             x position of second anchor

         * @param y2             y position of second anchor

         * @param c             color

     * @param resolution     [optional] determines the accuracy of the curve's length (higher number = greater accuracy = longer process)

         * */    public function quadBezier(anchorX0 : Int, anchorY0 : Int, controlX : Int, controlY : Int, anchorX1 : Int, anchorY1 : Int, c : Int, resolution : Int = 3) : Void {
        var ox : Float = anchorX0;
        var oy : Float = anchorY0;
        var px : Int;
        var py : Int;
        var dist : Float = 0;
        var inverse : Float = 1 / resolution;
        var interval : Float;
        var intervalSq : Float;
        var diff : Float;
        var diffSq : Float;
        var i : Int = 0;
        while(++i <= resolution) {
            interval = inverse * i;
            intervalSq = interval * interval;
            diff = 1 - interval;
            diffSq = diff * diff;
            px = diffSq * anchorX0 + 2 * interval * diff * controlX + intervalSq * anchorX1;
            py = diffSq * anchorY0 + 2 * interval * diff * controlY + intervalSq * anchorY1;
            dist += Math.sqrt((px - ox) * (px - ox) + (py - oy) * (py - oy));
            ox = px;
            oy = py;
        }

        //approximates the length of the curve
        var curveLength : Int = dist;
        inverse = 1 / curveLength;
        var lastx : Int = anchorX0;
        var lasty : Int = anchorY0;
        i = -1;
        while(++i <= curveLength) {
            interval = inverse * i;
            intervalSq = interval * interval;
            diff = 1 - interval;
            diffSq = diff * diff;
            px = diffSq * anchorX0 + 2 * interval * diff * controlX + intervalSq * anchorX1;
            py = diffSq * anchorY0 + 2 * interval * diff * controlY + intervalSq * anchorY1;
            line(lastx, lasty, px, py, c);
            lastx = px;
            lasty = py;
        }

    }

    /**

         * Draws a Cubic Bezier Curve

         * 

         * TODO: Determine whether x/y params would be better named as anchor/control

         * 

         * @param x0             x position of first anchor

         * @param y0             y position of first anchor

         * @param x1             x position of control point

         * @param y1             y position of control point

         * @param x2             x position of second control point

         * @param y2             y position of second control point

         * @param x3             x position of second anchor

         * @param y3             y position of second anchor

         * @param c             color

     * @param resolution     [optional] determines the accuracy of the curve's length (higher number = greater accuracy = longer process)

         * */    public function cubicBezier(x0 : Int, y0 : Int, x1 : Int, y1 : Int, x2 : Int, y2 : Int, x3 : Int, y3 : Int, c : Float, resolution : Int = 5) : Void {
        var ox : Float = x0;
        var oy : Float = y0;
        var px : Int;
        var py : Int;
        var dist : Float = 0;
        var inverse : Float = 1 / resolution;
        var interval : Float;
        var intervalSq : Float;
        var intervalCu : Float;
        var diff : Float;
        var diffSq : Float;
        var diffCu : Float;
        var i : Int = 0;
        while(++i <= resolution) {
            interval = inverse * i;
            intervalSq = interval * interval;
            intervalCu = intervalSq * interval;
            diff = 1 - interval;
            diffSq = diff * diff;
            diffCu = diffSq * diff;
            px = diffCu * x0 + 3 * interval * diffSq * x1 + 3 * x2 * intervalSq * diff + x3 * intervalCu;
            py = diffCu * y0 + 3 * interval * diffSq * y1 + 3 * y2 * intervalSq * diff + y3 * intervalCu;
            dist += Math.sqrt((px - ox) * (px - ox) + (py - oy) * (py - oy));
            ox = px;
            oy = py;
        }

        //approximates the length of the curve
        var curveLength : Int = dist;
        inverse = 1 / curveLength;
        var lastx : Int = x0;
        var lasty : Int = y0;
        i = -1;
        while(++i <= curveLength) {
            interval = inverse * i;
            intervalSq = interval * interval;
            intervalCu = intervalSq * interval;
            diff = 1 - interval;
            diffSq = diff * diff;
            diffCu = diffSq * diff;
            px = diffCu * x0 + 3 * interval * diffSq * x1 + 3 * x2 * intervalSq * diff + x3 * intervalCu;
            py = diffCu * y0 + 3 * interval * diffSq * y1 + 3 * y2 * intervalSq * diff + y3 * intervalCu;
            line(lastx, lasty, px, py, c);
            lastx = px;
            lasty = py;
        }

    }

    // ------------------------------------------------
        //
        // ---o private static methods
        //
        // ------------------------------------------------
        /**

    * Draw an alpha32 pixel

    */    function drawAlphaPixel(x : Int, y : Int, a : Float, c : Float) : Void {
        var g : Int = getPixel32(x, y);
        var r0 : Int = ((g & 0x00FF0000) >> 16);
        var g0 : Int = ((g & 0x0000FF00) >> 8);
        var b0 : Int = ((g & 0x000000FF));
        var r1 : Int = ((c & 0x00FF0000) >> 16);
        var g1 : Int = ((c & 0x0000FF00) >> 8);
        var b1 : Int = ((c & 0x000000FF));
        var ac : Float = 0xFF;
        var rc : Float = r1 * a + r0 * (1 - a);
        var gc : Float = g1 * a + g0 * (1 - a);
        var bc : Float = b1 * a + b0 * (1 - a);
        var n : Int = (ac << 24) + (rc << 16) + (gc << 8) + bc;
        setPixel32(x, y, n);
    }

    /**

    * Check a triangle line

    */    function checkLine(o : Array<Dynamic>, x : Int, y : Int, c : Int, r : Rectangle) : Void {
        if(o[y])  {
            if(o[y] > x)  {
                r.width = o[y] - x;
                r.x = x;
                r.y = y;
                fillRect(r, c);
            }

            else  {
                r.width = x - o[y];
                r.x = o[y];
                r.y = y;
                fillRect(r, c);
            }

        }

        else  {
            o[y] = x;
        }

    }

    /**

    * Special line for filled triangle

    */    function lineTri(o : Array<Dynamic>, x0 : Int, y0 : Int, x1 : Int, y1 : Int, c : Float) : Void {
        var steep : Bool = (y1 - y0) * (y1 - y0) > (x1 - x0) * (x1 - x0);
        var swap : Int;
        if(steep)  {
            swap = x0;
            x0 = y0;
            y0 = swap;
            swap = x1;
            x1 = y1;
            y1 = swap;
        }
        if(x0 > x1)  {
            x0 ^= x1;
            x1 ^= x0;
            x0 ^= x1;
            y0 ^= y1;
            y1 ^= y0;
            y0 ^= y1;
        }
        var deltax : Int = x1 - x0;
        var deltay : Int = (y1 - y0) < (0) ? -(y1 - y0) : (y1 - y0);
        var error : Int = 0;
        var y : Int = y0;
        var ystep : Int = y0 < (y1) ? 1 : -1;
        var x : Int = x0;
        var xend : Int = x1 - (deltax >> 1);
        var fx : Int = x1;
        var fy : Int = y1;
        var px : Int = 0;
        r.x = 0;
        r.y = 0;
        r.width = 0;
        r.height = 1;
        while(x++ <= xend) {
            if(steep)  {
                checkLine(o, y, x, c, r);
                if(fx != x1 && fx != xend) 
                    checkLine(o, fy, fx + 1, c, r);
            }
            error += deltay;
            if((error << 1) >= deltax)  {
                if(!steep)  {
                    checkLine(o, x - px + 1, y, c, r);
                    if(fx != xend) 
                        checkLine(o, fx + 1, fy, c, r);
                }
                px = 0;
                y += ystep;
                fy -= ystep;
                error -= deltax;
            }
            px++;
            fx--;
        }

        if(!steep) 
            checkLine(o, x - px + 1, y, c, r);
    }

}

