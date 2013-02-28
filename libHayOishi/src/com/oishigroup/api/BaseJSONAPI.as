package com.oishigroup.api
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;

	public class BaseJSONAPI
	{
		public var signalComplete:Signal = new Signal(Object);
		public var signalError:Signal = new Signal();

		private var urlLoader:URLLoader;
		private var refreshTimeout:uint = 0;

		private var urlRequest:URLRequest;
		private var url:String;
		private var autoRefresh:Boolean;

		private var _rawData:*;

		public function BaseJSONAPI(_url:String, js:Object = null, _autoRefresh:Boolean = true)
		{
			
			var msg:String = JSON.stringify(js);
			var uv:URLVariables = new URLVariables();
			uv.msg = msg;
			
			url = _url;
			urlRequest = new URLRequest(_url);
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = uv;
			autoRefresh = _autoRefresh;
		}

		public function load():void
		{
			urlLoader = new URLLoader(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}

		public function unload():void
		{
			urlLoader.close();
			if (urlLoader) {
				clearTimeout(refreshTimeout);
				try {
					urlLoader.close();
				} catch (e:Error) {

				}
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				urlLoader.removeEventListener(Event.COMPLETE, onComplete);
				urlLoader = null;
				signalComplete.removeAll();
			}
		}

		public function rawData():*
		{
			return _rawData;
		}

		protected function onComplete(event:Event):void
		{
			_rawData = event.target.data;
			
			var json:* = JSON.parse(_rawData);
			
			signalComplete.dispatch(json);
		}

		protected function onError(event:IOErrorEvent):void
		{
			trace(" IO_ERROR ::", url);
			unload();
			signalError.dispatch();
			if (autoRefresh) {
				refreshTimeout = setTimeout(load, 2000);
			}
		}
	}
}
