package com.oishigroup.api
{
	import com.oishigroup.metadata.MetaData;
	
	import flash.net.URLVariables;
	
	public class InitAPI extends BaseJSONAPI
	{
		public function InitAPI(_url:String, _uv:URLVariables=null, _autoRefresh:Boolean=true)
		{
			super(_url, _uv, _autoRefresh);
		}
	}
}