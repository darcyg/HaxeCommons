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

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;

import h3d.mat.*;
import h3d.prim.*;
import h3d.scene.*;

import hu.vpmedia.entity.*;
import hu.vpmedia.entity.commons.*;

class MainH3D extends Sprite {
    
    public var world:BaseEntityWorld;
    
    public static function main() {       
        Lib.current.addChild ( new MainH3D() );
    }
    
    public function new()
    {
        super();
        Lib.current.addChild(this);   
        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
        addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler,false,0,true);        
        stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated, false, 0, true);
        world = new BaseEntityWorld(this);
        world.addSystem(new H3DRenderSystem(SystemTypes.RENDER, world));   
    }
    
    public function onRemovedHandler(event:Event):Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
        world.dispose();
    }
    
    public function onContextCreated(event:Event):Void
    {              
        haxe.Timer.delay(addEntities, 1000);
    }
    
    public function addEntities():Void
    {   		
		var skin:BitmapData = new BitmapData(256, 256);
		skin.perlinNoise(64, 64, 3, 0, true, true, 7);
		//addChild(new Bitmap(skin));
		var material:MeshMaterial = new MeshMaterial(Texture.fromBitmap(skin));
		
		var geometry:Cube = new Cube();
		geometry.translate( -0.5, -0.5, -0.5);
		//geometry.addTCoords();
		
		var mesh:Mesh = new Mesh(geometry, material);
		
        var entity:BaseEntity = new BaseEntity();
        entity.addComponent(new Position3DComponent({x:0,y:0,z:0}));
        entity.addComponent(new H3DRenderComponent(mesh));
        world.addEntity(entity); 
        
    }
}
