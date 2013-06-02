package robotlegs.bender.framework.api;

class MappingConfigError /*extends Error*/ {
    public var trigger(getTrigger, never) : Dynamic;
    public var action(getAction, never) : Dynamic;

    public function new(message : String, trigger : Dynamic, action : Dynamic) {
        //super(message);
        _trigger = trigger;
        _action = action;
    }

    var _trigger : Dynamic;
    public function getTrigger() : Dynamic {
        return _trigger;
    }

    var _action : Dynamic;
    public function getAction() : Dynamic {
        return _action;
    }

}

