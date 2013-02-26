package EXIT.starlingiso.display
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import EXIT.starlingiso.data.CellData;
	import EXIT.starlingiso.data.WorldData;
	
	import starling.display.Graphics;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	internal class DebugGrid extends Sprite
	{
		private var graphics :Graphics;
		private var worldData:WorldData;
		private var dictGround:Dictionary = new Dictionary();
		
		public function DebugGrid(_worldData:WorldData)
		{
			super();
			graphics = new Graphics(this);
			worldData =_worldData;
			
			graphics.lineStyle(1);
			for( var i:uint=0 ; i<=worldData.numColumn ; i++ ){
				drawLine( new CellData(i,0) ,new CellData(i,worldData.numRow) );
			}
			for( var j:uint=0 ; j<=worldData.numRow ; j++ ){
				drawLine( new CellData(0,j) ,new CellData(worldData.numColumn,j) );
			}
			
			//grid
			graphics.lineStyle(1,0xFF0000);
			graphics.moveTo( -worldData.worldWidth*.5 , -worldData.worldHeight*.5);
			graphics.lineTo( worldData.worldWidth*.5 , -worldData.worldHeight*.5);
			graphics.lineTo( worldData.worldWidth*.5 , worldData.worldHeight*.5);
			graphics.lineTo( -worldData.worldWidth*.5 , worldData.worldHeight*.5);
			graphics.lineTo( -worldData.worldWidth*.5 , -worldData.worldHeight*.5);
			
			//center
			graphics.beginFill(0xFF0000,.5);
			graphics.drawCircle(0,0,4);
			graphics.endFill();
		}
		
		
		internal function addObject(_isoObject:IsoObject, nowIndex:int):void
		{
			var shape:Shape = drawCell( _isoObject);
			var p:Point = worldData.isoHelper.colRowToXY(_isoObject.column,_isoObject.row);
			shape.x = p.x;
			shape.y = p.y;
			addChild(shape);
			dictGround[_isoObject] = shape;
		}
		
		internal function removeObject(_isoObject:IsoObject):void
		{
			removeChild(dictGround[_isoObject]);
			delete dictGround[_isoObject];
		}
		
		internal function moveObject(_isoObject:IsoObject):void
		{
			if( !dictGround[_isoObject] ){
				addObject(_isoObject,_isoObject.index);
			}
			var p:Point = worldData.isoHelper.colRowToXY(_isoObject.column,_isoObject.row);
			if( dictGround[_isoObject] ){
				dictGround[_isoObject].x = p.x;
				dictGround[_isoObject].y = p.y;
			}
		}
		
		
		/**
		 * Draw Util
		 */		
		
		private function drawLine(fromCell:CellData,toCell:CellData):void
		{
			var fromPoint:Point = worldData.isoHelper.colRowToXY(fromCell.col,fromCell.row);
			var toPoint:Point = worldData.isoHelper.colRowToXY(toCell.col,toCell.row);
			graphics.moveTo( fromPoint.x , fromPoint.y );
			graphics.lineTo( toPoint.x , toPoint.y );
		}
		
		private function drawCell(_isoObject:IsoObject):Shape
		{
			var rt:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(_isoObject.numColumn,0);
			var rb:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(_isoObject.numColumn,_isoObject.numRow);
			var lb:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(0,_isoObject.numRow);
			
			var sp:Shape = new Shape();
			sp.graphics.beginFill(0x118888);
			sp.graphics.moveTo(0,0);
			sp.graphics.lineTo(rt.x,rt.y);
			sp.graphics.lineTo(rb.x,rb.y);
			sp.graphics.lineTo(lb.x,lb.y);
			sp.graphics.lineTo(0,0);
			sp.graphics.endFill();
			sp.alpha=.5;
			
			return sp;
		}
	}
}