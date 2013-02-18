package facebookfriend
{
	import EXIT.facebook.FacebookUtil;
	import EXIT.ui.scrollhorizontal.UIScrollHorizontalSameSizeItem;
	
	import api.data.MetaData;
	
	import com.facebook.graph.FacebookMobile;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FriendsSprite extends Sprite
	{
		private var isLoaded:Boolean = false;
		
		private var fbUtil:FacebookUtil;
		private var friendsScrollView:UIScrollHorizontalSameSizeItem;


		
		public function FriendsSprite()
		{
			super();
			fbUtil = FacebookUtil.getInstance();
			fbUtil.signalInitNotLoggedIn.add( fbInitNotLoggedIn );
			fbUtil.signalLoggedIn.add( fbLogggedIn );
			fbUtil.signalLogInError.add( fbLoggError );
			fbUtil.signalLoggedOut.add( fbLoggedOut );
			
			addEventListener(Event.ADDED_TO_STAGE , initialize);
		}
		
		protected function initialize(event:Event):void
		{
			fbUtil.initFacebook("566070093421651",stage);
		}
		
		protected function loadedFriends( ... args):void
		{
			if( args && args ){
				var friends:Array = args[0];
				for( var i:uint=0;i<= friends.length-1; i++){
					var friendSprite:FriendItem = new FriendItem();//friends.uid
					friendSprite.x = i*100;
					friendsScrollView.addItem(friendSprite);
				}
			}
		}
		
		
		
		private function fbInitNotLoggedIn():void
		{
			fbUtil.login();
		}
		
		private function fbLogggedIn():void
		{
			/*fbUtil.logout();
			return;*/
			trace("loggedIn");
			MetaData.access_token = FacebookMobile.getSession().accessToken;
			FacebookMobile.fqlQuery("SELECT uid,name FROM user WHERE uid IN( SELECT uid1 FROM friend WHERE uid2=me() )LIMIT 0,50",loadedFriends);// AND is_app_user 
			
			friendsScrollView = new UIScrollHorizontalSameSizeItem(500,200,150);
			addChild(friendsScrollView);
		}
		
		private function fbLoggError():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function fbLoggedOut():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}