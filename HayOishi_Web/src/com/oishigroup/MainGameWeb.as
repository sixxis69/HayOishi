package com.oishigroup
{
	import EXIT.starlingiso.interactcontroller.MouseInteractController;

	public class MainGameWeb extends MainGame
	{
		public function MainGameWeb()
		{
			super(new MouseInteractController());
		}
	}
}