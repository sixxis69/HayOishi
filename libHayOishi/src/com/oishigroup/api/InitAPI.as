package com.oishigroup.api
{
	import com.oishigroup.metadata.MetaData;
	
	import flash.net.URLVariables;
	
	public class InitAPI extends BaseJSONAPI
	{
		public function InitAPI(js:Object, _autoRefresh:Boolean=true)
		{
			super(ConfigPath.INIT,js,_autoRefresh);
		}
	}
}