package EXIT.starlingiso.display
{
	import flash.geom.Point;
	
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
		
		public var worldData:WorldData; 
		public var objectManager:WorldObjectManager;
		
		internal var touchDummy:Quad;
		internal var objectContainer:Sprite;
		
		//interactive
		protected var interactManager:BaseInteractiveManager;
		//obj & position
		protected var nowIndex:int = 0;
		
        // debug		
		internal var debugGrid:DebugGrid;
		protected var isDebug:Boolean;
		
		public function IsoWorld(
			_worldData:WorldData , 
			_interactManger:BaseInteractiveManager ,
			_isDebug:Boolean=true)
		{
			super();
			worldData = _worldData;
			interactManager = _interactManger;
			isDebug = _isDebug;
			
			initialize();
			if(isDebug)
				initDebug();
		}
		
		protected function initialize():void
		{
			objectContainer = new Sprite();
			objectContainer.touchable=false;
			addChild(objectContainer);
			touchDummy = new Quad(worldData.windowWidth,worldData.windowHeight,0xaa5555);
			touchDummy.alpha=.5;
			addChild(touchDummy);
			
			interactManager.initialize(this);
			interactManager.active();
			
			objectManager = new WorldObjectManager(this);
			
			objectContainer.x = worldData.windowWidth*.5;
			objectContainer.y = worldData.windowHeight*.5;
			addEventListener(Event.REMOVED_FROM_STAGE , deactive );
		}
		
		public function deactive(e:Event=null):void
		{
			interactManager.deactive();	
		}		
		
		public function updateWindowSize(_windowWidth:Number,_windowHeight:Number):void
		{
			touchDummy.width = _windowWidth;
			touchDummy.height = _windowHeight;
			interactManager.updateWindow(_windowWidth,_windowHeight);
		}
		
		/**
		 *<p>If the world not have enough room to add object ,the object is still added to world but not register its position to the world</p> 
		 * @param _isoObject
		 * @return 
		 * 
		 */		
		public function addIsoObject(_isoObject:IsoObject):Boolean
		{
			trace(" world addIsoObject : ",_isoObject.column,_isoObject.row );
			// make sure that object has enough room to add to the world
			var canAdd:Boolean = objectManager.addObject(_isoObject,nowIndex);
			if( isDebug && canAdd)
				debugGrid.addObject(_isoObject,nowIndex);
			nowIndex++;
			return canAdd;
		}
		
		public function removeIsoObject(_isoObject:IsoObject):void
		{
			objectManager.removeObject(_isoObject);
			if( isDebug )
				debugGrid.removeObject(_isoObject);
		}
		
		/*public function moveIsoObject(_isoObject:IsoObject,_toCell:CellData):Boolean
		{
			// make sure that object has enough room to move
			var canMove:Boolean = objectManager.moveObject(_isoObject,_toCell);
			if( isDebug && canMove)
				debugGrid.moveObject(_isoObject);
			return canMove;
		}*/
		
		public function getCenterPointObject(_isoObject:IsoObject):Point
		{
			return new Point(
				objectContainer.x+_isoObject.centerXY.x*objectContainer.scaleX,
				objectContainer.y+_isoObject.centerXY.y*objectContainer.scaleY
			);
			
		}
		
		public function getIsoObjectAt(_col:uint, _row:uint):IsoObject
		{
			return objectManager.getIsoObjectAt(_col,_row);
		}
		
		public function hasEnoughRoom(_column:int,_row:int,_numColumn:uint,_numRow:uint):Boolean
		{
			return objectManager.hasEnoughRoom(_column,_row,_numColumn,_numRow);
		}
		
		
		/**
		 *for add object skin  but not regis to the world 
		 * @param _isoObject
		 * 
		 */		
		public function addDummyObject(_isoObject:IsoObject):void
		{
			objectContainer.addChild(_isoObject.skin);
			_isoObject.addWorld(this,-1);
		}
		
		public function removeDummyObject(_isoObject:IsoObject):void
		{
			objectContainer.removeChild(_isoObject.skin);
		}
		
		/**
		 * DEBUG 
		 */		
		
		protected function initDebug():void
		{
			debugGrid = new DebugGrid(worldData);
			debugGrid.touchable=false;
			objectContainer.addChild(debugGrid);
		}
	}
}