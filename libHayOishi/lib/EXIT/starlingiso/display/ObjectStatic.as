package EXIT.starlingiso.display
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	public class ObjectStatic extends EventDispatcher
	{
		protected var _skin:DisplayObject;
		protected var _numColumn:uint;
		protected var _numRow:uint;
		protected var _world:IsoWorld;
		protected var _index:int = -1;
		protected var _column:uint = 0;
		protected var _row:uint = 0;
		
		private var invalidate:Boolean = true;
		
		public function ObjectStatic(_skin:DisplayObject, _numColumn:uint , _numRow:uint )
		{
			super();
			this._skin = _skin;
			this._numColumn = _numColumn;
			this._numRow = _numRow;
			this._skin.touchable = false;
		}
		
		public function setColumnRow(_column:uint,_row:uint):void
		{
			this._column = _column;
			this._row = _row;
			invalidate = true;
			updateSkinPosition();
		}
		
		internal function addWorld(_world:IsoWorld,_index:int):void
		{
			this._world = _world;
			this._index = _index;
			invalidate = true;
			updateSkinPosition();
		}
		
		internal function removeWorld():void
		{
			_world = null;
			_index = -1;
		}
		
		
		
		/**
		 * Private
		 */		
		
		protected function updateSkinPosition():void
		{
			if( invalidate&&_world ){
				var position:Point = _world.worldData.isoHelper.colRowToXY(_column,_row);
				_skin.x = position.x;
				_skin.y = position.y;
				invalidate=false;
			}
		}
		
		
		/**
		 * GET 
		 */		
		
		public function get world():IsoWorld { return _world; }
		public function get numRow():uint { return _numRow; }
		public function get numColumn():uint { return _numColumn; }
		public function get row():int { return _row; }
		public function get column():int { return _column; }
		public function get skin():DisplayObject { return _skin; }
		internal function get index():int { return _index; }
	}
}