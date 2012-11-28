package scripts
{
	//import flash.events.*;
	//import flash.net.*;
	//import flash.filters.*;
	import flash.display.BitmapData;
	//import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	//import Box2DAS.Collision.*;
	//import Box2DAS.Collision.Shapes.*;
	//import Box2DAS.Common.*;
	//import Box2DAS.Dynamics.*;
	//import Box2DAS.Dynamics.Contacts.*;
	//import Box2DAS.Dynamics.Joints.*;

	//import stencyl.api.data.*;
	import stencyl.api.engine.*;
	import stencyl.api.engine.actor.*;
	import stencyl.api.engine.behavior.*;
	//import stencyl.api.engine.bg.*;
	//import stencyl.api.engine.font.*;
	//import stencyl.api.engine.scene.*;
	//import stencyl.api.engine.sound.*;
	//import stencyl.api.engine.tile.*;
	//import stencyl.api.engine.utils.*;
	//import org.flixel.*;

	
	public dynamic class Design_1_1_ExplodeCode extends ActorScript
	{		
		[Attribute(id="1", name="Gib Size", desc="The width and length of each gib.")]
		public var _gibSize:int;
		[Attribute(id="2", name="Angular Velocity", desc="The angular velocity of each gib will be set randomly between -this and this.")]
		public var _angularVelocity:int;
		[Attribute(id="3", name="Velocity", desc="The velocity of each gib.")]
		public var _velocity:int;
		[Attribute(id="4", name="Continuous Collision Detection", desc="When true, makes the gibs unable to pass through terrain. May be needed at high speeds or with small gibs. Does very bad things to your frame rate! Like, it literally murders it an buries it in the backyard. Then it steals its identity and you don't know that you've been sharing your bed with your frame rate's murderer for twenty years! You start to get suspicious, but no one belives you. When you confront it, a struggle ensues, and you end up killing it! Now you're serving a life-sentence in prison, a broken shell of your former self.")]
		public var _continuousCollisionDetection:Boolean;

		var masterArray:Array = new Array();
		var rect:Rectangle;
		var pnt:Point = new Point(0,0);

		public function explode():void {
			var bmd:BitmapData;
			var width:uint = actor.getWidth();
			var height:uint = actor.getHeight();
			for(var i=0;i<=height-_gibSize;i+=_gibSize) {
				for(var j=0;j<=width-_gibSize;j+=_gibSize) {		   			
			   		rect = new Rectangle(i, j, _gibSize, _gibSize);
			   		bmd = new BitmapData(_gibSize,_gibSize);
			   		bmd.copyPixels(actor.currSprite._framePixels, rect, pnt);
			   		//masterArray.push([bmd, i, j]);
			   		createRecycledActor(getActorTypeByName("Gib"), actor.getX()+i, actor.getY()+j, FRONT);
			   		getLastCreatedActor().setAnimation(_gibSize.toString());
	        			getLastCreatedActor().currSprite.pixels = bmd;
	        			getLastCreatedActor().setAngularVelocity(randomInt(Math.floor(-_angularVelocity), Math.floor(_angularVelocity)));
	        			getLastCreatedActor().applyImpulse(randomInt(Math.floor(-50), Math.floor(50)), randomInt(Math.floor(-50), Math.floor(50)), _velocity);
	        			getLastCreatedActor().killSelfAfterLeavingScreen();
	        			if(_continuousCollisionDetection) makeActorNotPassThroughTerrain(getLastCreatedActor());
				}
			}
	        	actor.kill();
		}
		
		//Do all actor initialization here
		override public function init():void
		{			
			nameMap["Gib Size"] = "_gibSize";
			nameMap["Angular Velocity"] = "_angularVelocity";
			nameMap["Velocity"] = "_velocity";
			nameMap["Animation"] = "_animation";
		}
		
		//This is executed every frame of the game
		override public function update():void
		{
		}
		
		override public function draw(g:Graphics, x:Number, y:Number):void
		{
		}
		
		override public function handleCollision(event:Collision):void
		{
		}
		
		//Leave this alone. Do your initializing inside init()
		public function Design_1_1_ExplodeCode(actor:Actor, scene:GameState)
		{
			super(actor, scene);
		}
	}
}