package EXIT.starlingiso.display
{
	import EXIT.starlingiso.data.WorldData;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class IsoWorld extends Sprite
	{
		//                        +
		//                    +       +
		//                 +  c=0, r=0   +
		//              +     +       +    +
		//            +  c=0,r=1  + c=1,r=0  +
		//              +     +      +     +
		//                 +            +
		
		internal var worldData:WorldData; 
		//interactive
		protected var interactController:BaseInteractController;
		
		internal var touchDummy:Quad;
		internal var worldContainer:Sprite;
		
        // debug		
		private var debugGrid:DebugGrid;
		private var isDebug:Boolean;
		
		public function IsoWorld(
			_worldData:WorldData , 
			_interactController:BaseInteractController ,
			_isDebug:Boolean=true)
		{
			super();
			worldData = _worldData;
			interactController = _interactController;
			isDebug = _isDebug;
			
			initialize();
			if(isDebug)
				initDebug();
		}
		
		protected function initialize():void
		{
			worldContainer = new Sprite();
			worldContainer.touchable=false;
			addChild(worldContainer);
			touchDummy = new Quad(worldData.windowWidth,worldData.windowHeight,0xaa5555);
			touchDummy.alpha=.5;
			addChild(touchDummy);
			
			interactController.initialize(this);
			interactController.active();
			
			worldContainer.x = worldData.windowWidth*.5;
			worldContainer.y = worldData.windowHeight*.5;
			addEventListener(Event.REMOVED_FROM_STAGE , deactive );
		}
		
		//public function addBackground(_background:DisplayObject):void
		
		
		public function deactive(e:Event):void
		{
			interactController.deactive();	
		}		
		 
		/**
		 * DEBUG 
		 */		
		
		protected function initDebug():void
		{
			debugGrid = new DebugGrid(worldData);
			debugGrid.touchable=false;
			worldContainer.addChild(debugGrid);
		}
	}
}