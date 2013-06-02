//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

class TypeFilter implements ITypeFilter {
    public var allOfTypes(getAllOfTypes, never) : Array<Class<Dynamic>>;
    public var anyOfTypes(getAnyOfTypes, never) : Array<Class<Dynamic>>;
    public var descriptor(getDescriptor, never) : String;
    public var noneOfTypes(getNoneOfTypes, never) : Array<Class<Dynamic>>;

    /*============================================================================*/    /* Public Properties                                                          */    /*============================================================================*/    // TODO: Discuss whether we should return a slice here instead
        // of references to actual vectors. Overhead vs encapsulation.
        var _allOfTypes : Array<Class<Dynamic>>;
    public function getAllOfTypes() : Array<Class<Dynamic>> {
        return _allOfTypes;
    }

    var _anyOfTypes : Array<Class<Dynamic>>;
    public function getAnyOfTypes() : Array<Class<Dynamic>> {
        return _anyOfTypes;
    }

    var _descriptor : String;
    public function getDescriptor() : String {
        if (_descriptor == null)
        {
            _descriptor = createDescriptor();
        }
        return _descriptor;
    }

    var _noneOfTypes : Array<Class<Dynamic>>;
    public function getNoneOfTypes() : Array<Class<Dynamic>> {
        return _noneOfTypes;
    }

    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(allOf : Array<Class<Dynamic>>, anyOf : Array<Class<Dynamic>>, noneOf : Array<Class<Dynamic>>) {
        if(allOf == null || anyOf == null || noneOf == null) 
        {
            //TODO: throw cast(("TypeFilter parameters can not be null"), ArgumentError);
        }
        _allOfTypes = allOf;
        _anyOfTypes = anyOf;
        _noneOfTypes = noneOf;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function matches(item : Dynamic) : Bool {
        var i : Int = _allOfTypes.length;
        while(i-- > 0) {
            if(!(Std.is(item, _allOfTypes[i])))  {
                return false;
            }
        }

        i = _noneOfTypes.length;
        while(i-- > 0) {
            if(Std.is(item, _noneOfTypes[i]))  {
                return false;
            }
        }

        if(_anyOfTypes.length == 0 && (_allOfTypes.length > 0 || _noneOfTypes.length > 0))  {
            return true;
        }
        i = _anyOfTypes.length;
        while(i-- > 0) {
            if(Std.is(item, _anyOfTypes[i]))  {
                return true;
            }
        }

        return false;
    }

    /*============================================================================*/    /* Protected Functions                                                        */    /*============================================================================*/    function alphabetiseCaseInsensitiveFCQNs(classVector : Array<Class<Dynamic>>) : Array<String> {
        var fqcn : String;
        var allFCQNs : Array<String> = cast [];
        var iLength : Int = classVector.length;
        var i : Int = 0;
        while(i < iLength) {
            fqcn = Type.getClassName(classVector[i]);
            allFCQNs[allFCQNs.length] = fqcn;
            i++;
        }
        allFCQNs.sort(stringSort);
        return allFCQNs;
    }

    function createDescriptor() : String {
        var allOf_FCQNs : Array<String> = alphabetiseCaseInsensitiveFCQNs(allOfTypes);
        var anyOf_FCQNs : Array<String> = alphabetiseCaseInsensitiveFCQNs(anyOfTypes);
        var noneOf_FQCNs : Array<String> = alphabetiseCaseInsensitiveFCQNs(noneOfTypes);
        return "all of: " + allOf_FCQNs.toString() + ", any of: " + anyOf_FCQNs.toString() + ", none of: " + noneOf_FQCNs.toString();
    }

    function stringSort(item1 : String, item2 : String) : Int {
        if(item1 < item2)  {
            return 1;
        }
        return -1;
    }

}

