package com.oishigroup.building
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class BaseSkinImage extends Image
	{
		protected var paddingX:Number = 100;
		protected var paddingY:Number = 100;
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function BaseSkinImage(texture:Texture)
		{
			super(texture);
		}
		
		override public function set x(value:Number):void
		{
			_x=value;
			super.x = _x-paddingX;
		}
		
		override public function set y(value:Number):void
		{
			_y=value;
			super.y = _y-paddingY;
		}
		override public function get y():Number{return _y;}
		override public function get x():Number{return _x;}
	}
}