package
{
	import com.oishigroup.MainApp;
	import com.oishigroup.MainGameWeb;
	import com.oishigroup.metadata.MetaData;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import tomorrowart.debug.DebugView;
	
	public class HayOishi_Web extends MainApp
	{
		public function HayOishi_Web()
		{
			stage.addEventListener(Event.RESIZE,resized);
			MetaData.isDebug = true;
//			initApp(MainGameWeb);
			
			initApp(DebugView);
		}
		
		protected function resized(event:Event):void
		{
			starlingMain.viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			starlingMain.stage.stageWidth = stage.stageWidth;
			starlingMain.stage.stageHeight = stage.stageHeight;
		}
	}
}