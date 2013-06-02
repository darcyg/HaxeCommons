////////////////////////////////////////////////////////////////////////////////
//=BEGIN MIT LICENSE
//
// The MIT License
// 
// Copyright (c) 2012-2013 Andras Csizmadia
// http://www.vpmedia.eu
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//=END MIT LICENSE
////////////////////////////////////////////////////////////////////////////////
package hu.vpmedia.stm.hfsm;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatchersBase;

/**
 * TBD
 */
class StateMachineTest extends MatchersBase
{    
    private var subject:StateMachine;
    
    public function new() 
    {
        super();
        // https://github.com/massiveinteractive/MassiveUnit/wiki/Working-with-test-classes
    }
    
    @Before
    public function setup():Void
    {
        subject = new StateMachine();
        subject.addState(new State("opened", ["closed"]));
        subject.addState(new State("closed", ["opened","locked"]));
        subject.addState(new State("locked", ["closed"]));
        subject.setInitialState("opened");       
    }
    
    @After
    public function tearDown():Void
    {
        subject = null;
    }
    
    @Test
    public function test_instantiate():Void
    {
        Assert.isNotNull(subject);
    }
    
    @Test
    public function test_initialState():Void
    {
        Assert.isNotNull(subject.getState().name == "opened");
    }
    
    @Test
    public function test_canChangeState():Void
    {
        Assert.isFalse(subject.canChangeStateTo("opened"));
        Assert.isFalse(subject.canChangeStateTo("locked"));
        Assert.isTrue(subject.canChangeStateTo("closed"));
    }
    
    @Test
    public function test_changingtToUnexistingState():Void
    {
        Assert.isFalse(subject.changeState("unknown"));
    }
    
    @Test
    public function test_changingtToDeniedState():Void
    {
        Assert.isFalse(subject.changeState("locked"));
    }
    
    @Test
    public function test_changingState():Void
    {
        Assert.isTrue(subject.changeState("closed"));
    }
    
    @Test
    public function test_inAvailStates():Void
    {
        Assert.isTrue(subject.getStates().exists("opened"));
        Assert.isFalse(subject.getStates().exists("unknown"));
    }
}