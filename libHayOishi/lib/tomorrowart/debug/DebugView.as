package tomorrowart.debug
{
	import com.oishigroup.api.ConfigPath;
	import com.oishigroup.api.InitAPI;
	
	import flash.display.BitmapData;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	
	
	public class DebugView extends Sprite
	{
		private var initBt:Button;
		
		public function DebugView()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,initView);
		}
		
		private function initView(e:Event):void
		{
			var bmd:BitmapData = new BitmapData(100,100,false,0xff0000);
			initBt = new Button(Texture.fromBitmapData(bmd),'init');
			initBt.addEventListener(Event.TRIGGERED,onTrig);
			this.addChild(initBt);
			initBt.x = 100;
		}
		
		private function onTrig(e:Event):void
		{
			var js:Object = new Object();
			
			js.uid = '123';
			
			var msg:String = JSON.stringify(js);
			
			var vars:URLVariables = new URLVariables();
			vars.msg = msg;
			
			var req:URLRequest = new URLRequest();
//			req.url = ConfigPath.INIT;
//			req.data = vars;
//			
//			var api:InitAPI = new InitAPI(ConfigPath.SAVE_FARM_NAME,vars);
//			api.load();
//			api.signalComplete.add(onComplete);
		}
		
		private function onComplete(value:Object):void
		{
			trace('onComplete: ' + value.data);
			
			var tf:TextField = new TextField(300,300,'');
			tf.text = JSON.stringify(value);
			this.addChild(tf);
		}
	}
}