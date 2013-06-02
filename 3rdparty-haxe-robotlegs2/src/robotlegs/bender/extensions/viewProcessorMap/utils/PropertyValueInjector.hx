//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.utils;

import minject.Injector;

class PropertyValueInjector {

    var _valuesByPropertyName : Dynamic;
    public function new(valuesByPropertyName : Dynamic) {
        _valuesByPropertyName = valuesByPropertyName;
    }

    public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
    // TODO    
        }
 
 }
        