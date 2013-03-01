package tomorrowart.debug.screen
{
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
	
	public class InitScreen extends Screen
	{
		public function InitScreen()
		{
			super();
		}
		
		public var userData:UserModel;
		
		private var _header:Header;
		private var _backButton:Button;
		private var _submitButton:Button;
		private var _input:TextInput;
		private var _label:Label;
		
		override protected function initialize():void
		{
			_backButton = new Button();
			_backButton.label = "Back";
			_backButton.addEventListener(Event.TRIGGERED, onBackButton);
			
			_submitButton = new Button();
			_submitButton.label = 'Call';
			_submitButton.addEventListener(Event.TRIGGERED,onCallAPI);
			
			_header = new Header();
			_header.title = "Init";
			this.addChild(_header);
			
			_header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			_header.rightItems = new <DisplayObject>
				[
					this._submitButton
				];
			
			_label = new Label();
			_label.text = "uid: ";
			this.addChild(_label);
			
			_input = new TextInput();
			_input.text = userData.uid;
			this.addChild(_input);
		}
		
		override protected function draw():void
		{
			_header.y = DebugView.STAT_MARGIN;
			_header.width = this.actualWidth;
			_header.validate();
			
			_label.validate();
			_label.y = this._header.height + this._header.y;
			
			_input.validate();
			_input.x = 50;
			_input.y = this._header.height + this._header.y;
		}
		
		private function onBackButton(e:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		private function onCallAPI(e:Event):void
		{
			userData.uid = _input.text;
			
			var js:Object = new Object();
			js.uid = userData.uid;
			var api:InitAPI = new InitAPI(js);
			api.load();
			api.signalComplete.add(onComplete);
		}
		
		private function onComplete(value:Object):void
		{
			//	var tf:TextField = new TextField(300,300,'');
			//	tf.text = JSON.stringify(value);
			//	this.addChild(tf);
			userData.responseData = JSON.stringify(value);
			this.dispatchEventWith(MainMenuScreen.SHOW_INIT_RESULT);
		}
	}
}

//private function initView(e:Event):void
//{
//	var bmd:BitmapData = new BitmapData(100,100,false,0xff0000);
//	initBt = new Button(Texture.fromBitmapData(bmd),'init');
//	initBt.addEventListener(Event.TRIGGERED,onTrig);
//	this.addChild(initBt);
//	initBt.x = 100;
//}
//
//private function onTrig(e:Event):void
//{
//	var js:Object = new Object();
//	
//	js.uid = '123';
//	
//	var msg:String = JSON.stringify(js);
//	
//	var vars:URLVariables = new URLVariables();
//	vars.msg = msg;
//	
//	var req:URLRequest = new URLRequest();
//	//			req.url = ConfigPath.INIT;
//	//			req.data = vars;
//	//			
//	//			var api:InitAPI = new InitAPI(ConfigPath.SAVE_FARM_NAME,vars);
//	//			api.load();
//	//			api.signalComplete.add(onComplete);
//}
//
//private function onComplete(value:Object):void
//{
//	trace('onComplete: ' + value.data);
//	
//	var tf:TextField = new TextField(300,300,'');
//	tf.text = JSON.stringify(value);
//	this.addChild(tf);
//}