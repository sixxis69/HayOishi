package tomorrowart.debug.screen.api
{
	import com.oishigroup.api.BaseJSONAPI;
	import com.oishigroup.api.ConfigPath;
	
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	
	import starling.events.Event;

	public class SaveFarmNameScreen extends TemplateAPIScreen
	{
		public function SaveFarmNameScreen()
		{
			super();
		}
		
		private var _inputUID:TextInput;
		private var _labelUID:Label;
		
		private var _inputFarmName:TextInput;
		private var _labelFarmName:Label;
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			_header.title = "SaveFarmName";
			
			_labelUID = new Label();
			_labelUID.text = "uid: ";
			this.addChild(_labelUID);
			
			_inputUID = new TextInput();
			_inputUID.text = userData.uid;
			this.addChild(_inputUID);
			
			_labelFarmName = new Label();
			_labelFarmName.text = "farm_name: ";
			this.addChild(_labelFarmName);
			
			_inputFarmName = new TextInput();
			_inputFarmName.text = userData.farm_name;
			this.addChild(_inputFarmName);
		}
		
		override protected function draw():void
		{
			super.draw();
			
			_labelUID.validate();
			_labelUID.y = this._header.height + this._header.y;
			
			_inputUID.validate();
			_inputUID.x = 100;
			_inputUID.y = this._header.height + this._header.y;
			
			_labelFarmName.validate();
			_labelFarmName.y = _labelUID.y + _labelFarmName.height;
			
			_inputFarmName.validate();
			_inputFarmName.x = 100;
			_inputFarmName.y = _labelUID.y + _labelFarmName.height;
		}
		
		override protected function onCallAPI(e:Event):void
		{
			userData.uid = _inputUID.text;
			userData.farm_name = _inputFarmName.text;
			
			var js:Object = new Object();
			js.uid = userData.uid;
			js.farm_name = userData.farm_name;
			var api:BaseJSONAPI = new BaseJSONAPI(ConfigPath.SAVE_FARM_NAME,js);
			api.load();
			api.signalComplete.add(onAPIComplete);
		}
	}
}