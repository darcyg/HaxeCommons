//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

class UID {

    /*============================================================================*/    
    /* Private Static Properties                                                  */    /*============================================================================*/    
    static var _i : Int;
    /*============================================================================*/    
    /* Public Static Functions                                                    */    /*============================================================================*/    
    /**

     * Generates a UID for a given source object or class

     * @param source The source object or class

     * @return Generated UID

     */    
    /*static public function create(source : Dynamic = null) : String {
        if(Std.is(source, Class)) 
            source = Type.getClassName(source).split("::").pop();
        return ((source) ? source + "-" : "") + (_i++).toString(16) + "-" + (Math.random() * 255).toString(16);
    }*/
    static public function create(source : Dynamic = null) : String {
        if(Std.is(source, Class)) 
            source = Type.getClassName(source).split("::").pop();
        return ((source) ? source + "-" : "") + StringTools.hex((_i++),4) + "-" + StringTools.hex((Math.floor(Math.random() * 255)),4);
    }

    public function new() {
    }
}

