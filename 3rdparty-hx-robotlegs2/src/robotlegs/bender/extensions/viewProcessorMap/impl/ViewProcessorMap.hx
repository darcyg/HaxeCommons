package robotlegs.bender.extensions.viewprocessormap.impl;

import robotlegs.bender.extensions.viewprocessormap.api.IViewProcessorMap;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapper;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorUnmapper;
import flash.display.DisplayObject;
import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.viewprocessormap.impl.ViewProcessorMapping;
import robotlegs.bender.extensions.matching.TypeMatcher;
import openfl.ObjectHash;
import robotlegs.bender.extensions.viewprocessormap.impl.NullViewProcessorUnmapper;

class ViewProcessorMap implements IViewProcessorMap implements IViewHandler {

    var _mappers : ObjectHash<Dynamic,Dynamic>;
    var _factory : IViewProcessorFactory;
    var _handler : IViewProcessorViewHandler;
    var NULL_UNMAPPER : IViewProcessorUnmapper;
    @inject
    public function new(factory : ViewProcessorFactory, handler : ViewProcessorViewHandler = null) {
        _mappers = new ObjectHash();
        NULL_UNMAPPER = new NullViewProcessorUnmapper();
        _factory = factory;
        _handler = handler || new ViewProcessorViewHandler(_factory);
    }

    //---------------------------------------
        // IViewProcessorMap Implementation
        //---------------------------------------
        public function mapMatcher(matcher : ITypeMatcher) : IViewProcessorMapper {
        return _mappers[matcher.createTypeFilter().descriptor] ||= createMapper(matcher);
    }

    public function map(type : Class<Dynamic>) : IViewProcessorMapper {
        var matcher : ITypeMatcher = new TypeMatcher().allOf(type);
        return mapMatcher(matcher);
    }

    public function unmapMatcher(matcher : ITypeMatcher) : IViewProcessorUnmapper {
        return _mappers[matcher.createTypeFilter().descriptor] || NULL_UNMAPPER;
    }

    public function unmap(type : Class<Dynamic>) : IViewProcessorUnmapper {
        var matcher : ITypeMatcher = new TypeMatcher().allOf(type);
        return unmapMatcher(matcher);
    }

    public function process(item : Dynamic) : Void {
        var type : Class<Dynamic> = Type.getClass(item.constructor);
        _handler.processItem(item, type);
    }

    public function unprocess(item : Dynamic) : Void {
        var type : Class<Dynamic> = Type.getClass(item.constructor);
        _handler.unprocessItem(item, type);
    }

    //---------------------------------------
        // IViewHandler Implementation
        //---------------------------------------
        public function handleView(view : DisplayObject, type : Class<Dynamic>) : Void {
        _handler.processItem(view, type);
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function createMapper(matcher : ITypeMatcher, viewType : Class<Dynamic> = null) : IViewProcessorMapper {
        return new ViewProcessorMapper(matcher.createTypeFilter(), _handler);
    }

}

