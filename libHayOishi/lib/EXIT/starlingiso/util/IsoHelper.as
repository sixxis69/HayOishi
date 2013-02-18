package EXIT.starlingiso.util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

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
				-numColumn*.5*cellWidth*.5 // add x from colum
				+numRow*.5*cellWidth*.5 // add x from row
				,
				-numColumn*.5*cellWidth*.5*.5 // add y from colum
				-numRow*.5*cellWidth*.5*.5 // add y from row
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
		
		
		
		public function colRowToXY(_col:Number,_row:Number):Point
		{
			return new Point(
				colRow00.x
				+_col*cellWidth*.5 // add x from colum
				-_row*cellWidth*.5 // add x from row
				,
				colRow00.y
				+_col*cellWidth*.5*.5 // add y from colum
				+_row*cellWidth*.5*.5 // add y from row
			);
		}
	}
}