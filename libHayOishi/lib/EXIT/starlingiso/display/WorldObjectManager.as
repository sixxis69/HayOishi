package EXIT.starlingiso.display
{
	import flash.utils.Dictionary;
	
	import EXIT.starlingiso.data.CellData;
	import EXIT.starlingiso.data.WorldData;
	
	import starling.display.Sprite;
	

	final internal class WorldObjectManager
	{
		private var world:IsoWorld;
		private var worldData:WorldData;
		private var objectContainer:Sprite;
		
		private var hasObjectGrid:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		protected var isoObjects:Vector.<IsoObject> = new Vector.<IsoObject>();
		private var dictIsoObjectIndex:Dictionary = new Dictionary();
		
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
		
		internal function getIsoObjectAt(_column:int , _row:int):IsoObject
		{
			var _index:int = -1;
			if( _column<0 ||_row<0 || _column>worldData.numColumn-1  || _row>worldData.numRow-1 ){
				return null;
			}
			_index = hasObjectGrid[_column][_row];
			return dictIsoObjectIndex[_index];
		}
		
		
		/*********************************************************************
		 * 
		 * Object view Manage
		 * 
		 **********************************************************************/	
		
		/**
		 * <p>Before world call addObject must check by call canAdd() function first</p>
		 * @param _isoObject
		 * 
		 * @return 
		 * 
		 */		
		internal function addObject(_isoObject:IsoObject,_objectIndex:int):Boolean
		{
			var _canAdd:Boolean = addIndex(_isoObject.column,_isoObject.row,_isoObject.numColumn,_isoObject.numRow,_objectIndex);
			if( _canAdd ){
				objectContainer.addChild(_isoObject.skin);
				_isoObject.addWorld(world,_objectIndex);
				isoObjects.push(_isoObject);
				dictIsoObjectIndex[_objectIndex] = _isoObject;
				sortDepthObjectAt(isoObjects.length-1);
			}
			/*trace("++++++++++++++++++++++++[PositionController] addObject:++++++++++++++++++++++");
			trace(" :::::: ",isoObjects,"::: ");
			for(var i:int=0 ; i<=hasObjectGrid.length-1 ; i++){
				trace(i," : ",hasObjectGrid[ i ]);
			}*/
			return _canAdd;
		}
		
		internal function removeObject(_isoObject:IsoObject):void
		{
			trace("removeObject");
			removeIndex(_isoObject);
			
			var i:uint;
			objectContainer.removeChild(_isoObject.skin);
			_isoObject.removeWorld();
			for( i=0 ; i<=isoObjects.length-1 ; i++ ){
				if( isoObjects[i] == _isoObject ){
					isoObjects.splice(i,1);
				}
			}
			delete dictIsoObjectIndex[_isoObject.index];
			
			/*trace("+++++++++++++++++++++++++[PositionController] removeObject:++++++++++++++++++++++");
			trace(" :::::: ",isoObjects,"::: ");
			for(i=0 ; i<=hasObjectGrid.length-1 ; i++){
				trace(i," : ",hasObjectGrid[ i ]);
			}*/
		}
		
//		internal function moveObject(_isoObject:IsoObject,_toCell:CellData):Boolean
//		{
//			var _canMove:Boolean = addIndex(_toCell.col,_toCell.row,_isoObject.numColumn,_isoObject.numRow,_isoObject.index);
//			if( _canMove ){
//				removeIndex(_isoObject);
//				_isoObject.setColumnRow(_toCell.col,_toCell.row);
//			}else{
//				_isoObject.updateSkinPosition(true);
//			}
//			
//			/*trace("++++++++++++++++++++++++[PositionController] moveObject:++++++++++++++++++++++ _canMove:",_canMove);
//			trace(" :::::: ",isoObjects,"::: ");
//			for(var i:int=0 ; i<=hasObjectGrid.length-1 ; i++){
//				trace(i," : ",hasObjectGrid[ i ]);
//			}*/
//			return _canMove;
//		}
		
		private function sortDepthObjectAt(_index:int):void
		{
			var intervene:int=-1;
			var j:int;
			if( _index>0 && isoObjects[_index-1].depth > isoObjects[_index].depth ){
				for(j=_index-1 ; j>=0 ; j--){
					if( isoObjects[j].depth <= isoObjects[_index].depth ){
						intervene = j+1;
						objectContainer.setChildIndex(isoObjects[_index].skin, 
							objectContainer.getChildIndex(isoObjects[intervene].skin)
						);
						break;
					}else if(j==0){
						intervene = 0;
						objectContainer.setChildIndex(isoObjects[_index].skin, 
							objectContainer.getChildIndex(isoObjects[intervene].skin)
						);
						break;
					}
				}
			}else if( _index<isoObjects.length-1 && isoObjects[_index+1].depth < isoObjects[_index].depth){
				for(j=_index+1 ; j<=isoObjects.length-1 ; j++){
					if( isoObjects[j].depth >= isoObjects[_index].depth ){
						intervene = j-1;
						objectContainer.setChildIndex(isoObjects[_index].skin, 
							objectContainer.getChildIndex(isoObjects[intervene].skin)
						);
						break;
					}else if( j==isoObjects.length-1){
						intervene = isoObjects.length-1;
						objectContainer.setChildIndex(isoObjects[_index].skin, 
							objectContainer.getChildIndex(isoObjects[intervene].skin)
						);
						break;
					}
				}
			}else{
				return;
			}
			
			if( intervene != -1 ){
				// move from "_index" insert to "j"
				//						trace("    bfor",objects,i,intervene);
				isoObjects.splice(intervene,0, isoObjects.splice(_index,1)[0]);
				//						trace("    after",objects);
			}
		}
		
		
		/*********************************************************************
		 * 
		 * index util
		 * 
		 **********************************************************************/		
		
		internal function hasEnoughRoom(_column:int,_row:int,_numColumn:uint,_numRow:uint):Boolean
		{
			//if hasObjectGrid at that position is -1 , mean can't addObject here , so return false;
			var i:uint;
			var j:uint;
			if( _column<0 || _row<0 || 
				_column+_numColumn-1>worldData.numColumn-1 || 
				_row+_numRow-1>worldData.numRow-1){
				return false;
			}
			
			for(i=0 ; i<=_numColumn-1 ; i++){
				if(!hasObjectGrid[ _column+i ]){
					return false;
				}
				for(j=0 ; j<=_numRow-1 ; j++){
					if( !hasObjectGrid[ _column+i ][ _row+j ]){
						return false;
					}else if( hasObjectGrid[ _column+i ][ _row+j ] >= 0 ){
						trace("[WorldObjectManager] have not enough room ,position:[",i,",",j,"] is position of ",hasObjectGrid[ _column+i ][ _row+j ]);
						return false;
					}
				}
			}
			return true;
		}
		
		private function addIndex(_column:int,_row:int,_numColumn:uint,_numRow:uint,_index:int):Boolean
		{
			var _canAdd:Boolean = hasEnoughRoom(_column,_row,_numColumn,_numRow);
			if( _canAdd ){
				// set index of object to mark position that object use
				for(var i:uint=0 ; i<=_numColumn-1 ; i++){
					for(var j:uint=0 ; j<=_numRow-1 ; j++){
						hasObjectGrid[ _column+i ][ _row+j ] = _index;
					}
				}
			}
			return _canAdd;
		}
		
		private function removeIndex(_isoObject:IsoObject):void
		{
			trace("[worldObjectManager] removeIndex()");
			var i:uint;
			for(i=0 ; i<=_isoObject.numColumn-1 ; i++){
				if( _isoObject.column+i<=worldData.numColumn-1 ){
					for(var j:uint=0 ; j<=_isoObject.numRow-1 ; j++){
						if( _isoObject.row+j<=worldData.numRow-1 ){
							if( hasObjectGrid[ _isoObject.column+i ][ _isoObject.row+j ]==_isoObject.index ){
								hasObjectGrid[ _isoObject.column+i ][ _isoObject.row+j ] = -1;
								trace("  removeIdex::",_isoObject.column+i, _isoObject.row+j);
							}
						}
					}
				}
			}
		}
	}
}