package EXIT.starlingiso.display
{
	import EXIT.starlingiso.data.CellData;
	import EXIT.starlingiso.data.WorldData;
	import EXIT.starlingiso.util.IsoHelper;
	
	import flash.geom.Point;
	
	import starling.display.Graphics;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	
	public class DebugGrid extends Sprite
	{
		private var graphics :Graphics;
		private var worldData:WorldData;
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
		
		
		public function addObject(_objectStatic:ObjectStatic, nowIndex:int):void
		{
			var shape:Shape = drawCell( _objectStatic);
			var p:Point = worldData.isoHelper.colRowToXY(_objectStatic.column,_objectStatic.row);
			shape.x = p.x;
			shape.y = p.y;
			addChild(shape);
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
		
		private function drawCell(_objectStatic:ObjectStatic):Shape
		{
			var rt:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(_objectStatic.numColumn,0);
			var rb:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(_objectStatic.numColumn,_objectStatic.numRow);
			var lb:Point = worldData.isoHelper.colRowToXYNoRelateToWorldCenter(0,_objectStatic.numRow);
			
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