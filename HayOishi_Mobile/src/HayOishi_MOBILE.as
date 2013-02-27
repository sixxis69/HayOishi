package
{
	import com.oishigroup.MainApp;
	import com.oishigroup.MainGameMobile;
	import com.oishigroup.metadata.MetaData;
	
	public class HayOishi_MOBILE extends MainApp
	{
		public function HayOishi_MOBILE()
		{
			super();
			MetaData.isDebug =true;
			initApp(MainGameMobile)
		}
	}
}