package EXIT.starlingiso.data
{
	import EXIT.starlingiso.util.IsoHelper;
	
	import flash.geom.Rectangle;

	public class WorldData
	{
		public var numColumn:Number;
		public var numRow:Number;
		public var cellWidth:Number;
		
		public var windowWidth:Number;
		public var windowHeight:Number;
		
		public var worldWidth:Number;
		public var worldHeight:Number;
		public var zoom:Number = 1;
		
		public var isoHelper:IsoHelper;
		public function WorldData(_numColumn:Number,_numRow:Number,_cellWidth:Number , _windowWidth:Number , _windowHeight:Number , _worldWidth:Number , _worldHeight:Number)
		{
			numColumn = _numColumn;
			numRow = _numRow;
			cellWidth = _cellWidth;
			windowWidth = _windowWidth;
			windowHeight = _windowHeight;
			worldWidth = _worldWidth;
			worldHeight = _worldHeight
						
			isoHelper = new IsoHelper(numColumn , numRow , cellWidth);
			var bound:Rectangle = isoHelper.getBound();
			if( worldWidth == 0 ){
				worldWidth = bound.width;
			}
			if( worldHeight == 0 ){
				worldHeight = bound.height;
			}
		}
	}
}