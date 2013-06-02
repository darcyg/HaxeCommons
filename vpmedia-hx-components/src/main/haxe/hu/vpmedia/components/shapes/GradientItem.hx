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
package hu.vpmedia.components.shapes;

class GradientItem
{
    public var alpha:Float;
    public var color:Int;
    public var ratio:Int;
    
    //--------------------------------------
    //  Constructor
    //--------------------------------------
    public function new(?alpha:Float=1,?color:Int=0x000000,?ratio:Int=0)
    {
        this.alpha=alpha;
        this.color=color;
        this.ratio=ratio;
    }
}