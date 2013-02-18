package
{
	import com.oishigroup.MainApp;
	import com.oishigroup.MainGameWeb;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class main extends MainApp
	{
		public function main()
		{
			stage.addEventListener(Event.RESIZE,resized);
			initApp(MainGameWeb);
		}
		
		protected function resized(event:Event):void
		{
			starlingMain.viewPort = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			starlingMain.stage.stageWidth = stage.stageWidth;
			starlingMain.stage.stageHeight = stage.stageHeight;
		}
	}
}