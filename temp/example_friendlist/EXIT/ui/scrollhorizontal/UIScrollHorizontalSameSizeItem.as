package EXIT.ui.scrollhorizontal
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.area80.image.ImageBox;
	
	public class UIScrollHorizontalSameSizeItem extends UIScrollHorizontal
	{
		private var items:Vector.<Sprite> = new Vector.<Sprite>();
		private var divWidth:Number;
		public function UIScrollHorizontalSameSizeItem(_maskWidth:Number, _maskHeight:Number , _divWidth:Number)
		{
			super(_maskWidth, _maskHeight);
			divWidth = _divWidth;
		}
		
		public function addItem(_item:Sprite):void
		{
			DisplayObject(_item).x = divWidth*items.length;
			items.push( _item );
			ImageBox;
			super.addChild(DisplayObject(_item));
		}
		
		override protected function moving():void
		{
			super.moving();
		}
		
		
		
		/**
		 * 
		 * OVERRIDE
		 * 
		 */		
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			throw new Error("Does not support!!!");
			return;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			throw new Error("Does not support!!!");
			return;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			throw new Error("Does not support!!!");
			return;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			throw new Error("Does not support!!!");
			return;
		}
	}
}