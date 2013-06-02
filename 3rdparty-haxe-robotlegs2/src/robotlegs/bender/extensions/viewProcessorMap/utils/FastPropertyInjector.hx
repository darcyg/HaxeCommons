//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.utils;

import minject.Injector;

class FastPropertyInjector {

    var _propertyTypesByName : Dynamic;
    public function new(propertyTypesByName : Dynamic) {
        _propertyTypesByName = propertyTypesByName;
    }

    public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
        // TODO    
    }
 
 }