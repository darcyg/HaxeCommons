//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.impl;

import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

class NullCommandUnmapper implements ICommandUnmapper {

    //---------------------------------------
        // ICommandUnmapper Implementation
        //---------------------------------------
        public function fromCommand(commandClass : Class<Dynamic>) : Void {
    }

    public function fromAll() : Void {
    }


    public function new() {
    }
}

