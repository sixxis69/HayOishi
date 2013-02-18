package EXIT.facebook
{
	import com.facebook.graph.FacebookMobile;
	import com.facebook.graph.data.FacebookSession;
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import org.osflash.signals.Signal;

	public class FacebookUtil
	{
		public var signalInitNotLoggedIn:Signal = new Signal();
		public var signalLoggedIn:Signal = new Signal();
		public var signalLogInError:Signal = new Signal();
		public var signalLoggedOut:Signal = new Signal();
		
		private var appid:String;
		private var stage:Stage;
		private static var _instance:FacebookUtil;
		private static var _canInit:Boolean;
		
		
		public function FacebookUtil()
		{
			/**
			 * EXAMPLE
			 * FacebookUtil.initFacebook("566070093421651","http://exitapplication.com",stage);
			 */
			if (_canInit == false) {
				throw new Error(
					'FacebookMobile is an singleton and cannot be instantiated.'
				);
			}
		}
		
		public function initFacebook(_appid:String,_stage:Stage):void
		{
			appid = _appid;
			stage = _stage;
			FacebookMobile.init(appid, onInit);
			//FacebookMobile.fqlQuery("SELECT uid,name FROM user WHERE has_added_app=1 and uid IN (SELECT uid2 FROM friend WHERE uid1 = me())");
		}
		
		protected function onInit(result:Object, fail:Object):void {
			if (result) { //already logged in because of existing session
				trace("onInit, Logged In\n");
				signalLoggedIn.dispatch();
			} else {
				trace("onInit, Not Logged In\n");
				signalInitNotLoggedIn.dispatch();
			}
		}
		
		
		/**
		 * LOGIN 
		 */		
		public function login():void
		{
			var webview:StageWebView = new StageWebView();
			webview.viewPort = new Rectangle(0,0,500,500);
			FacebookMobile.login(handleLogin, stage, ["user_about_me,user_activities,friends_about_me,offline_access"],webview );
		}
		
		private function handleLogin(session:FacebookSession,error:*):void
		{
			trace("loggedIn");
			if(session){
				signalLoggedIn.dispatch();
			}else{
				signalLogInError.dispatch();
			}
		}
		
		/**
		 * LOGOUT
		 */		
		
		 public function logout():void
		{
			FacebookMobile.logout(handleLogout,appid);
		}
		
		private function handleLogout(_success:Boolean):void
		{
			trace("handleLogout");
			signalLoggedOut.dispatch();
		}
		
		public static function getInstance():FacebookUtil 
		{
			if (_instance == null) {
				_canInit = true;
				_instance = new FacebookUtil();
				_canInit = false;
			}
			return _instance;
		}
	}
}