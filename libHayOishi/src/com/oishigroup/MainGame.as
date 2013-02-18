package com.oishigroup
{
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.display.IsoWorld;
	import EXIT.starlingiso.interactcontroller.MouseInteractController;
	import com.oishigroup.metadata.MetaData;
	import starling.display.Sprite;
	
	public class MainGame extends Sprite
	{
		private var isoWorld:IsoWorld;
		public function MainGame()
		{
			super();
			
			var worldData:WorldData = new WorldData(20,50,128,MetaData.stageWidth,MetaData.stageHeight, 0 , 0 );
			isoWorld = new IsoWorld(worldData , new MouseInteractController(),MetaData.isDebug);
			addChild(isoWorld);
		}
	}
}