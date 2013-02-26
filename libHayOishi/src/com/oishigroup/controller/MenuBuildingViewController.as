package com.oishigroup.controller
{
	import com.oishigroup.model.InteractiveModel;
	import com.oishigroup.view.MenuBuildingView;
	
	import EXIT.starling.util.TouchComposer;
	
	import starling.display.Quad;

	public class MenuBuildingViewController
	{
		public var view:MenuBuildingView;
		public function MenuBuildingViewController()
		{
			view = new MenuBuildingView();
			InteractiveModel.instance.signalBuildingReadyToBuild.add(closeMe);
			
			var buildingIcon:Quad = new Quad(100,100);
			view.addChild(buildingIcon);
			
			var touchBuilding:TouchComposer = new TouchComposer(buildingIcon);
			touchBuilding.mouseDown(function():void{
				InteractiveModel.instance.signalBuildingReadyToBuild.dispatch(InteractiveModel.BUILDING_TEST);
			});
		}
		
		private function closeMe(_type:String):void
		{
			view.close();
		}
	}
}