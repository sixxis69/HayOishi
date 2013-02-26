package com.oishigroup
{
	import com.oishigroup.controller.CountDownMovePopupViewController;
	import com.oishigroup.controller.MenuBuildingViewController;
	import com.oishigroup.interactivemanager.MoveableInteractiveManager;
	import com.oishigroup.metadata.MetaData;
	import com.oishigroup.model.InteractiveModel;
	
	import flash.geom.Point;
	
	import EXIT.starlingiso.display.IsoObject;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class MainGame extends Sprite
	{
		protected var mainIsoWorld:IsoWorldObjectMoveAble;
		protected var menuBuildingViewController:MenuBuildingViewController;
		
		
		private var countDownPopupController:CountDownMovePopupViewController = new CountDownMovePopupViewController(startMove);
		private var popupLayer:Sprite = new Sprite();
		
		public function MainGame(_moveableInteractiveManager:MoveableInteractiveManager)
		{
			super();
			
			//iso world
			mainIsoWorld = new IsoWorldObjectMoveAble(_moveableInteractiveManager,MetaData.isDebug);
			addChild(mainIsoWorld);
			
			//interactive
			InteractiveModel.instance.signalSelectObject.add(showTimeoutToMove);
			InteractiveModel.instance.signalCancelObject.add(hideTimeoutToMove);
			addChild(popupLayer);
			
			//menu
			menuBuildingViewController = new MenuBuildingViewController();
			addChild(menuBuildingViewController.view);
			
			forTest();
		}
		
		private function forTest():void
		{
			var tempObjs:Vector.<IsoObject> = new Vector.<IsoObject>();
			for( var i:uint=0 ; i<=4 ; i++){
				var quad:Quad = new Quad(100,100,0xAAAAAA*Math.random(),false);
				var obj:IsoObject = new IsoObject(quad,2,2);
				obj.setColumnRow(i*2,i);
				mainIsoWorld.addIsoObject(obj);
				tempObjs.push(obj);
			}
			mainIsoWorld.removeIsoObject(tempObjs[3]);
			mainIsoWorld.removeIsoObject(tempObjs[4]);
			mainIsoWorld.removeIsoObject(tempObjs[1]);
			mainIsoWorld.removeIsoObject(tempObjs[2]);
			mainIsoWorld.removeIsoObject(tempObjs[0]);
		}
		
		/**
		 * Time out pop up 
		 */		
		
		private function showTimeoutToMove(_selectObject:IsoObject):void
		{
			countDownPopupController.start();
			var p:Point = mainIsoWorld.getCenterPointObject(_selectObject);
			countDownPopupController.view.x = p.x
			countDownPopupController.view.y = p.y
			popupLayer.addChild(countDownPopupController.view);
		}
		
		private function hideTimeoutToMove():void
		{
			popupLayer.removeChild(countDownPopupController.view);
			countDownPopupController.stop();
		}
		
		private function startMove():void
		{
			hideTimeoutToMove();
			InteractiveModel.instance.signalStartMoveObject.dispatch();
		}
		
	}
}