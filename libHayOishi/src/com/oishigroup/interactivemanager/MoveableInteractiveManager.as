package com.oishigroup.interactivemanager
{
	import com.oishigroup.IsoWorldObjectMoveAble;
	import com.oishigroup.building.MoveableIsoObject;
	import com.oishigroup.building.TestBuildingViewController;
	import com.oishigroup.metadata.MetaData;
	import com.oishigroup.model.InteractiveModel;
	
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import EXIT.starlingiso.data.CellData;
	import EXIT.starlingiso.display.BaseInteractiveManager;
	import EXIT.starlingiso.display.IsoObject;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MoveableInteractiveManager extends BaseInteractiveManager
	{
		private const TIME_TO_START_COUNT:Number = 200;
		private const MOVE_DISTANCE:Number = 8;
		
		
		private var currentMovingBuilding:MoveableIsoObject;
		private var lastCellData:CellData;
		private var mIsMoved:Boolean = false;
		
		//select
		private var timeoutMoveID:int = 0;
		
		public function MoveableInteractiveManager()
		{
			super();
		}
		
		override public function active():void
		{
			super.active();
			InteractiveModel.instance.signalBuildingReadyToBuild.add(readyTobuild);
			InteractiveModel.instance.signalStartMoveObject.add(readyToMoveObject);
		}
		
		override public function deactive():void
		{
			super.deactive();
			touchDummy.removeEventListener(Event.ENTER_FRAME,dragging);
			MetaData.flashStage.removeEventListener(MouseEvent.MOUSE_UP,stopDragAndActiveMoveWorld);
			InteractiveModel.instance.signalBuildingReadyToBuild.remove(readyTobuild);
			InteractiveModel.instance.signalStartMoveObject.remove(readyToMoveObject);
		}
		
		private function readyTobuild(_buildingName:String):void
		{
			trace("readyToBuild new Building...");
			lastCellData=null;
			if( _buildingName == InteractiveModel.BUILDING_TEST){
				currentMovingBuilding = new TestBuildingViewController();
			}
			startDrag();
		}
		
		private function readyToMoveObject():void
		{
			lastCellData=new CellData(currentMovingBuilding.column,currentMovingBuilding.row);
			world.removeIsoObject(currentMovingBuilding);
			startDrag();	
		}
		
		/**
		 * DRAG 
		 * 
		 */		
		
		private function startDrag():void
		{
			trace("4. startDrag");
			IsoWorldObjectMoveAble(world).addDummyObject(currentMovingBuilding);
			worldContainer.setChildIndex(currentMovingBuilding.skin,worldContainer.numChildren-1);
			super.deactive();
			
			touchDummy.addEventListener(Event.ENTER_FRAME,dragging);
			MetaData.flashStage.addEventListener(MouseEvent.MOUSE_UP,stopDragAndActiveMoveWorld);
			dragging();
		}
		
		private function dragging(e:Event=null):void
		{
			//			trace("::",screenToWolrdContainerX(touchPointX) , screenToWolrdContainerY(touchPointY));
			var cellData:CellData = isoHelper.xyToRowCol( screenToWolrdContainerX(MetaData.flashStage.mouseX) , screenToWolrdContainerY(MetaData.flashStage.mouseY) );
			currentMovingBuilding.moveSkin(cellData.col,cellData.row);
		}
		
		private function stopDragAndActiveMoveWorld(e:MouseEvent=null):void
		{
			trace("5. stopDrag currentObjectIndex:");
			touchDummy.removeEventListener(Event.ENTER_FRAME,dragging);
			MetaData.flashStage.removeEventListener(MouseEvent.MOUSE_UP,stopDragAndActiveMoveWorld);
			
			var cellData:CellData = isoHelper.xyToRowCol( screenToWolrdContainerX(MetaData.flashStage.mouseX) , screenToWolrdContainerY(MetaData.flashStage.mouseY) );
			currentMovingBuilding.setColumnRow(cellData.col,cellData.row);
			var canAdd:Boolean = world.addIsoObject(currentMovingBuilding);
			
			if( lastCellData ){
				trace(' 5.1_ move canAdd:',canAdd);
				if(!canAdd){
					currentMovingBuilding.setColumnRow(lastCellData.col,lastCellData.row);
					trace(" ::currentMovingBuilding::",currentMovingBuilding.column,currentMovingBuilding.row);
					trace(" ::lastCellData::",lastCellData.col,lastCellData.row);
					trace(" add back:",world.addIsoObject(currentMovingBuilding),lastCellData );
				}
			}else{
				trace(' 5.2_ addObject');
				trace("   _canAdd:",canAdd);
				if(!canAdd){
					IsoWorldObjectMoveAble(world).removeDummyObject(currentMovingBuilding);
				}
			}
			currentMovingBuilding=null;
			super.active();
		}
		
		/**
		 * SELECT 
		 */		
		
		private function selectObject():void
		{
			trace("1. selectObject");
			timeoutMoveID = setTimeout(startCount,TIME_TO_START_COUNT);
		}
		
		private function startCount():void
		{
			trace("2. startCount");
			InteractiveModel.instance.signalSelectObject.dispatch(currentMovingBuilding);
		}
		
		private function cancelObject():void
		{
			trace("3. cancelObject");
			clearTimeout(timeoutMoveID);
			InteractiveModel.instance.signalCancelObject.dispatch();
		}
		
		/**
		 * TOUCH 
		 */		
		
		override protected function touchComposer(e:TouchEvent):void
		{
			var btn:DisplayObject = DisplayObject(e.currentTarget);
			var touch:Touch = e.getTouch(btn);
			if (touch==null)
				return;
			
			if (touch.phase==TouchPhase.BEGAN&&!mIsDown) {
				startMoveWorldContainer(touch);
				
				var touchCell:CellData = isoHelper.xyToRowCol( screenToWolrdContainerX(touch.globalX) , screenToWolrdContainerY(touch.globalY) );
				var isoObject:IsoObject = world.getIsoObjectAt( touchCell.col , touchCell.row );
				if( isoObject && isoObject is MoveableIsoObject ){
					currentMovingBuilding = isoObject as MoveableIsoObject;
					selectObject();
				}
				
				mIsDown = true;
				mIsMoved = false;
			} else if (touch.phase==TouchPhase.MOVED&&mIsDown) {
				
				if ((Math.abs(touch.globalX-touchPointX)>MOVE_DISTANCE||
					Math.abs(touch.globalY-touchPointY)>MOVE_DISTANCE)
					&&!mIsMoved) {

					movingWorldContainer(touch);
					cancelObject();
					mIsMoved = true;
				}else if(mIsMoved){
					movingWorldContainer(touch);
				}
			} else if (touch.phase==TouchPhase.ENDED) {
				stopMoveWorldContainer(touch);
				mIsDown = false;
				mIsMoved = false;
			}
		}
		
		
		/**
		 *Util 
		 */		
		private function screenToWolrdContainerX(_x:Number):Number
		{
			return (_x - worldContainer.x)/worldContainer.scaleX;
		}
		
		private function screenToWolrdContainerY(_y:Number):Number
		{
			return (_y - worldContainer.y)/worldContainer.scaleY;
		}
	}
}