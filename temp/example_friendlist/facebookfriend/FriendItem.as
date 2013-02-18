package facebookfriend
{
	import EXIT.ui.scrollhorizontal.IItemScrollHorizontal;
	
	import flash.display.Sprite;
	
	import net.area80.image.ImageBox;
	
	public class FriendItem extends Sprite implements IItemScrollHorizontal
	{
		public function FriendItem()
		{
			super();
			graphics.beginFill(0);
			graphics.drawRect(0,0,50,50);
			graphics.endFill();
			
			var imaeBox:ImageBox = new ImageBox("",10,10);
		}
		
		public function active():void
		{
			
		}
		
		public function deactive():void
		{
			
		}
		
		public function get divWidth():Number
		{
			return 100;
		}
		
	}
}