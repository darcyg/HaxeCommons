package robotlegs.bender.extensions.viewprocessormap.impl;

import minject.Injector;
import openfl.ObjectHash;
import flash.events.IEventDispatcher;

class ViewInjectionProcessor {

    var _injectedObjects : ObjectHash<Dynamic,Dynamic>;
    public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
        _injectedObjects.get(view) != null || injectAndRemember(view, injector) != null;
    }

    public function unprocess(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
    }

    function injectAndRemember(view : Dynamic, injector : Injector) : Void {
        injector.injectInto(view);
        _injectedObjects.set(view, view);
    }


    public function new() {
        _injectedObjects = new ObjectHash();
    }
}

