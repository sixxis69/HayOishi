package com.oishigroup.interactivemanager
{
	import com.greensock.TweenLite;
	import com.oishigroup.metadata.MetaData;
	
	import flash.events.MouseEvent;
	
	import EXIT.starlingiso.display.BaseInteractiveManager;
	import EXIT.starlingiso.display.IsoWorld;
	
	public class MouseInteractManager extends MoveableInteractiveManager
	{
		private var nowZoom:Number = 1;
		public function MouseInteractManager()
		{
			super();
		}
		
		public override function initialize(_isoWold:IsoWorld):void
		{
			super.initialize(_isoWold);
			MetaData.flashStage.addEventListener(MouseEvent.MOUSE_WHEEL,scrolling );
		}
		
		protected function scrolling(event:MouseEvent):void
		{
			if( event.delta > 0 )
				nowZoom = nowZoom*1.1;
			else if( event.delta < 0 )
				nowZoom = nowZoom*.9;
			
			if( nowZoom > MAX_ZOOM ){
				nowZoom = MAX_ZOOM;
				tweenZoom(MAX_ZOOM+1);
			}else if( nowZoom < MIN_ZOOM ){
				nowZoom = MIN_ZOOM;
				tweenZoom(MIN_ZOOM-1);
			}else{
				tweenZoom(nowZoom);
			}
		}
		
		protected function tweenZoom(_zoom:Number):void
		{
			var _this:BaseInteractiveManager = this;
			if( _zoom>MAX_ZOOM){
				TweenLite.to(_this,.2,{zoom:MAX_ZOOM*1.1,onComplete:function():void{
					TweenLite.to(_this,.2,{zoom:MAX_ZOOM});
				}});
			}else if( _zoom<MIN_ZOOM){
				TweenLite.to(_this,.2,{zoom:MIN_ZOOM*.9,onComplete:function():void{
					TweenLite.to(_this,.2,{zoom:MIN_ZOOM});
				}});
			}else{
				TweenLite.to(_this,.3,{zoom:_zoom});
			}
		}
		
	}
}