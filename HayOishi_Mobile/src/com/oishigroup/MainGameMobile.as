package com.oishigroup
{
	import EXIT.starlingiso.interactcontroller.MouseInteractController;

	public class MainGameMobile extends MainGame
	{
		public function MainGameMobile()
		{
			super(new MouseInteractController());
		}
	}
}