//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging.impl;

import openfl.Lib;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.LogLevel;

class TraceLogTarget implements ILogTarget {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _messageParser : LogMessageParser;
    var _context : IContext;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(context : IContext) {
        _messageParser = new LogMessageParser();
        _context = context;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function log(source : Dynamic, level : Int, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void {
        Lib.trace(timestamp + " | " + level + " | " + source + " | " + message + " | " + params);
    }

}

