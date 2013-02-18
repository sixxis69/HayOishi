package api
{
	import flash.net.URLVariables;
	
	public class TestAPI extends BaseAPI
	{
		public function TestAPI()
		{
			var uv:URLVariables = new URLVariables();
			uv.xtoken = "abc";
			super("test.php", uv);
		}
		
		override protected function loadedXMLComplete(_xml:XML):void
		{
			trace("loaded xml:",_xml.@success , _xml.variable);
			super.loadedXMLComplete(_xml);
		}
		
	}
}