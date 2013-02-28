package tomorrowart.debug
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.AeonDesktopTheme;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import tomorrowart.debug.data.UserModel;
	import tomorrowart.debug.screen.InitResponseScreen;
	import tomorrowart.debug.screen.InitScreen;
	import tomorrowart.debug.screen.MainMenuScreen;
	
	public class DebugView extends Sprite
	{
		public static const STAT_MARGIN:int			= 60;
		
		private static const MAIN_MENU:String		= "mainMenu";
		private static const INIT:String			= "init";
		private static const INIT_RESULT:String		= "initResult";
		
		
//		private var _theme:MetalWorksMobileTheme;
		private var _theme:AeonDesktopTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		public function DebugView()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,initView);
		}
		
		private function initView(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,initView);
			
			_theme = new AeonDesktopTheme(this.stage);
			_navigator = new ScreenNavigator();
			addChild(_navigator);
			
			var userModel:UserModel = new UserModel();
			
			_navigator.addScreen(MAIN_MENU,new ScreenNavigatorItem(MainMenuScreen,
				{
					showInit: INIT
				}));
			
			_navigator.addScreen(INIT,new ScreenNavigatorItem(InitScreen,
				{
					showInitResult: INIT_RESULT,
					complete: MAIN_MENU
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(INIT_RESULT,new ScreenNavigatorItem(InitResponseScreen,
				{
					complete: INIT
				},
				{
					userData: userModel
				}));
			
			
			
			_navigator.showScreen(MAIN_MENU);
			
			_transitionManager = new ScreenSlidingStackTransitionManager(_navigator);
			_transitionManager.duration = 0.4;
		}
	}
}