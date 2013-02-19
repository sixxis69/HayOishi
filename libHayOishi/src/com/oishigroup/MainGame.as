package com.oishigroup
{
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.display.BaseInteractController;
	import EXIT.starlingiso.display.IsoWorld;
	import EXIT.starlingiso.display.ObjectStatic;
	import EXIT.starlingiso.interactcontroller.MouseInteractController;
	
	import com.oishigroup.metadata.MetaData;
	
	import flash.events.Event;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class MainGame extends Sprite
	{
		protected var mainIsoWorld:MainIsoWorld;
		public function MainGame(_interactiveController:BaseInteractController)
		{
			super();
			mainIsoWorld = new MainIsoWorld(_interactiveController,MetaData.isDebug);
			addChild(mainIsoWorld);
			forTest();
		}
		
		private function forTest():void
		{
			for( var i:uint=0 ; i<=5 ; i++){
				var quad:Quad = new Quad(100,100,0xAAAAAA*Math.random(),false);
				var obj:ObjectStatic = new ObjectStatic(quad,2,2);
				obj.setColumnRow(i,i);
				mainIsoWorld.addObject(obj);
			}
		}
	}
}