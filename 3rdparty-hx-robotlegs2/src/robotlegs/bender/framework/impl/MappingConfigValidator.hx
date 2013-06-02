package robotlegs.bender.framework.impl;

import robotlegs.bender.framework.api.MappingConfigError;

class MappingConfigValidator {
    public var valid(getValid, never) : Bool;

    var CANT_CHANGE_GUARDS_AND_HOOKS : String;
    var STORED_ERROR_EXPLANATION : String;
    var _guards : Array<Dynamic>;
    var _hooks : Array<Dynamic>;
    var _trigger : Dynamic;
    var _action : Dynamic;
    var _storedError : MappingConfigError;
    var _valid : Bool;
    public function new(guards : Array<Dynamic>, hooks : Array<Dynamic>, trigger : Dynamic, action : Dynamic) {
        CANT_CHANGE_GUARDS_AND_HOOKS = "You can't change the guards and hooks on an existing mapping. Unmap first.";
        STORED_ERROR_EXPLANATION = " The stacktrace for this error was stored at the time when you duplicated the mapping - you may have failed to add guards and hooks that were already present.";
        _valid = false;
        _guards = guards;
        _hooks = hooks;
        _trigger = trigger;
        _action = action;
        //super();
    }

    public function getValid() : Bool {
        return _valid;
    }

    public function invalidate() : Void {
        _valid = false;
        _storedError = new MappingConfigError(CANT_CHANGE_GUARDS_AND_HOOKS + STORED_ERROR_EXPLANATION, _trigger, _action);
    }

    public function validate(guards : Array<Dynamic>, hooks : Array<Dynamic>) : Void {
        if((!arraysMatch(_guards, guards)) || (!arraysMatch(_hooks, hooks))) 
            throwStoredError() || throwMappingError() != null;
        _valid = true;
        _storedError = null;
    }

    public function checkGuards(guards : Array<Dynamic>) : Void {
        if(changesContent(_guards, guards)) 
            throwMappingError();
    }

    public function checkHooks(hooks : Array<Dynamic>) : Void {
        if(changesContent(_hooks, hooks)) 
            throwMappingError();
    }

    function changesContent(current : Array<Dynamic>, proposed : Array<Dynamic>) : Bool {
        proposed = flatten(proposed);
        for(item in proposed/* AS3HX WARNING could not determine type for var: item exp: EIdent(proposed) type: Array<Dynamic>*/) {
            if(Lambda.indexOf(current,item) == -1) 
                return true;
        }

        return false;
    }

    function arraysMatch(arr1 : Array<Dynamic>, arr2 : Array<Dynamic>) : Bool {
        arr1 = arr1.slice(0,0);//was arr1.slice();
        if(arr1.length != arr2.length) 
            return false;
        var foundAtIndex : Int;
        var iLength : Int = arr2.length;
        var i : Int = 0;
        while(i < iLength) {
            foundAtIndex = Lambda.indexOf(arr1,arr2[i]);
            if(foundAtIndex == -1) 
                return false;
            arr1.splice(foundAtIndex, 1);
            i++;
        }
        return true;
    }

    public function flatten(array : Array<Dynamic>) : Array<Dynamic> {
        var flattened : Array<Dynamic> = [];
        for(obj in array/* AS3HX WARNING could not determine type for var: obj exp: EIdent(array) type: null*/) {
            if(Std.is(obj, Array))  {
                flattened = flattened.concat(flatten(obj));
            }

            else  {
                flattened.push(obj);
            }

        }

        return flattened;
    }

    function throwMappingError() : Void {
        throw (new MappingConfigError(CANT_CHANGE_GUARDS_AND_HOOKS, _trigger, _action));
    }

    function throwStoredError() : Bool {
        if(_storedError != null) 
            throw _storedError;
        return false;
    }

}

