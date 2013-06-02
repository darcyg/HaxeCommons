//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatormap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorUnmapper;
import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.matching.TypeMatcher;
import flash.display.DisplayObject;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.framework.api.ILogger;

class MediatorMap implements IMediatorMap implements IViewHandler {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappers : ObjectHash<Dynamic,Dynamic>;
    var _handler : IMediatorViewHandler;
    var _factory : IMediatorFactory;
    var NULL_UNMAPPER : IMediatorUnmapper;
    
    @inject
    public var logger:ILogger;
    
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(factory : IMediatorFactory, handler : IMediatorViewHandler = null) {
        _mappers = new ObjectHash();
        NULL_UNMAPPER = new NullMediatorUnmapper();
        _factory = factory;
        if (handler == null)
        {
            handler = new MediatorViewHandler(_factory);
        }
        _handler = handler;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function mapMatcher(matcher : ITypeMatcher) : IMediatorMapper {
        logger.debug(this + "::" + "mapMatcher" + "::" + matcher);
        var result:IMediatorMapper;
        var key:Dynamic = matcher.createTypeFilter().descriptor;
        if (_mappers.exists(key))
        {
            result = _mappers.get(key);
        } else {
            result = createMapper(matcher);
            _mappers.set(key, result);
        }
        return result; 
    }

    public function map(type : Class<Dynamic>) : IMediatorMapper {
        logger.debug(this + "::" + "map" + "::" + type);
        var matcher : ITypeMatcher = new TypeMatcher().allOf([type]);
        return mapMatcher(matcher);
    }

    public function unmapMatcher(matcher : ITypeMatcher) : IMediatorUnmapper {
        logger.debug(this + "::" + "unmapMatcher" + "::" + matcher);
        var result:IMediatorUnmapper;
        if (_mappers.exists(matcher.createTypeFilter().descriptor))
        {
            result = _mappers.get(matcher.createTypeFilter().descriptor);
        }else {
            result = NULL_UNMAPPER;
        }
        return result;
    }

    public function unmap(type : Class<Dynamic>) : IMediatorUnmapper {
        logger.debug(this + "::" + "unmap" + "::" + type);
        var matcher : ITypeMatcher = new TypeMatcher().allOf([type]);
        return unmapMatcher(matcher);
    }

    public function handleView(view : DisplayObject, type : Class<Dynamic>) : Void {
        logger.debug(this + "::" + "handleView" + "::" + view + "::" + type);
        _handler.handleView(view, type);
    }

    public function mediate(item : Dynamic) : Void {
        logger.debug(this + "::" + "mediate" + "::" + item);
        var type : Class<Dynamic> = Type.getClass(item.constructor);
        _handler.handleItem(item, type);
    }

    public function unmediate(item : Dynamic) : Void {
        logger.debug(this + "::" + "unmediate" + "::" + item);
        _factory.removeMediators(item);
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createMapper(matcher : ITypeMatcher, viewType : Class<Dynamic> = null) : IMediatorMapper {
        return new MediatorMapper(matcher.createTypeFilter(), _handler);
    }

}

