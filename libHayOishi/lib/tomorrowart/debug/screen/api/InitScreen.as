package tomorrowart.debug.screen.api
{
	import com.oishigroup.api.BaseJSONAPI;
	import com.oishigroup.api.ConfigPath;
	import com.oishigroup.api.InitAPI;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import tomorrowart.debug.DebugView;
	import tomorrowart.debug.data.UserModel;
	
	public class InitScreen extends TemplateAPIScreen
	{
		public function InitScreen()
		{
			super();
		}
		
		private var _input:TextInput;
		private var _label:Label;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_header.title = "Init";
			
			_label = new Label();
			_label.text = "uid: ";
			this.addChild(_label);
			
			_input = new TextInput();
			_input.text = userData.uid;
			this.addChild(_input);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			_label.validate();
			_label.y = this._header.height + this._header.y;
			
			_input.validate();
			_input.x = 50;
			_input.y = this._header.height + this._header.y;
		}
		
		override protected function onCallAPI(e:Event):void
		{
			userData.uid = _input.text;
			
			var js:Object = new Object();
			js.uid = userData.uid;
			var api:BaseJSONAPI = new BaseJSONAPI(ConfigPath.INIT,js);
			api.load();
			api.signalComplete.add(onAPIComplete);
		}
	}
}