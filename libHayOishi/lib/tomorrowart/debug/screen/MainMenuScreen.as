package tomorrowart.debug.screen
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	import tomorrowart.debug.DebugView;
	
	[Event(name="showInit",type="starling.events.Event")]
	
	public class MainMenuScreen extends Screen
	{
		public static const SHOW_MENU:String		= "showMenu";
		public static const SHOW_INIT:String		= "showInit";
		public static const SHOW_INIT_RESULT:String	= "showInitResult";
		
		public function MainMenuScreen()
		{
			super();
		}
		
		private var _header:Header;
		private var _list:List;
		
		override protected function initialize():void
		{
			_header = new Header();
			_header.title = "API vers: 1.00";
			addChild(_header);
			
			_list = new List();
	
			_list.dataProvider = new ListCollection(
				[
					{label:"init.php", event:SHOW_INIT}
				]);
			
			_list.itemRendererProperties.labelField = "label";
			_list.itemRendererProperties.accessorySourceFunction = accessorySourceFunction;
			_list.addEventListener(Event.CHANGE, onChange);
			addChild(_list);
		}
		
		override protected function draw():void
		{
			_header.y = DebugView.STAT_MARGIN;
			_header.width = this.actualWidth;
			_header.validate();
			
			_list.y = _header.height + _header.y;
			_list.width = this.actualWidth;
			_list.height = this.actualHeight - this._list.y;
		}
		
		private function accessorySourceFunction(item:Object):Texture
		{
			return StandardIcons.listDrillDownAccessoryTexture;
		}
		
		private function onChange(e:Event):void
		{
			const eventType:String = _list.selectedItem.event as String;
			
			this.dispatchEventWith(eventType);
		}
	}
}