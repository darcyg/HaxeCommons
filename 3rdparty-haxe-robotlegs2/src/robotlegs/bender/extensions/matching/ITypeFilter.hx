//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.matching;

interface ITypeFilter {
    var allOfTypes(getAllOfTypes, never) : Array<Class<Dynamic>>;
    var anyOfTypes(getAnyOfTypes, never) : Array<Class<Dynamic>>;
    var descriptor(getDescriptor, never) : String;
    var noneOfTypes(getNoneOfTypes, never) : Array<Class<Dynamic>>;

    function getAllOfTypes() : Array<Class<Dynamic>>;
    function getAnyOfTypes() : Array<Class<Dynamic>>;
    function getDescriptor() : String;
    function getNoneOfTypes() : Array<Class<Dynamic>>;
    function matches(item : Dynamic) : Bool;
}

