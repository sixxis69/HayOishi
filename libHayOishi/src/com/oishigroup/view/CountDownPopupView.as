package com.oishigroup.view
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class CountDownPopupView extends Sprite
	{
		public function CountDownPopupView()
		{
			super();
			var quad:Quad = new Quad(100,100,0x558855);
			addChild(quad);
		}
	}
}