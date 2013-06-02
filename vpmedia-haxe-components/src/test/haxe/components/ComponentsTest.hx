////////////////////////////////////////////////////////////////////////////////
//=BEGIN CLOSED LICENSE
//
// Copyright(c) 2012-2013 Andras Csizmadia.
// http://www.vpmedia.eu
//
// For information about the licensing and copyright please 
// contact Andras Csizmadia at andras@vpmedia.eu.
//
//=END CLOSED LICENSE
////////////////////////////////////////////////////////////////////////////////
package components;

import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatchersBase;

/**
* TBD
*/
class ComponentsTest extends MatchersBase
{    
    public function new() 
    {
        super();
        // https://github.com/massiveinteractive/MassiveUnit/wiki/Working-with-test-classes
    }
    
    @Test
    public function testExample():Void
    {
        Assert.isTrue(true);
    }

}