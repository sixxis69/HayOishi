package EXIT.starlingiso.display
{
	import EXIT.starling.util.TouchComposer;
	import EXIT.starlingiso.data.WorldData;
	
	import com.greensock.TweenLite;
	
	import flash.utils.getTimer;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;

	public class BaseInteractController
	{
		protected const FRAME_RATE:Number = 30;
		protected const MIN_SPACE_MOVE:Number = .2;
		
		protected var touchDummy:DisplayObject;
		protected var worldContainer:DisplayObject;
		protected var halfWorldWidth:Number;
		protected var halfWorldHeight:Number;
		protected var widowWidth:Number;
		protected var widowHeight:Number;
		protected var touchComposer:TouchComposer;
		
		// positionvariable 
		protected var touchPointX:Number;
		protected var touchPointY:Number;
		protected var objectPointX:Number;
		protected var objectPointY:Number;
		protected var lastTime:Number = 0;
		protected var speedX:Number = 0;
		protected var speedY:Number = 0;
		
		// zoom variable
		protected var _zoom:Number = 1;
		protected const MAX_ZOOM:Number = 1;
		protected const MIN_ZOOM:Number = .5;
		
		public function BaseInteractController()
		{
		}
		
		public function initialize(_isoWold:IsoWorld):void
		{
			touchDummy = _isoWold.touchDummy;
			worldContainer = _isoWold.worldContainer;
			halfWorldWidth = _isoWold.worldData.worldWidth*.5;
			halfWorldHeight = _isoWold.worldData.worldHeight*.5;
			widowWidth = _isoWold.worldData.windowWidth;
			widowHeight = _isoWold.worldData.windowHeight;
			
			touchComposer = new TouchComposer(touchDummy);
			
			speedX = 0;
			speedY = 0;
			lastTime = getTimer();
		}
		
		public function active():void
		{
			touchComposer.mouseDown(mouseDown);
			touchComposer.mouseUp(mouseUp);
			touchComposer.mouseMove(mouseMove);
		}
		
		public function deactive():void
		{
			touchDummy.removeEventListener(Event.ENTER_FRAME , inertia );
			touchComposer.mouseDown(null);
			touchComposer.mouseUp(null);
			touchComposer.mouseMove(null);
		}
		
		
		
		/**
		 * MOVE
		 */		
		
		private function mouseDown(_touch:Touch):void
		{
			touchPointX = _touch.globalX;
			touchPointY = _touch.globalY;
			objectPointX = worldContainer.x;
			objectPointY = worldContainer.y;
			speedX = 0;
			speedY = 0;
			touchDummy.removeEventListener(Event.ENTER_FRAME , inertia );
		}
		
		private function mouseUp(_touch:Touch):void
		{
			var timeDiv:Number = getTimer()-lastTime;
//			trace(" mouseUp timeDiv :" ,timeDiv);
			
			/** check if mouse up after the last mouse move less than 20 ms , apply inertia to it */
			if( timeDiv <20 ){
				speedX*=FRAME_RATE; // multiply frame rate , convert speed to frame per sec
				speedY*=FRAME_RATE;
				
				if( speedX == Infinity || speedX == -Infinity || isNaN(speedX) ){
					speedX = 0;
				}
				if( speedY == Infinity || speedY == -Infinity || isNaN(speedY) ){
					speedY = 0;
				}
//				trace("speedX:",speedX,"speedY:",speedY);
				touchDummy.addEventListener(Event.ENTER_FRAME , inertia );
			}
		}
		
		private function inertia(e:Event):void
		{
			//trace("speedX:",speedX,"speedY:",speedY);
			updateWorldContainerX( worldContainer.x + speedX );
			updateWorldContainerY( worldContainer.y + speedY );
			speedX *= 0.9;
			speedY *= 0.9;
			if( speedX < MIN_SPACE_MOVE && speedX > -MIN_SPACE_MOVE && 
				speedY < MIN_SPACE_MOVE && speedY > -MIN_SPACE_MOVE){
				touchDummy.removeEventListener(Event.ENTER_FRAME , inertia );
			}
		}
		
		private function mouseMove(_touch:Touch):void
		{
			var nowTime:Number = getTimer();
			var timeDiv:Number = nowTime-lastTime;
			
			/** sometimes touch of starling send event twice at once , so check if it's the first*/
			if( timeDiv>0 ){
				var nowWorldContainerX:Number = (_touch.globalX-touchPointX)+objectPointX;
				var nowWorldContainerY:Number = (_touch.globalY-touchPointY)+objectPointY;
				
				speedX = (nowWorldContainerX-worldContainer.x)/timeDiv;
				speedY = (nowWorldContainerY-worldContainer.y)/timeDiv;
//				trace(" mouseMove timeDiv:",timeDiv);
				updateWorldContainerX(nowWorldContainerX);
				updateWorldContainerY(nowWorldContainerY);
				lastTime = nowTime;
			}
		}
		
		private function updateWorldContainerX(_x:Number):void
		{
			if( _x-halfWorldWidth*_zoom > 0 ){
				worldContainer.x = halfWorldWidth*_zoom;
			}else if( _x+halfWorldWidth*_zoom < widowWidth ){
				worldContainer.x = widowWidth-halfWorldWidth*_zoom;
			}else{
				worldContainer.x = _x;
			}
		}
		
		private function updateWorldContainerY(_y:Number):void
		{
			if( _y-halfWorldHeight*_zoom > 0 ){
				worldContainer.y = halfWorldHeight*_zoom;
			}else if( _y+halfWorldHeight*_zoom < widowHeight ){
				worldContainer.y = widowHeight-halfWorldHeight*_zoom;
			}else{
				worldContainer.y = _y;
			}
		}
		
		
		/**
		 * ZOOM 
		 */		
		
		public function set zoom(_zoom:Number):void
		{
			this._zoom = _zoom;
			worldContainer.scaleX = worldContainer.scaleY = this._zoom;
		}
		public function get zoom():Number{return _zoom;}
	}
}