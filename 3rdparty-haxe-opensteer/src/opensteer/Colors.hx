// ----------------------------------------------------------------------------
//
// PaperSteer - Papervision3D Port of OpenSteer
// Port by Mohammad Haseeb aka M.H.A.Q.S.
// http://www.tabinda.net
// AS3 Refactor by Andras Csizmadia <andras@vpmedia.eu> (No PV3D dependency)
// HaXe Port by Andras Csizmadia <andras@vpmedia.eu> 
//
// OpenSteer -- Steering Behaviors for Autonomous Characters
//
// Copyright (c) 2002-2003, Sony Computer Entertainment America
// Original author: Craig Reynolds <craig_reynolds@playstation.sony.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//
// ----------------------------------------------------------------------------
package opensteer;
class Colors {
    static public function RGBToHex(r : Int = 255, g : Int = 255, b : Int = 255) : Int {
        var hex : Int = (r << 16 | g << 8 | b);
        return hex;
    }
    static public function HexToRGB(hex : Int) : Array<Dynamic> {
        var rgb : Array<Int> = [];
        var r : Int = hex >> 16 & 0xFF;
        var g : Int = hex >> 8 & 0xFF;
        var b : Int = hex & 0xFF;
        rgb.push(r);  
    rgb.push(g);  
    rgb.push(b);
        return rgb;
    }
    static public function HexToVector(hex : Int) : Vector3 {
        var rgb : Vector3;
        var r : Int = hex >> 16 & 0xFF;
        var g : Int = hex >> 8 & 0xFF;
        var b : Int = hex & 0xFF;
        rgb = new Vector3(r, g, b);
        return rgb;
    }
    static public function VectorToHex(v : Vector3) : Int {
        var hex : Int = (Std.int(v.x) << 16 | Std.int(v.y) << 8 | Std.int(v.z));
        return hex;
    }
    static public function RGBtoHSV(r : Int, g : Int, b : Int) : Array<Dynamic> {
        //var max : Int = Std.int(Math.max(r, g, b));
        //var min : Int = Std.int(Math.min(r, g, b));
        var max : Int = Std.int(Math.max(r, g));
        max = Std.int(Math.max(max, b));
        var min : Int = Std.int(Math.min(r, g));        
        min = Std.int(Math.min(min, b));
        var hue : Float = 0;
        var saturation : Float = 0;
        var value : Float = 0;
        var hsv : Array<Dynamic> = [];
        //get Hue
        if(max == min)  {
            hue = 0;
        }
        else if(max == r)  {
            hue = (60 * (g - b) / (max - min) + 360) % 360;
        }
        else if(max == g)  {
            hue = (60 * (b - r) / (max - min) + 120);
        }
        else if(max == b)  {
            hue = (60 * (r - g) / (max - min) + 240);
        }
;
        //get Value
        value = max;
        //get Saturation
        if(max == 0)  {
            saturation = 0;
        }
        else  {
            saturation = (max - min) / max;
        }
;
        hsv = [Math.round(hue), Math.round(saturation * 100), Math.round(value / 255 * 100)];
        return hsv;
    }
    static public function HSVtoRGB(h : Float, s : Float, v : Float) : Array<Dynamic> {
        var r : Float = 0;
        var g : Float = 0;
        var b : Float = 0;
        var rgb : Array<Dynamic> = [];
        var tempS : Float = s / 100;
        var tempV : Float = v / 100;
        var hi : Int = Math.floor(h / 60) % 6;
        var f : Float = h / 60 - Math.floor(h / 60);
        var p : Float = (tempV * (1 - tempS));
        var q : Float = (tempV * (1 - f * tempS));
        var t : Float = (tempV * (1 - (1 - f) * tempS));
        switch(hi) {
        case 0:
            r = tempV;
            g = t;
            b = p;
        case 1:
            r = q;
            g = tempV;
            b = p;
        case 2:
            r = p;
            g = tempV;
            b = t;
        case 3:
            r = p;
            g = q;
            b = tempV;
        case 4:
            r = t;
            g = p;
            b = tempV;
        case 5:
            r = tempV;
            g = p;
            b = q;
        }
        rgb = [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
        return rgb;
    }
    public function HexToDeci(hex : String) : Int {
        return Std.parseInt(hex);
    }
    static public inline var Black : Int = 0x000000;
    static public inline var White : Int = 0xFFFFFF;
    static public inline var Red : Int = 0xCC0000;
    static public inline var Yellow : Int = 0xFFFF00;
    static public inline var Green : Int = 0x00CC00;
    static public inline var Blue : Int = 0x0000FF;
    static public inline var Magenta : Int = 0x666699;
    static public inline var Orange : Int = 0xFF9900;
    static public inline var LightGray : Int = 0xD3D3D3;
    static public inline var DarkGray : Int = 0xA9A9A9;
    static public inline var Gray : Int = 0x888888;
    static public inline var AliceBlue : Int = 0xF0F8FF;
    static public inline var AntiqueWhite : Int = 0xFAEBD7;
    static public inline var Aqua : Int = 0x00FAFA;
    static public inline var Aquamarine : Int = 0x7FFFD4;
    static public inline var Azure : Int = 0xF0FFFF;
    static public inline var Beige : Int = 0xF5F5DC;
    static public inline var Bisque : Int = 0xFFE4C4;
    static public inline var BlanchedAlmond : Int = 0xFFEBCD;
    static public inline var BlueViolet : Int = 0x8A2BE2;
    static public inline var Brown : Int = 0xA52A2A;
    static public inline var BurlyWood : Int = 0xDEB887;
    static public inline var CadetBlue : Int = 0x5F9EA0;
    static public inline var Chartreuse : Int = 0x7FFF00;
    static public inline var Chocolate : Int = 0xD2691E;
    static public inline var Coral : Int = 0xFF7F50;
    static public inline var CornflowerBlue : Int = 0x6495ED;
    static public inline var Cornsilk : Int = 0xFFF8DC;
    static public inline var Crimson : Int = 0xDC143C;
    static public inline var Cyan : Int = 0x00FFFF;
    static public inline var DarkBlue : Int = 0x00008B;
    static public inline var DarkCyan : Int = 0x008B8B;
    static public inline var DarkGoldenrod : Int = 0xB8870B;
    static public inline var DarkGreen : Int = 0x006400;
    static public inline var DarkKhaki : Int = 0xBDB76B;
    static public inline var DarkMagenta : Int = 0x8B008B;
    static public inline var DarkOliveGreen : Int = 0x556B2F;
    static public inline var DarkOrange : Int = 0xFF8C00;
    static public inline var DarkOrchid : Int = 0x9932CC;
    static public inline var DarkRed : Int = 0x8B0000;
    /*
        // Summary:
        //     Gets a system-defined color with the value R:233 G:150 B:122 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:233 G:150 B:122 A:255.
        public static const DarkSalmon:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:143 G:188 B:139 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:143 G:188 B:139 A:255.
        public static const DarkSeaGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:72 G:61 B:139 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:72 G:61 B:139 A:255.
        public static const DarkSlateBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:47 G:79 B:79 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:47 G:79 B:79 A:255.
        public static const DarkSlateGray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:206 B:209 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:206 B:209 A:255.
        public static const DarkTurquoise:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:148 G:0 B:211 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:148 G:0 B:211 A:255.
        public static const DarkViolet:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:20 B:147 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:20 B:147 A:255.
        public static const DeepPink:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:191 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:191 B:255 A:255.
        public static const DeepSkyBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:105 G:105 B:105 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:105 G:105 B:105 A:255.
        public static const DimGray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:30 G:144 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:30 G:144 B:255 A:255.
        public static const DodgerBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:178 G:34 B:34 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:178 G:34 B:34 A:255.
        public static const Firebrick:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:250 B:240 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:250 B:240 A:255.
        public static const FloralWhite:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:34 G:139 B:34 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:34 G:139 B:34 A:255.
        public static const ForestGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:0 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:0 B:255 A:255.
        public static const Fuchsia:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:220 G:220 B:220 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:220 G:220 B:220 A:255.
        public static const Gainsboro:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:248 G:248 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:248 G:248 B:255 A:255.
        public static const GhostWhite:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:215 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:215 B:0 A:255.
        public static const Gold:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:218 G:165 B:32 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:218 G:165 B:32 A:255.
        public static const Goldenrod:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:128 G:128 B:128 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:128 G:128 B:128 A:255.
        public static const Gray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:128 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:128 B:0 A:255.
        public static const Green:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:173 G:255 B:47 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:173 G:255 B:47 A:255.
        public static const GreenYellow:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:240 G:255 B:240 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:240 G:255 B:240 A:255.
        public static const Honeydew:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:105 B:180 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:105 B:180 A:255.
        public static const HotPink:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:205 G:92 B:92 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:205 G:92 B:92 A:255.
        public static const IndianRed:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:75 G:0 B:130 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:75 G:0 B:130 A:255.
        public static const Indigo:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:255 B:240 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:255 B:240 A:255.
        public static const Ivory:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:240 G:230 B:140 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:240 G:230 B:140 A:255.
        public static const Khaki:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:230 G:230 B:250 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:230 G:230 B:250 A:255.
        public static const Lavender:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:240 B:245 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:240 B:245 A:255.
        public static const LavenderBlush:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:124 G:252 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:124 G:252 B:0 A:255.
        public static const LawnGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:250 B:205 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:250 B:205 A:255.
        public static const LemonChiffon:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:173 G:216 B:230 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:173 G:216 B:230 A:255.
        public static const LightBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:240 G:128 B:128 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:240 G:128 B:128 A:255.
        public static const LightCoral:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:224 G:255 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:224 G:255 B:255 A:255.
        public static const LightCyan:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:250 G:250 B:210 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:250 G:250 B:210 A:255.
        public static const LightGoldenrodYellow:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:211 G:211 B:211 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:211 G:211 B:211 A:255.
        public static const LightGray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:144 G:238 B:144 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:144 G:238 B:144 A:255.
        public static const LightGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:182 B:193 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:182 B:193 A:255.
        public static const LightPink:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:160 B:122 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:160 B:122 A:255.
        public static const LightSalmon:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:32 G:178 B:170 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:32 G:178 B:170 A:255.
        public static const LightSeaGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:135 G:206 B:250 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:135 G:206 B:250 A:255.
        public static const LightSkyBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:119 G:136 B:153 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:119 G:136 B:153 A:255.
        public static const LightSlateGray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:176 G:196 B:222 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:176 G:196 B:222 A:255.
        public static const LightSteelBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:255 B:224 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:255 B:224 A:255.
        public static const LightYellow:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:255 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:255 B:0 A:255.
        public static const Lime:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:50 G:205 B:50 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:50 G:205 B:50 A:255.
        public static const LimeGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:250 G:240 B:230 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:250 G:240 B:230 A:255.
        public static const Linen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:0 B:255 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:0 B:255 A:255.
        public static const Magenta:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:128 G:0 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:128 G:0 B:0 A:255.
        public static const Maroon:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:102 G:205 B:170 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:102 G:205 B:170 A:255.
        public static const MediumAquamarine:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:0 B:205 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:0 B:205 A:255.
        public static const MediumBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:186 G:85 B:211 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:186 G:85 B:211 A:255.
        public static const MediumOrchid:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:147 G:112 B:219 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:147 G:112 B:219 A:255.
        public static const MediumPurple:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:60 G:179 B:113 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:60 G:179 B:113 A:255.
        public static const MediumSeaGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:123 G:104 B:238 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:123 G:104 B:238 A:255.
        public static const MediumSlateBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:250 B:154 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:250 B:154 A:255.
        public static const MediumSpringGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:72 G:209 B:204 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:72 G:209 B:204 A:255.
        public static const MediumTurquoise:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:199 G:21 B:133 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:199 G:21 B:133 A:255.
        public static const MediumVioletRed:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:25 G:25 B:112 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:25 G:25 B:112 A:255.
        public static const MidnightBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:245 G:255 B:250 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:245 G:255 B:250 A:255.
        public static const MintCream:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:228 B:225 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:228 B:225 A:255.
        public static const MistyRose:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:228 B:181 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:228 B:181 A:255.
        public static const Moccasin:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:222 B:173 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:222 B:173 A:255.
        public static const NavajoWhite:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color R:0 G:0 B:128 A:255.
        //
        // Returns:
        //     A system-defined color R:0 G:0 B:128 A:255.
        public static const Navy:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:253 G:245 B:230 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:253 G:245 B:230 A:255.
        public static const OldLace:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:128 G:128 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:128 G:128 B:0 A:255.
        public static const Olive:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:107 G:142 B:35 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:107 G:142 B:35 A:255.
        public static const OliveDrab:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:165 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:165 B:0 A:255.
        public static const Orange:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:69 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:69 B:0 A:255.
        public static const OrangeRed:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:218 G:112 B:214 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:218 G:112 B:214 A:255.
        public static const Orchid:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:238 G:232 B:170 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:238 G:232 B:170 A:255.
        public static const PaleGoldenrod:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:152 G:251 B:152 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:152 G:251 B:152 A:255.
        public static const PaleGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:175 G:238 B:238 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:175 G:238 B:238 A:255.
        public static const PaleTurquoise:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:219 G:112 B:147 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:219 G:112 B:147 A:255.
        public static const PaleVioletRed:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:239 B:213 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:239 B:213 A:255.
        public static const PapayaWhip:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:218 B:185 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:218 B:185 A:255.
        public static const PeachPuff:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:205 G:133 B:63 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:205 G:133 B:63 A:255.
        public static const Peru:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:192 B:203 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:192 B:203 A:255.
        public static const Pink:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:221 G:160 B:221 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:221 G:160 B:221 A:255.
        public static const Plum:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:176 G:224 B:230 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:176 G:224 B:230 A:255.
        public static const PowderBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:128 G:0 B:128 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:128 G:0 B:128 A:255.
        public static const Purple:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:0 B:0 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:0 B:0 A:255.
        public static const Red:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:188 G:143 B:143 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:188 G:143 B:143 A:255.
        public static const RosyBrown:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:65 G:105 B:225 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:65 G:105 B:225 A:255.
        public static const RoyalBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:139 G:69 B:19 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:139 G:69 B:19 A:255.
        public static const SaddleBrown:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:250 G:128 B:114 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:250 G:128 B:114 A:255.
        public static const Salmon:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:244 G:164 B:96 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:244 G:164 B:96 A:255.
        public static const SandyBrown:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:46 G:139 B:87 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:46 G:139 B:87 A:255.
        public static const SeaGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:245 B:238 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:245 B:238 A:255.
        public static const SeaShell:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:160 G:82 B:45 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:160 G:82 B:45 A:255.
        public static const Sienna:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:192 G:192 B:192 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:192 G:192 B:192 A:255.
        public static const Silver:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:135 G:206 B:235 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:135 G:206 B:235 A:255.
        public static const SkyBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:106 G:90 B:205 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:106 G:90 B:205 A:255.
        public static const SlateBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:112 G:128 B:144 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:112 G:128 B:144 A:255.
        public static const SlateGray:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:250 B:250 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:250 B:250 A:255.
        public static const Snow:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:255 B:127 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:255 B:127 A:255.
        public static const SpringGreen:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:70 G:130 B:180 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:70 G:130 B:180 A:255.
        public static const SteelBlue:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:210 G:180 B:140 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:210 G:180 B:140 A:255.
        public static const Tan:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:128 B:128 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:128 B:128 A:255.
        public static const Teal:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:216 G:191 B:216 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:216 G:191 B:216 A:255.
        public static const Thistle:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:99 B:71 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:99 B:71 A:255.
        public static const Tomato:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:0 G:0 B:0 A:0.
        //
        // Returns:
        //     A system-defined color with the value R:0 G:0 B:0 A:0.
        public static const TransparentBlack:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:255 G:255 B:255 A:0.
        //
        // Returns:
        //     A system-defined color with the value R:255 G:255 B:255 A:0.
        public static const TransparentWhite:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:64 G:224 B:208 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:64 G:224 B:208 A:255.
        public static const Turquoise:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:238 G:130 B:238 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:238 G:130 B:238 A:255.
        public static const Violet:uint = 0x
        //
        // Summary:
        //     Gets a system-defined color with the value R:245 G:222 B:179 A:255.
        //
        // Returns:
        //     A system-defined color with the value R:245 G:222 B:179 A:255.*/    static public inline var Wheat : Int = 0xF5DEB3;
    static public inline var WhiteSmoke : Int = 0xF5F5F5;
    static public inline var YellowGreen : Int = 0x9ACD32;
    public function new() {
    }
}