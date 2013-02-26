package com.oishigroup
{
	import com.oishigroup.interactivemanager.MouseInteractManager;
	
	import com.oishigroup.metadata.MetaData;
	
	import flash.events.Event;

	public class MainGameWeb extends MainGame
	{
		public function MainGameWeb()
		{
			super(new MouseInteractManager());
			MetaData.flashStage.addEventListener(Event.RESIZE,resized);
		}
		
		protected function resized(event:Event):void
		{
			if( mainIsoWorld){
				mainIsoWorld.updateWindowSize(MetaData.flashStage.stageWidth,MetaData.flashStage.stageHeight);
			}
		}
	}
}