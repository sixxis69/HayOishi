package tomorrowart.debug.screen.api
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import tomorrowart.debug.DebugView;
	import tomorrowart.debug.data.UserModel;
	import tomorrowart.debug.screen.MainMenuScreen;
	
	public class TemplateAPIScreen extends Screen
	{
		public function TemplateAPIScreen()
		{
			super();
		}
		
		public var userData:UserModel;
		
		protected var _header:Header;
		protected var _backButton:Button;
		protected var _submitButton:Button;
		
		override protected function initialize():void
		{
			_backButton = new Button();
			_backButton.label = "Back";
			_backButton.addEventListener(Event.TRIGGERED, onBackButton);
			
			_submitButton = new Button();
			_submitButton.label = 'Call';
			_submitButton.addEventListener(Event.TRIGGERED,onCallAPI);
			
			_header = new Header();
			this.addChild(_header);
			
			_header.leftItems = new <DisplayObject>
				[
					this._backButton
				];
			_header.rightItems = new <DisplayObject>
				[
					this._submitButton
				];
			
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function draw():void
		{
			_header.y = DebugView.STAT_MARGIN;
			_header.width = this.actualWidth;
			_header.validate();
		}
		
		protected function onBackButton(e:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		protected function onCallAPI(e:Event):void
		{
			
		}
		
		protected function onAPIComplete(value:Object):void
		{
			userData.responseData = JSON.stringify(value);
			
			this.dispatchEventWith(MainMenuScreen.SHOW_RESULT);
		}
	}
}