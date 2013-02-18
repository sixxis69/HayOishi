package com.oishigroup
{
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.display.BaseInteractController;
	import EXIT.starlingiso.display.IsoWorld;
	import EXIT.starlingiso.interactcontroller.MouseInteractController;
	
	import com.oishigroup.metadata.MetaData;
	
	import flash.events.Event;
	
	import starling.display.Sprite;
	
	public class MainGame extends Sprite
	{
		protected var mainIsoWorld:MainIsoWorld;
		public function MainGame(_interactiveController:BaseInteractController)
		{
			super();
			mainIsoWorld = new MainIsoWorld(_interactiveController,MetaData.isDebug);
			addChild(mainIsoWorld);
		}
	}
}