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
import hu.vpmedia.components.shapes.IBaseShape;
import hu.vpmedia.components.shapes.SolidFill;        
import hu.vpmedia.components.shapes.GradientFill;
import hu.vpmedia.components.shapes.GradientItem;
import hu.vpmedia.components.shapes.GradientStroke;
import hu.vpmedia.components.shapes.RoundedRectangleShape;

/**
 * Panel
 */
class PanelSkin extends BaseSkin
{      
    public var background:IBaseShape;
    public var fill:GradientFill;
    public var stroke:GradientStroke;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    /**
    * Constructor
    */
    public function new(owner:BaseComponent)
    {
        super(owner);
    }
    
    override function createChildren():Void
    {
        super.createChildren();    
        
        var fillArray:Array<GradientItem> = [];
        fillArray.push(new GradientItem(1,owner.getStyleValue("bgColor1",true),0));
        fillArray.push(new GradientItem(1,owner.getStyleValue("bgColor2",true),255));
        var strokeArray:Array<GradientItem> = [];
        strokeArray.push(new GradientItem(1,owner.getStyleValue("borderColor1",true),0));
        strokeArray.push(new GradientItem(1, owner.getStyleValue("borderColor2", true), 255));
        fill = new GradientFill(fillArray);
        stroke = new GradientStroke(strokeArray);
        background  = new RoundedRectangleShape(owner.canvas, 0, 0, owner.width, owner.height, owner.getStyleValue("ellipse"), fill, stroke, false);  
    }
    
    override public function updateStyle():Void
    {
        fill.gradientColors[0] = owner.getStyleValue("bgColor1",true);
        fill.gradientColors[1] = owner.getStyleValue("bgColor2",true);
        stroke.gradientColors[0] = owner.getStyleValue("borderColor1",true);
        stroke.gradientColors[1] = owner.getStyleValue("borderColor2",true);
        
       // L.info("draw" + fill.gradientColors[0] + ":" + fill.gradientColors[1]);
        
        //background.width = owner.width;
        //background.height = owner.height;        
        
        background.draw();
        
        super.updateStyle();
    }
    
    override public function updateSize():Void
    {
        background.width = owner.width;
        background.height = owner.height;        
        
        background.draw();
        
        super.updateSize();
    }
    /*override function draw():Void
    {        
        fill.gradientColors[0] = owner.getStyleValue("bgColor1",true);
        fill.gradientColors[1] = owner.getStyleValue("bgColor2",true);
        stroke.gradientColors[0] = owner.getStyleValue("borderColor1",true);
        stroke.gradientColors[1] = owner.getStyleValue("borderColor2",true);
        
        L.info("draw" + fill.gradientColors[0] + ":" + fill.gradientColors[1]);
        
        background.width = owner.width;
        background.height = owner.height;        
        
        background.draw();
    }*/
}