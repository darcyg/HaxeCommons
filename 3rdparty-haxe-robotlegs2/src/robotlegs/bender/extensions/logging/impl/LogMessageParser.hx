//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging.impl;

class LogMessageParser {

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function parseMessage(message : String, params : Array<Dynamic>) : String {
        if(params != null)  {
            var numParams : Int = params.length;
            var i : Int = 0;
            while(i < numParams) {
                message = message.split("{" + i + "}").join(params[i]);
                ++i;
            }
        }
        return message;
    }


    public function new() {
    }
}

