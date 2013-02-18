package com.oishigroup
{
	import com.oishigroup.metadata.AppDelegate;
	import com.oishigroup.metadata.MetaData;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import net.area80.debug.FPS;
	
	import starling.core.Starling;
	
	/**
	 * 
	 * @author EXIT
	 * 
	 * extends me to be the main of project
	 * 
	 */	
	public class MainApp extends Sprite
	{

		private var starlingMain:Starling;
		public function MainApp()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate=60;
			MetaData.flashStage = stage;
		}
		
		
		protected function initDelegate(_appDelegateClass:Class):void
		{
			if( !_appDelegateClass is AppDelegate ){
				throw new Error("Main must init with AppDelegate Class");
			}
			
			if( MetaData.isDebug )
				addChild( new FPS() );
			setTimeout(startApp,100);
		}
		
		private function startApp():void
		{
			MetaData.stageWidth = stage.stageWidth;
			MetaData.stageHeight = stage.stageHeight;
			starlingMain = new Starling(MainGame,stage, new Rectangle(0,0,stage.stageWidth,stage.stageHeight));
			starlingMain.start();
			starlingMain.simulateMultitouch = MetaData.isDebug;
			starlingMain.antiAliasing = 0;
		}
	}
}