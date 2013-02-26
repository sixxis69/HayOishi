package com.oishigroup.building
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	
	public class MoveableIsoObject extends SelectableIsoObject
	{
		private var _lastColumn:int = -1;
		private var _lastRow:int = -1;
		private var canMove:Boolean = false;
		private var _isBuilt:Boolean = false;
		
		public function MoveableIsoObject(_skin:DisplayObject, _numColumn:uint, _numRow:uint)
		{
			super(_skin, _numColumn, _numRow);
		}
		
		override public function setColumnRow(_column:int, _row:int):void
		{
			trace("setColumnRow:",_column,_row,"lastColRow:",_lastColumn,_lastRow," now:",column,row);
			if( column!=_column || row!=_row){
				_lastColumn = column;
				_lastRow = row;
				trace("set____");
				super.setColumnRow(_column, _row);
			}
		}
		
		public function moveSkin(_column:int,_row:int):void
		{
			var position:Point = _world.worldData.isoHelper.colRowToXY(_column,_row);
			_skin.x = position.x;
			_skin.y = position.y;
		}
		
		public function build():void
		{
			_isBuilt = true;
		}
		
		public function get isBuilt():Boolean{return _isBuilt;}
	}
}