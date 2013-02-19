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
		//obj & position
		protected var positionController:PositionController;
		protected var isoObjects:Vector.<ObjectStatic> = new Vector.<ObjectStatic>();
		
		internal var touchDummy:Quad;
		internal var worldContainer:Sprite;
		
		protected var nowIndex:int = 0;
		
        // debug		
		internal var debugGrid:DebugGrid;
		protected var isDebug:Boolean;
		
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
			
			positionController = new PositionController(worldData);
			
			worldContainer.x = worldData.windowWidth*.5;
			worldContainer.y = worldData.windowHeight*.5;
			addEventListener(Event.REMOVED_FROM_STAGE , deactive );
		}
		
		public function deactive(e:Event):void
		{
			interactController.deactive();	
		}		
		
		public function updateWindowSize(_windowWidth:Number,_windowHeight:Number):void
		{
			touchDummy.width = _windowWidth;
			touchDummy.height = _windowHeight;
			interactController.updateWindow(_windowWidth,_windowHeight);
		}
		
		public function addObject(_objectStatic:ObjectStatic):Boolean
		{
			// make sure that object has enough room to add to its position in the world
			var canAdd:Boolean = positionController.canAdd(_objectStatic);
			if( canAdd ){
				worldContainer.addChild(_objectStatic.skin);
				_objectStatic.addWorld(this,nowIndex);
				positionController.addObject(_objectStatic,nowIndex);
				isoObjects.push(_objectStatic);
				debugGrid.addObject(_objectStatic,nowIndex);
				nowIndex++;
			}
			return canAdd;
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