package com.oishigroup.model
{
	import EXIT.starlingiso.display.IsoObject;
	
	import org.osflash.signals.Signal;

	public class InteractiveModel
	{
		public static const BUILDING_TEST:String = "test";
		
		private static var canInit:Boolean=false;
		private static var _instance:InteractiveModel;
		
		public var signalBuildingReadyToBuild:Signal = new Signal(String);
		public var signalSelectObject:Signal = new Signal(IsoObject);
		public var signalCancelObject:Signal = new Signal();
		public var signalStartMoveObject:Signal = new Signal();
		
		public function InteractiveModel()
		{
			if(!canInit){
				throw new Error("Use get instance instead!!!");		
			}
		}
		
		public static function get instance():InteractiveModel
		{
			if( !_instance ){
				canInit=true;
				_instance = new InteractiveModel();	
				canInit=false;
			}
			return _instance;
		}
	}
}