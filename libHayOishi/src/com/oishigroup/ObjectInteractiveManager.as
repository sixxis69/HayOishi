package com.oishigroup
{
	import EXIT.starlingiso.display.IsoObject;
	import starling.display.Sprite;

	public class ObjectInteractiveManager
	{
		private var overlayer:Sprite;
		public function ObjectInteractiveManager(_overlayer:Sprite)
		{
			overlayer = _overlayer;
		}
		
		public function startMoveIsoObject(_isoObject:IsoObject):void
		{
			overlayer.addChild(_isoObject.skin);
		}
	}
}