package com.oishigroup
{
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.display.BaseInteractController;
	import EXIT.starlingiso.display.IsoWorld;
	
	import com.oishigroup.metadata.MetaData;
	
	public class MainIsoWorld extends IsoWorld
	{
		public function MainIsoWorld( _interactController:BaseInteractController, _isDebug:Boolean=true)
		{
			var worldData:WorldData = new WorldData(20,50,128,MetaData.stageWidth,MetaData.stageHeight, 0 , 0 );
			super(worldData, _interactController, _isDebug);
		}
	}
}