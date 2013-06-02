//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;

/**

 * The log manager creates loggers and is itself a log target

 */class LogManager implements ILogTarget {
    public var logLevel(getLogLevel, setLogLevel) : Int;

    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _logLevel : Int;
    public function getLogLevel() : Int {
        return _logLevel;
    }

    public function setLogLevel(value : Int) : Int {
        _logLevel = value;
        return value;
    }

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _targets : Array<ILogTarget>;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    /**

     * Retrieves a logger for a given source

     * @param source Logging source

     * @return Logger

     */    public function getLogger(source : Dynamic) : ILogger {
        return new Logger(source, this);
    }

    /**

     * Adds a custom log target

     * @param target Log target

     * @return this

     */    public function addLogTarget(target : ILogTarget) : Void {
        _targets.push(target);
    }

    /**

     * @inheritDoc

     */    public function log(source : Dynamic, level : Int, timestamp : Int, message : String, params : Array<Dynamic> = null) : Void {
        if(level > _logLevel) 
            return;
        for(target in _targets) {
            target.log(source, level, timestamp, message, params);
        }

    }


    public function new() {
        _logLevel = LogLevel.INFO;
        _targets = new Array<ILogTarget>();
    }
}

