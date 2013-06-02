package robotlegs.bender.extensions.viewprocessormap.api;

import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapper;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorUnmapper;

interface IViewProcessorMap {

    function mapMatcher(matcher : ITypeMatcher) : IViewProcessorMapper;
    function map(type : Class<Dynamic>) : IViewProcessorMapper;
    function unmapMatcher(matcher : ITypeMatcher) : IViewProcessorUnmapper;
    function unmap(type : Class<Dynamic>) : IViewProcessorUnmapper;
    function process(item : Dynamic) : Void;
    function unprocess(item : Dynamic) : Void;
}

