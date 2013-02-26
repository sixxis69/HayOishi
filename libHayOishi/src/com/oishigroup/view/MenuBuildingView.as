package com.oishigroup.view
{
	import com.greensock.TweenLite;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class MenuBuildingView extends Sprite
	{
		public var allMenu:Quad;
		public function MenuBuildingView()
		{
			super();
			allMenu = new Quad(100,500,0x334433);
			addChild(allMenu);
		}
		
		public function close():void
		{
			TweenLite.to(allMenu,.2,{x:-100});
		}
	}
}