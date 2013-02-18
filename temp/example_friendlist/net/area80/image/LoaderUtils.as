package net.area80.utils
{
	import flash.display.Loader;
	import flash.system.System;
	
	public class LoaderUtils
	{
		public function LoaderUtils()
		{
		}
		/**
		 * Clear loader
		 * @param ldr input loader
		 * 
		 */
		public static function clearLoader (ldr:Loader):void {
			if(ldr.parent && ldr.parent.contains(ldr)) {
				ldr.parent.removeChild(ldr);
			}
			try {
				ldr.close();
			} catch (e:Error) {}
			try {
				ldr.unload();
			} catch (e:Error) {}
			System.gc();
		}

	}
}