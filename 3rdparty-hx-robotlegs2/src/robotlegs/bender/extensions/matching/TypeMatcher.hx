//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

import flash.errors.IllegalOperationError;

class TypeMatcher implements ITypeMatcher implements ITypeMatcherFactory {

    /*============================================================================*/    
    /* Protected Properties                                                       */    
    /*============================================================================*/    
    var _allOfTypes : Array<Class<Dynamic>>;
    var _anyOfTypes : Array<Class<Dynamic>>;
    var _noneOfTypes : Array<Class<Dynamic>>;
    var _typeFilter : ITypeFilter;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    // TODO - make the API nice DSL
        public function allOf(types:Array<Dynamic>) : TypeMatcher {
        pushAddedTypesTo(types, _allOfTypes);
        return this;
    }

    public function anyOf(types:Array<Dynamic>) : TypeMatcher {
        pushAddedTypesTo(types, _anyOfTypes);
        return this;
    }

    public function noneOf(types:Array<Dynamic>) : TypeMatcher {
        pushAddedTypesTo(types, _noneOfTypes);
        return this;
    }

    public function createTypeFilter() : ITypeFilter {
        // calling this seals the matcher
        var result:ITypeFilter;
        if (_typeFilter != null)
        {
            result = _typeFilter;
        } else {
            _typeFilter = buildTypeFilter();
            result = _typeFilter;
        }
        return result; 
    }

    public function lock() : ITypeMatcherFactory {
        createTypeFilter();
        return this;
    }

    public function clone() : TypeMatcher {
        return new TypeMatcher().allOf(_allOfTypes).anyOf(_anyOfTypes).noneOf(_noneOfTypes);
    }

    /*============================================================================*/    /* Protected Functions                                                        */    /*============================================================================*/    function buildTypeFilter() : ITypeFilter {
        if((_allOfTypes.length == 0) && (_anyOfTypes.length == 0) && (_noneOfTypes.length == 0))  {
            throw new TypeMatcherError(TypeMatcherError.EMPTY_MATCHER);
        }
        return new TypeFilter(_allOfTypes, _anyOfTypes, _noneOfTypes);
    }

    function pushAddedTypesTo(types : Array<Dynamic>, targetSet : Array<Class<Dynamic>>) : Void {
        _typeFilter != null && throwSealedMatcherError() != null;
        pushValuesToClassVector(types, targetSet);
    }

    function throwSealedMatcherError() : Void {
        throw new IllegalOperationError("This TypeMatcher has been sealed and can no longer be configured");
    }

    function pushValuesToClassVector(values : Array<Dynamic>, vector : Array<Class<Dynamic>>) : Void {
        /*var isVector:Bool = Std.is(values[0], Vector<Dynamic>);*/
        if(values.length == 1 && Std.is(values[0], Array) ) {
            for(type in cast(values[0],Array<Dynamic>)) {
                vector.push(type);
            }
        }
        else  {
            for(type in values) {
                vector.push(type);
            }

        }

    }


    public function new() {
        _allOfTypes = new Array<Class<Dynamic>>();
        _anyOfTypes = new Array<Class<Dynamic>>();
        _noneOfTypes = new Array<Class<Dynamic>>();
    }
}

