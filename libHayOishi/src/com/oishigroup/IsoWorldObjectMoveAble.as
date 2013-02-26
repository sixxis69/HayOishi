package com.oishigroup
{
	import com.oishigroup.interactivemanager.MoveableInteractiveManager;
	import com.oishigroup.metadata.MetaData;
	
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.display.IsoWorld;
	
	public class IsoWorldObjectMoveAble extends IsoWorld
	{
		public function IsoWorldObjectMoveAble( _moveableInteractiveManager:MoveableInteractiveManager, _isDebug:Boolean=true)
		{
			var worldData:WorldData = new WorldData(10,10,128,MetaData.stageWidth,MetaData.stageHeight, 0 , 0 );
			super(worldData, _moveableInteractiveManager, _isDebug);
		}
	}
}