package EXIT.starlingiso.display
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	public class IsoObject extends EventDispatcher
	{
		protected var _skin:DisplayObject;
		private var _numColumn:uint;
		private var _numRow:uint;
		protected var _world:IsoWorld;
		private var _index:int = -1;
		private var _column:int = 0;
		private var _row:int = 0;
		private var _centerXY:Point = new Point();
		private var _depth:int;
		
		private var invalidate:Boolean = true;
		
		public function IsoObject(_skin:DisplayObject, _numColumn:uint , _numRow:uint )
		{
			super();
			this._skin = _skin;
			this._numColumn = _numColumn;
			this._numRow = _numRow;
		}
		
		public function setColumnRow(_column:int,_row:int):void
		{
			trace("setColumnRow:",_column,_row);
			this._column = _column;
			this._row = _row;
			_depth = _column+_row;
			invalidate = true;
			updateSkinPosition(false);
		}
		
		public function updateSkinPosition(_forceUpdate:Boolean=true):void
		{
			if( (invalidate&&_world)||_forceUpdate ){
				trace("updateSkinPos:",_column,_row);
				var position:Point = _world.worldData.isoHelper.colRowToXY(_column,_row);
				_skin.x = position.x;
				_skin.y = position.y;
				invalidate=false;
				
				_centerXY = world.worldData.isoHelper.colRowToXY(_column+numColumn*.5,_row+numRow*.5);
			}
		}
		
		internal function addWorld(_world:IsoWorld,_index:int):void
		{
			trace(" ::: addWorld",_column,_row);
			this._world = _world;
			this._index = _index;
			invalidate = true;
			updateSkinPosition(false);
		}
		
		internal function removeWorld():void
		{
			_world = null;
			_index = -1;
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
		public function get index():int { return _index; }
		
		public function get centerXY():Point { return _centerXY; }
		public function get depth():int { return _depth; }
		
		public function toString():String
		{
			return "[ "+_column+","+_row+" ]";
		}
	}
}