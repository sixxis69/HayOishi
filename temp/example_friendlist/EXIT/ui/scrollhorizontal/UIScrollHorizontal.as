package EXIT.ui.scrollhorizontal
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class UIScrollHorizontal extends Sprite
	{
		private const MAX_SPEED:Number = 100;
		
		protected var container:Sprite = new Sprite();
		private var maskWidth:Number;
		private var maskHeight:Number;
		private var containerWidth:Number;
		
		private var startMouseX:Number;
		private var startContainerX:Number;
		private var speed:Number;
		
		public function UIScrollHorizontal(_maskWidth:Number,_maskHeight:Number)
		{
			super();
			maskWidth = _maskWidth;
			maskHeight = _maskHeight;
			
			graphics.beginFill(0,0);
			graphics.drawRect(0,0,maskWidth,maskHeight);
			graphics.endFill();
			
			var bitmap:Bitmap = new Bitmap( new BitmapData(maskWidth,maskHeight , true,0) );
			super.addChild(bitmap);
			
			super.addChild(container);
			container.mask = bitmap;
			
			addEventListener(MouseEvent.MOUSE_DOWN , mouseDownMe);			
		}
		
		protected function mouseDownMe(event:MouseEvent):void
		{
			speed = 0;
			startMouseX = mouseX;
			startContainerX = container.x;
			TweenLite.killTweensOf(container);
			if( container.x>0  || containerWidth<maskWidth){
				startContainerX = container.x*2;
			}else if( container.x+containerWidth < maskWidth ){
				startContainerX = maskWidth - (maskWidth - ( container.x + containerWidth ) )*2 - containerWidth;
			}
			
			addEventListener(Event.ENTER_FRAME , moveMe );
			stage.addEventListener(MouseEvent.MOUSE_UP , mouseUpMe);	
			
			removeEventListener(Event.ENTER_FRAME , inertia );
		}
		
		protected function moveMe(event:Event):void
		{
			var lastContainerX:Number = container.x;
			container.x = startContainerX+(mouseX-startMouseX);
			
			if( container.x>0 || containerWidth<maskWidth){
				container.x *= .5;
			}else if( container.x+containerWidth < maskWidth ){
				container.x = maskWidth - (maskWidth - ( container.x + containerWidth) )*.5 - containerWidth;
			}
			
			speed = container.x-lastContainerX;
			if( speed>MAX_SPEED){
				speed=MAX_SPEED;
			}
			moving();
		}
		
		protected function mouseUpMe(event:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME , moveMe );
			stage.removeEventListener(MouseEvent.MOUSE_UP , mouseUpMe);	
			addEventListener(Event.ENTER_FRAME , inertia );
		}
		
		protected function inertia(event:Event):void
		{
			if( container.x>0  || containerWidth<maskWidth){
				speed*=.5;
			}else if( container.x+containerWidth < maskWidth ){
				speed*=.5;
			}else{
				speed*=.95;
			}
			container.x += speed;
			moving();
			if( Math.abs(speed)<.2 ){
				removeEventListener(Event.ENTER_FRAME , inertia );
				if( container.x>0  || containerWidth<maskWidth){
					TweenLite.to(container,.3,{x:0,onUpdate:moving});
				}else if( container.x+containerWidth < maskWidth ){
					TweenLite.to(container,.3,{x:maskWidth-containerWidth,onUpdate:moving});
				}
			}
		}		
		
		protected function moving():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function updateContainer():void
		{
			containerWidth = container.width;
		}
		
		/**
		 * 
		 * OVERRIDE
		 * 
		 */		
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var child:DisplayObject = container.addChild(child);
			updateContainer();
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var child:DisplayObject =container.addChildAt(child, index);
			updateContainer();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var child:DisplayObject = container.removeChild(child);
			updateContainer();
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = container.removeChildAt(index);
			updateContainer();
			return child;
		}
		
		
	}
}