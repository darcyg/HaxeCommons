//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import org.hamcrest.Matcher;
import minject.Injector;

/**

 * The Robotlegs context contract

 */interface IContext {
    var injector(getInjector, never) : Injector;
    var lifecycle(getLifecycle, never) : ILifecycle;
    var logLevel(getLogLevel, setLogLevel) : Int;

    /**

     * The context dependency injector

     */    function getInjector() : Injector;
    /**

     * The context lifecycle

     */    function getLifecycle() : ILifecycle;
    /**

     * The current log level

     */    function getLogLevel() : Int;
    /**

     * Sets the current log level

     * @param value The log level. Use a constant from LogLevel

     */    function setLogLevel(value : Int) : Int;
    /**

     * Extends the context with custom extensions or bundles

     * @param extensions Objects or classes implementing IExtension or IBundle

     * @return this

     */    function extend(extensions:Array<Dynamic>) : IContext;
    /**

     * Configures the context with custom configurations

     * @param configs Configuration objects or classes of any type

     * @return this

     */    function configure(configs:Array<Dynamic>) : IContext;
    /**

     * Adds a custom configuration handler

     * @param matcher Pattern to match configurations

     * @param handler Handler to process matching configurations

     * @return this

     */    function addConfigHandler(matcher : Matcher<Dynamic>, handler : Dynamic->Void) : IContext;
    /**

     * Retrieves a logger for a given source

     * @param source Logging source

     * @return Logger

     */    function getLogger(source : Dynamic) : ILogger;
    /**

     * Adds a custom log target

     * @param target Log target

     * @return this

     */    function addLogTarget(target : ILogTarget) : IContext;
    /**

     * Pins instances in memory

     * @param instances Instances to pin

     * @return this

     */    function detain(instances:Array<Dynamic>) : IContext;
    /**

     * Unpins instances from memory

     * @param instances Instances to unpin

     * @return this

     */    function release(instances:Array<Dynamic>) : IContext;
}

