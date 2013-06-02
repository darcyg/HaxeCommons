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
package hu.vpmedia.components;

import flash.display.Sprite;
import flash.events.Event;
import hu.vpmedia.components.shapes.IBaseShape;
import xrope.ILayoutGroup;

/**
 * @author Andras Csizmadia
 * @version 1.0
 */
class BaseSkin
{
    public var owner:BaseComponent;
    public var layout:ILayoutGroup;
    public var componentPartList:Array<BaseComponent>;
           
    //----------------------------------
    //  Constructor
    //----------------------------------
    function new(owner:BaseComponent)
    {
        //super();
        this.owner = owner; 
    }
    
    //----------------------------------
    //  Core
    //----------------------------------
    
    public function initialize():Void
    { 
        componentPartList = new Array();
        createChildren();
    } 
    
    function createChildren():Void
    { 
        // abstracat
    }
        
    public function dispose():Void
    {
        /*var n:Int = componentPartList.length;
        for (i in 0...n)
        {
            componentPartList[i].dispose();
        }  */      
    }
    
    //----------------------------------
    //  Draw
    //----------------------------------
    
    public function draw():Void
    {        
        if (owner.isDisposed) 
        {
            return;
        }       
        
        /*#if debug
        L.info("draw"+"::"+owner.isInvalid(ComponentChange.ALL));
        #end */
        
        // self
        
        if (owner.isInvalid(ComponentChange.DATA))
        {
            updateData();
            owner.validate(ComponentChange.DATA);
        }  
                
        if (owner.isInvalid(ComponentChange.STATE))
        {
            updateState();
            owner.validate(ComponentChange.STATE);
        }      
        
        if (owner.isInvalid(ComponentChange.STYLE))
        {
            updateStyle();
            owner.validate(ComponentChange.STYLE);
        }  
        
        if (owner.isInvalid(ComponentChange.SIZE))
        {
            updateSize();
            owner.validate(ComponentChange.SIZE);
        }        
        
        if (owner.isInvalid(ComponentChange.ALL))
        {
            owner.validate(ComponentChange.ALL);
        }     
    }
    
    public function setCurrentStateToChilds():Void
    {        
        // sub comps
        var n:Int = componentPartList.length;
        for (i in 0...n)
        {
            /*#if debug
            L.debug("Setting "+ Std.string(owner.getState())+ " state to sub component:"+componentPartList[i]);
            #end */           
            componentPartList[i].setState(owner.getState());
            //componentPartList[i].draw();
        }         
    }
    
    public function updateState():Void
    {
        /*#if debug
        L.debug("updateState");
        #end  */  
    }
        
    public function updateStyle():Void
    {
        /*#if debug
        L.debug("updateStyle");
        #end*/  
    }

    public function updateData():Void
    {
        /*#if debug
        L.debug("updateData");
        #end  */  
    }

    public function updateSize():Void
    {
        /*#if debug
        L.debug("updateSize");
        #end */   
    }

}