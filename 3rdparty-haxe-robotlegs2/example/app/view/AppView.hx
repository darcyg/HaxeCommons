package app.view;

/**
 * ...
 * @author Andras Csizmadia
 */

class AppView extends BaseView
{

    public function new() 
    {
        openfl.Lib.trace(this + "::" + "new");
        
        super();
        
        graphics.beginFill(0x666666, 1);
        graphics.drawRect(10, 10, 780, 580);
        graphics.endFill();
    }
    
}