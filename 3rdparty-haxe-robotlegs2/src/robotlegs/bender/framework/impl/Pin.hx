//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import openfl.ObjectHash<Dynamic,Dynamic>;

class Pin {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _instances : ObjectHash<Dynamic,Bool>;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function detain(instance : Dynamic) : Void {
        _instances.set(instance, true);
    }

    public function release(instance : Dynamic) : Void {
        _instances.remove(instance);
    }

    public function flush() : Void {
        for(instance in Reflect.fields(_instances)) {
            _instances.remove(instance);
        }

    }


    public function new() {
        _instances = new ObjectHash();
    }
}

