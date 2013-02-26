package com.oishigroup.controller
{
	import com.oishigroup.view.CountDownPopupView;
	
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import starling.display.DisplayObject;

	public class CountDownMovePopupViewController
	{
		public var view:DisplayObject = new CountDownPopupView();
		private var onComplete:Function;
		private var countID:uint;
		public function CountDownMovePopupViewController(_onComplete:Function)
		{
			onComplete = _onComplete;
		}
		
		public function start():void
		{
			countID = setTimeout(function():void{
				onComplete();
			},1000);
		}
		
		public function stop():void
		{
			clearTimeout(countID);	
		}
	}
}