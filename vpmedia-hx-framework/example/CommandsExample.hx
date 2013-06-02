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

package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.EventDispatcher;
import flash.Lib;
import hu.vpmedia.commands.BaseCommand;
import hu.vpmedia.commands.CallFunctionCommand;
import hu.vpmedia.commands.IBaseCommand;
import hu.vpmedia.commands.MacroCommand;
import hu.vpmedia.commands.SequenceCommand;
import hu.vpmedia.commands.SetPropertiesCommand;
import hu.vpmedia.commands.SignalCommandMapQueue;
import hu.vpmedia.signals.SignalLite;
 
class CommandsExample extends Sprite 
{    
    var subject:SequenceCommand;
    
    var signal:Signal;
    var signalMap:SignalCommandMapQueue;
        
    var prop:String;
    
    //----------------------------------
    //  Constructor
    //----------------------------------

    public static function main () {
        Lib.current.addChild (new CommandsExample());
    } 
    
    public function new()
    {
        super();
        Lib.current.addChild(this);   
        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
        initialize ();
    }
    
    //----------------------------------
    //  Bootstrap
    //----------------------------------

    private function initialize ():Void 
    {           
        subject = new SequenceCommand();
        subject.signal.add(subjectHandler);
        subject.addCommand(new BaseCommand(1));
        subject.clear();
        
        // simple set properties test
        subject.addCommand(new SetPropertiesCommand(this,{prop:"value"},1));
       
        // add first twice
        subject.addCommand(new CallFunctionCommand(this,testMethod,["b",2],1));        
        subject.addCommandAt(new CallFunctionCommand(this,testMethod,["a",1],1),1);
        
        // macro command array   
        var macroCommands:Array<IBaseCommand> = [];
        macroCommands.push(new CallFunctionCommand(this,testMethod,["macro1",1],1));
        macroCommands.push(new CallFunctionCommand(this,testMethod,["macro2",2],1));
        var macroCommand:MacroCommand = new MacroCommand(false, macroCommands);
        macroCommand.signal.add(macroHandler);
        subject.addCommand(macroCommand);
                         
        // sequence command array
        var sequenceCommands:Array<IBaseCommand> = [];
        sequenceCommands.push(new CallFunctionCommand(this,testMethod,["seq1",1],1));
        sequenceCommands.push(new CallFunctionCommand(this,testMethod,["seq2",2],1));
        var sequence:SequenceCommand = new SequenceCommand(false, sequenceCommands);
        sequence.signal.add(sequenceHandler);
        subject.addCommand(sequence);
        
       // subject.addCommand(new CallFunctionCommand(this,testMethod,["seq after",3],1));  
                
        // start sequencer
        subject.start();
        
        // signal command map
        signal = new Signal();
        signalMap = new SignalCommandMapQueue(signal);
		var subParams:Array<Dynamic> = ["map1", 1];
		var params:Array<Dynamic> = [this, testMethod, subParams];
        signalMap.addCommand(CallFunctionCommand, "TEST1", null, params,false);
        signal.dispatch(["TEST1", null, null, null]);  
    }
    
    function testMethod (p1:String,p2:Int):Void
    {
        trace("testMethod"+"::"+p1+"::"+p2);        
    }
    
    function macroHandler (code:String, level:String, data:Dynamic, source:Dynamic):Void
    {
        trace("macroHandler: " + code);
    }
    
    function sequenceHandler (code:String, level:String, data:Dynamic, source:Dynamic):Void
    {
        trace("sequenceHandler: " + code);        
    }
    
    function subjectHandler (code:String, level:String, data:Dynamic, source:Dynamic):Void
    {
        trace("subjectHandler: " + code);
        
        /*if (event.code == QueueCodes.COMPLETE)
        {
            trace(prop);
        }*/
    }

}
