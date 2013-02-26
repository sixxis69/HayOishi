package com.oishigroup
{
	import com.oishigroup.interactivemanager.MouseInteractManager;

	public class MainGameMobile extends MainGame
	{
		public function MainGameMobile()
		{
			super(new MouseInteractManager());
		}
	}
}