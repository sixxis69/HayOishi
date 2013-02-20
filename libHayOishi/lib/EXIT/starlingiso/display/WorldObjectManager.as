package EXIT.starlingiso.display
{
	import EXIT.starlingiso.data.WorldData;
	
	import starling.display.Sprite;
	

	final internal class WorldObjectManager
	{
		private var world:IsoWorld;
		private var worldData:WorldData;
		private var objectContainer:Sprite;
		
		private var hasObjectGrid:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		protected var isoObjects:Vector.<ObjectStatic> = new Vector.<ObjectStatic>();
		public function WorldObjectManager(_world:IsoWorld)
		{
			world = _world;
			this.worldData = _world.worldData;
			this.objectContainer = _world.objectContainer;
			
			//init grid
			for(var i:uint=0 ; i<=worldData.numColumn-1 ; i++){
				hasObjectGrid[i] = new Vector.<int>();
				for(var j:uint=0 ; j<=worldData.numRow-1 ; j++){
					hasObjectGrid[i][j]=-1;// -1 means no object at this cell
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
		 * <p>Before world call addObject must check by call canAdd() function first</p>
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
			
			objectContainer.addChild(_objectStatic.skin);
			_objectStatic.addWorld(world,_objectIndex);
			isoObjects.push(_objectStatic);
			
			trace("++++++++++++++++++++++++[PositionController] addObject:++++++++++++++++++++++");
			trace(" :::::: ",isoObjects,"::: ");
			for(i=0 ; i<=hasObjectGrid.length-1 ; i++){
				trace(i," : ",hasObjectGrid[ i ]);
			}
		}
		
		internal function removeObject(_objectStatic:ObjectStatic):void
		{
			// set index of object to mark position that object use
			var i:uint;
			for(i=0 ; i<=_objectStatic.numColumn-1 ; i++){
				for(var j:uint=0 ; j<=_objectStatic.numRow-1 ; j++){
					hasObjectGrid[ _objectStatic.column+i ][ _objectStatic.row+j ] = -1;
				}
			}
			
			objectContainer.removeChild(_objectStatic.skin);
			_objectStatic.removeWorld();
			for( i=0 ; i<=isoObjects.length-1 ; i++ ){
				if( isoObjects[i] == _objectStatic ){
					isoObjects.splice(i,1);
				}
			}
			
			trace("+++++++++++++++++++++++++[PositionController] removeObject:++++++++++++++++++++++");
			trace(" :::::: ",isoObjects,"::: ");
			for(i=0 ; i<=hasObjectGrid.length-1 ; i++){
				trace(i," : ",hasObjectGrid[ i ]);
			}
		}
		
		private function sortDepthObject(_objectStatic:ObjectStatic):void
		{
			
		}
	}
}