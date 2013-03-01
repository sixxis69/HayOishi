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
	
	public class MainMenuScreen extends Screen
	{
		public static const SHOW_RESULT:String					= "showResult";
		public static const SHOW_MENU:String					= "showMenu";
		public static const SHOW_INIT:String					= "showInit";
		public static const SHOW_GET_FRIENDS:String 			= "showGetFriends";
		public static const SHOW_SAVE_FARM_NAME:String			= "showSaveFarmName";
		public static const SHOW_UPDATE_FIELD:String			= "showUpdateField";
		
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
					{label:"init.php", event:SHOW_INIT},
					{label:"getFriends.php", event:SHOW_GET_FRIENDS},
					{label:"saveFarmName.php", event:SHOW_SAVE_FARM_NAME},
					{label:"updateFields.php", event:SHOW_UPDATE_FIELD}
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