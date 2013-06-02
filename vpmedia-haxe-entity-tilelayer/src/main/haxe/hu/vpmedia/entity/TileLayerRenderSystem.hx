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
package hu.vpmedia.entity;

import aze.display.TileLayer;
import aze.display.TilesheetEx;
import flash.display.Bitmap;
import flash.display.BitmapData;
/**
 * @author Andras Csizmadia
 * @version 1.0
 */
class TileLayerRenderSystem extends BaseEntitySystem
{    
    public var nodeList:Dynamic;
    public var tilesheet:TilesheetEx;
    public var canvas:TileLayer;
    
    public function new(priority:Int, world:BaseEntityWorld, tilesheet:TilesheetEx)
    {
        this.tilesheet = tilesheet;
        super(priority, world);
        initialize();        
    }    
    
    function initialize():Void
    {
        canvas = new TileLayer(tilesheet);
        world.context.addChild(canvas.view);
        
        nodeList = world.getNodeList(TileLayerRenderNode);
        nodeList.nodeAdded.add(onNodeAdded);
        nodeList.nodeRemoved.add(onNodeRemoved);
    }
    
    override function dispose():Void
    {        
        super.dispose();
    }
    
    function onNodeAdded(node:TileLayerRenderNode):Void
    {
        canvas.addChild(node.tilelayerrender.skin);
        node.tilelayerrender.skin.x = node.position.x;
        node.tilelayerrender.skin.y = node.position.y;
        node.tilelayerrender.skin.rotation = node.position.rotation;
    }
    
    function onNodeRemoved(node:TileLayerRenderNode):Void
    {
        canvas.removeChild(node.tilelayerrender.skin);
    }
    
    override function step(timeDelta:Float):Void
    {        
        canvas.render();
        
        var node:TileLayerRenderNode = nodeList.head;
        while(node != null) 
        {            
            node.tilelayerrender.skin.x = node.position.x;
            node.tilelayerrender.skin.y = node.position.y;
            node.tilelayerrender.skin.rotation = node.position.rotation;
            node = node.next;            
        }
    }
}