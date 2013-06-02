package robotlegs.bender.extensions.viewprocessormap.impl;

import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;

interface IViewProcessorViewHandler {

    function addMapping(mapping : IViewProcessorMapping) : Void;
    function removeMapping(mapping : IViewProcessorMapping) : Void;
    function processItem(item : Dynamic, type : Class<Dynamic>) : Void;
    function unprocessItem(item : Dynamic, type : Class<Dynamic>) : Void;
}

