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
	import tomorrowart.debug.screen.MainMenuScreen;
	import tomorrowart.debug.screen.ResponseScreen;
	import tomorrowart.debug.screen.api.GetFriendsScreen;
	import tomorrowart.debug.screen.api.InitScreen;
	import tomorrowart.debug.screen.api.SaveFarmNameScreen;
	import tomorrowart.debug.screen.api.UpdateFieldsScreen;
	
	public class DebugView extends Sprite
	{
		public static const STAT_MARGIN:int			= 60;
		
		private static const MAIN_MENU:String				= "mainMenu";
		
		private static const INIT:String					= "init";
		private static const INIT_RESULT:String				= "initResult";
		private static const GET_FRIENDS:String 			= "getFriends";
		private static const GET_FRIENDS_RESULT:String		= "getFriendsResult";
		private static const SAVE_FARM_NAME:String			= "saveFarmName";
		private static const SAVE_FARM_NAME_RESULT:String	= "saveFarmNameResult";
		private static const UPDATE_FIELDS:String			= "updateFields";
		private static const UPDATE_FIELDS_RESULT:String	= "updateFieldsResult";
		
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
					showInit: INIT,
					showGetFriends: GET_FRIENDS,
					showSaveFarmName: SAVE_FARM_NAME,
					showUpdateField: UPDATE_FIELDS
				}));
			
			_navigator.addScreen(INIT,new ScreenNavigatorItem(InitScreen,
				{
					showResult: INIT_RESULT,
					complete: MAIN_MENU
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(INIT_RESULT,new ScreenNavigatorItem(ResponseScreen,
				{
					complete: INIT
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(GET_FRIENDS,new ScreenNavigatorItem(GetFriendsScreen,
				{
					complete: MAIN_MENU,
					showResult: GET_FRIENDS_RESULT
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(GET_FRIENDS_RESULT,new ScreenNavigatorItem(ResponseScreen,
				{
					complete: GET_FRIENDS
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(SAVE_FARM_NAME,new ScreenNavigatorItem(SaveFarmNameScreen,
				{
					complete: MAIN_MENU,
					showResult: SAVE_FARM_NAME_RESULT
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(SAVE_FARM_NAME_RESULT,new ScreenNavigatorItem(ResponseScreen,
				{
					complete: SAVE_FARM_NAME
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(UPDATE_FIELDS,new ScreenNavigatorItem(UpdateFieldsScreen,
				{
					complete: MAIN_MENU,
					showResult: UPDATE_FIELDS_RESULT
				},
				{
					userData: userModel
				}));
			
			_navigator.addScreen(UPDATE_FIELDS_RESULT,new ScreenNavigatorItem(ResponseScreen,
				{
					complete: UPDATE_FIELDS
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