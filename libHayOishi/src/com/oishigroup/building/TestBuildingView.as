package com.oishigroup.building
{
	import starling.display.Quad;
	
	public class TestBuildingView extends Quad
	{
		protected var paddingX:Number = 100;
		protected var paddingY:Number = 100;
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function TestBuildingView()
		{
			super(200,200,0xFFFFFF*Math.random());
			alpha=.9;
		}
		
		override public function get x():Number
		{
			return _x;
		}
		
		override public function set x(value:Number):void
		{
			_x=value;
			super.x = _x-paddingX;
		}
		
		override public function get y():Number
		{
			return _y;
		}
		
		override public function set y(value:Number):void
		{
			_y=value;
			super.y = _y-paddingY;
		}
		
	}
}