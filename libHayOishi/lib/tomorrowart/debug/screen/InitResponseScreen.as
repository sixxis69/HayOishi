package tomorrowart.debug.screen
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollText;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import tomorrowart.debug.DebugView;
	import tomorrowart.debug.data.UserModel;
	
	public class InitResponseScreen extends Screen
	{
		public function InitResponseScreen()
		{
			super();
		}
		
		public var userData:UserModel;
		
		private var _header:Header;
		private var _backButton:Button;
		private var _txt:ScrollText;
		
		override protected function initialize():void
		{
			_header = new Header();
			_header.title = "Init Response";
			this.addChild(_header);
			
			_backButton = new Button();
			_backButton.label = "Back";
			_backButton.addEventListener(Event.TRIGGERED,onBackButton);
			
			_header.leftItems = new <DisplayObject>
				[
					_backButton
				];
			
			_txt = new ScrollText();
			this.addChild(_txt);
			_txt.text = userData.responseData;
			
			this.backButtonHandler = onBackButton;
		}
		
		override protected function draw():void
		{
			_header.y = DebugView.STAT_MARGIN;
			_header.width = this.actualWidth;
			_header.validate();
			
			_txt.width = this.actualWidth;
			_txt.y = _header.y + _header.height;
			_txt.height = this.actualHeight - _txt.y;
		}
		
		private function onBackButton(e:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
	}
}