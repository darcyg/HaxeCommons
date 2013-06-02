package hxBehaviors.examples;

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

import haxe.ds.GenericStack;

import hxBehaviors.Vehicle;
import hxBehaviors.VehicleGroup;
import hxBehaviors.behavior.Behavior;
import hxBehaviors.behavior.Alignment;
import hxBehaviors.behavior.Arrival;
import hxBehaviors.behavior.Cohesion;
import hxBehaviors.behavior.Flee;
import hxBehaviors.behavior.Seek;
import hxBehaviors.behavior.Separation;
import hxBehaviors.behavior.UnalignedCollisionAvoidance;
import hxBehaviors.behavior.Wander;
import hxBehaviors.behavior.combined.Flocking;
import hxBehaviors.behavior.combined.LeaderFollowing;
using hxBehaviors.Float3DTools;

import sandy.core.Scene3D;
import sandy.core.scenegraph.ATransformable;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.TransformGroup;
import sandy.primitive.Box;
import sandy.primitive.Cone;

class Example1 extends Sprite{
    public var scene:Scene3D;
    public var camera:Camera3D;
    public var obj:ATransformable;
    public var vehicleGroup:VehicleGroup;

    public function new():Void {
        super();

        if (stage != null) {
            init();
        } else {
            addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
        }
    }

    private function init(e:Event = null):Void {
        camera = new Camera3D( 640, 480 );
        camera.z = -400;

        var root:Group = new Group();
        scene = new Scene3D( "scene", this, camera, root );

        var flocking = new Flocking();
        //var leaderFollowing = new LeaderFollowing();
        //var separation = new Separation();
        
        vehicleGroup = new VehicleGroup();
        
        var fxObjs = new GenericStack<Vehicle>();
        for (i in 0...50) {
            var c = new Cone(null, 4, 30, 3, 1);
            c.rotateX = 90;
            var t = new TransformGroup();
            t.addChild(c);
            obj = t;
            root.addChild(t);

            var veh = new Vehicle();
            veh.vehicleRadius = 30;
            veh.maxSpeed = 12;
            veh.maxForce = 4;
            veh.position.setTo(0,0,0);
            veh.edgeBehavior = Vehicle.EDGE_BOUNCE;
            veh.boundsCentre.setTo(0,0,300);
            veh.boundsRadius = 400;
            veh.velocity.setUnitRandom();
            veh.velocity.scaleBy(3);
            veh.behaviorList = cast([flocking],Array<Dynamic>);
            veh.onUpdate = callback(onVehUpdate,t,veh);
            fxObjs.add(veh);
        }
        vehicleGroup.addVehicles(fxObjs);
        
        flocking.separate.separateList = flocking.align.alignList = flocking.cohere.cohereList = fxObjs;
        flocking.cohere.cohereDist = 50;
        flocking.cohere.cohereStrength = 12;
        flocking.align.alignDist = 60;
        flocking.align.alignStrength = 18;
        flocking.separate.separateDist = 20;
        flocking.separate.separateStrength = 20;
        
        addEventListener( Event.ENTER_FRAME, enterFrameHandler );
    }

    private function enterFrameHandler( event:Event ):Void {
        vehicleGroup.update();
        scene.render();
    }

    private function onVehUpdate(obj:ATransformable, veh:Vehicle):Void {
        var position = veh.position;
        obj.setPosition(position.x,position.y,position.z);
        var pt = position.add(veh.forward);
        obj.lookAt(pt.x,pt.y,pt.z);
    }

    static public function main():Void {
        #if flash
        Lib.current.addChild(new Example1());
        #else
        Lib.create(function(){
            Lib.current.addChild(new Example1());
        },640,480,25,0xFFFFFF,Lib.HARDWARE);
        #end
    }
}
