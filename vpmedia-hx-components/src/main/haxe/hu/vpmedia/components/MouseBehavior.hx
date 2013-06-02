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

import flash.events.MouseEvent;

/**
 * @author Andras Csizmadia
 * @version 1.0
 */
class MouseBehavior extends BaseBehavior
{    
    public var isOver:Bool;
    public var isDown:Bool;
    public var isToggle:Bool;
    public var isSelected:Bool;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(owner:BaseComponent)
    {
        super(owner);
    }

    //--------------------------------------
    //  Private(protected)
    //--------------------------------------
    /**
     * Abstract
     */
    override function initialize():Void
    {
        owner.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
        owner.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
        owner.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
    }  
    
    override function dispose():Void
    {
        owner.removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
        owner.removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
        owner.removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
    }  

    function mouseHandler(event:MouseEvent):Void
    {
        switch (event.type)
        {
            case MouseEvent.ROLL_OVER:
                isOver=true;
                owner.setState(ComponentState.OVER);
            case MouseEvent.ROLL_OUT:
                isOver=false;
                if (!isDown)
                {
                    owner.setState(ComponentState.DEFAULT);
                }
            case MouseEvent.MOUSE_DOWN:
                isDown=true;
                if (isToggle)
                {
                    isSelected=!isSelected;
                }
                owner.stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler, false, 0, true);
                owner.setState(ComponentState.DOWN);
            case MouseEvent.MOUSE_UP:
                isDown=false;
                owner.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
                if (isOver)
                {
                    owner.setState(ComponentState.OVER);
                }
                else
                {
                    owner.setState(ComponentState.DEFAULT);
                }
        }
    }

}