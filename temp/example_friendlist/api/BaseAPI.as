package api
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class BaseAPI extends EventDispatcher
	{
		private const BASE_URL:String = "http://localhost/nailshopper/";
		private var loader:URLLoader;
		private var TIME_RELOAD:Number = 1000;

		private var urlRequest:URLRequest;
		private var timeoutReloadID:uint = 0;
		public function BaseAPI(_url:String,uv:URLVariables=null)
		{
			urlRequest = new URLRequest(BASE_URL+_url);
			urlRequest.data = uv;
		}
		
		public function load():void
		{
			trace("loading...");
			loader= new URLLoader(urlRequest);
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		public function unload():void
		{
			if(loader){
				loader.close();
				loader=null;
			}
			clearTimeout(timeoutReloadID);
		}
		
		private function loaderCompleteHandler(event:Event):void {
			
			try {
				var xml:XML = new XML(loader.data);
				loadedXMLComplete(xml);
				unload();
			} catch (e:TypeError) {
				trace("Could not parse the XML file.");
			}
		}
		
		protected function loadedXMLComplete(_xml:XML):void
		{
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		
		private function errorHandler(e:IOErrorEvent):void {
			trace("ioerror");
			timeoutReloadID = setTimeout(load,TIME_RELOAD);
		}
		
	}
}