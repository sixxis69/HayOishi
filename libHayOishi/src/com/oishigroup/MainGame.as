package com.oishigroup
{
	import EXIT.starlingiso.display.BaseInteractController;
	import EXIT.starlingiso.display.ObjectStatic;
	
	import com.oishigroup.controller.MenuBuildingViewController;
	import com.oishigroup.metadata.MetaData;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class MainGame extends Sprite
	{
		protected var mainIsoWorld:MainIsoWorld;
		protected var menuBuildingViewController:MenuBuildingViewController;
		public function MainGame(_interactiveController:BaseInteractController)
		{
			super();
			mainIsoWorld = new MainIsoWorld(_interactiveController,MetaData.isDebug);
			addChild(mainIsoWorld);
			menuBuildingViewController = new MenuBuildingViewController();
			addChild(menuBuildingViewController.view);
			
			forTest();
		}
		
		private function forTest():void
		{
			var tempObjs:Vector.<ObjectStatic> = new Vector.<ObjectStatic>();
			for( var i:uint=0 ; i<=4 ; i++){
				var quad:Quad = new Quad(100,100,0xAAAAAA*Math.random(),false);
				var obj:ObjectStatic = new ObjectStatic(quad,2,2);
				obj.setColumnRow(i*2,i);
				mainIsoWorld.addIsoObject(obj);
				tempObjs.push(obj);
			}
			mainIsoWorld.removeIsoObject(tempObjs[3]);
			mainIsoWorld.removeIsoObject(tempObjs[4]);
			mainIsoWorld.removeIsoObject(tempObjs[1]);
			mainIsoWorld.removeIsoObject(tempObjs[2]);
			mainIsoWorld.removeIsoObject(tempObjs[0]);
		}
	}
}