package EXIT.starlingiso.data
{
	public class CellData
	{
		public var col:uint;
		public var row:uint;
		public function CellData(_col:uint,_row:uint)
		{
			col = _col;
			row = _row;
		}
		
		public function clone():CellData
		{
			return new CellData(col,row);
		}
	}
}