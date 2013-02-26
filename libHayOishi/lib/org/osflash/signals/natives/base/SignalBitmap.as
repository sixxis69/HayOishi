package org.osflash.signals.natives.base
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.osflash.signals.natives.sets.DisplayObjectSignalSet;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class SignalBitmap extends Bitmap
	{

		private var _signals : DisplayObjectSignalSet;
		
		public function SignalBitmap(bitmapData:BitmapData,pixelSnapping:String="auto",smoothing:Boolean=false):void
		{
			super(bitmapData,pixelSnapping,smoothing);
		}

		public function get signals() : DisplayObjectSignalSet
		{
			return _signals ||= new DisplayObjectSignalSet(this);
		}
	}
}
