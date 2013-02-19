package EXIT.starlingiso.display
{
	import EXIT.starlingiso.data.WorldData;

	public class PositionController
	{
		private var hasObjectGrid:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		private var _worldData:WorldData;
		public function PositionController(_worldData:WorldData)
		{
			this._worldData = _worldData;
			for(var i:uint=0 ; i<=_worldData.numColumn-1 ; i++){
				hasObjectGrid[i] = new Vector.<int>();
				for(var j:uint=0 ; j<=_worldData.numRow-1 ; j++){
					hasObjectGrid[i][j]=-1;
				}
			}
		}
		
		internal function canAdd(_objectStatic:ObjectStatic):Boolean
		{
			//if hasObjectGrid at that position is -1 , mean can't addObject here , so return false;
			var i:uint;
			var j:uint;
			for(i=0 ; i<=_objectStatic.numColumn-1 ; i++){
				for(j=0 ; j<=_objectStatic.numRow-1 ; j++){
					if( hasObjectGrid[ _objectStatic.column+i ][ _objectStatic.row+j ] >= 0 ){
						trace("[PositionController] can't add object to the world");
						return false;
					}
				}
			}
			return true;
		}
		
		/**
		 * Before world call addObject must check by call canAdd() function first
		 * @param _objectStatic
		 * 
		 * @return 
		 * 
		 */		
		internal function addObject(_objectStatic:ObjectStatic,_objectIndex:int):void
		{
			// set index of object to mark position that object use
			for(var i:uint=0 ; i<=_objectStatic.numColumn-1 ; i++){
				for(var j:uint=0 ; j<=_objectStatic.numRow-1 ; j++){
					hasObjectGrid[ _objectStatic.column+i ][ _objectStatic.row+j ] = _objectIndex;
				}
			}
			trace("+++++++++++++++++++++++++++hasObjectGrid:++++++++++++++++++++++");
			for(i=0 ; i<=hasObjectGrid.length-1 ; i++){
				trace(i," : ",hasObjectGrid[ i ]);
			}
		}
	}
}