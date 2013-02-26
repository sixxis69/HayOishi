package EXIT.starlingiso.util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import EXIT.starlingiso.data.CellData;

	public class IsoHelper
	{
		private var numColumn:Number;
		private var numRow:Number;
		private var cellWidth:Number;
		private var colRow00:Point;
		public function IsoHelper(_numColumn:Number,_numRow:Number,_cellWidth:Number)
		{
			numColumn = _numColumn;
			numRow = _numRow;
			cellWidth = _cellWidth;
			
			colRow00 = new Point(
				(-numColumn+numRow)*cellWidth*.25 // add x from -col+row
				,
				(-numColumn-numRow)*cellWidth*.125 // add y from -col-row
			);
		}	
		
		public function getBound():Rectangle
		{
			var halfWidth:Number = colRow00.x+numColumn*cellWidth*.5;
			return new Rectangle(
				-halfWidth,
				colRow00.y,
				halfWidth*2,
				-colRow00.y*2
				);
		}
		
		public function xyToRowCol(_x:Number,_y:Number):CellData
		{
			return new CellData(
				( (_x-colRow00.x     + 2*(_y-colRow00.y) )/cellWidth )>>0,
				( (2*(_y-colRow00.y) - (_x-colRow00.x)   )/cellWidth )>>0);
		}
		
		public function colRowToXY(_col:Number,_row:Number):Point
		{
			return new Point(
				colRow00.x
				+(_col-_row)*cellWidth*.5
				,
				colRow00.y
				+(_col+_row)*cellWidth*.25
			);
		}
		
		
		public function colRowToXYNoRelateToWorldCenter(_col:Number,_row:Number):Point
		{
			return new Point(
				(_col-_row)*cellWidth*.5
				,
				(_col+_row)*cellWidth*.25
			);
		}
	}
}