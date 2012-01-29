package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		private var newgamehighlighted:Boolean = true;
		private var controlshighlighted:Boolean = false;
		private var creditshighlighted:Boolean = false;
		private var menuCounter:int = 1;
				
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.spacesnakesTitleImg);
			add(background);
			
			

			var newgameSel:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameSelImg);
			add(newgameSel);
			var controls:FlxSprite = new FlxSprite(160, 230, ImageFiles.controlsImg);
			add(controls);
			var credits:FlxSprite = new FlxSprite(160, 298, ImageFiles.creditsImg);
			add(credits);
						
			var instructions:FlxText;
			
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Select");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
 
		} // end function create
 
 
		override public function update():void
		{
			getInput();
			
			super.update(); // calls update on everything you added to the game loop 
		} // end function update
 		
		private function getInput():void 
		{
			if (FlxG.keys.justPressed("DOWN"))
			{
				if (menuCounter > 0 && menuCounter < 4)
				{
					menuCounter += 1;
				}
				
				else
				{
					menuCounter = 1
				}
				
				changeMenuPic();
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				if (menuCounter > 0 && menuCounter < 4)
				{
					menuCounter -= 1;
				}
				
				else
				{
					menuCounter = 3
				}
				
				changeMenuPic();
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}
		}

		private function onFade():void
        {
			switch(menuCounter)
			{
				case 1:
					FlxG.switchState(new PlayState());
					break;
				case 2:
					FlxG.switchState(new ControlsState());
					break
				case 3:
					FlxG.switchState(new CreditsState());
			}		
        }
		
		public function changeMenuPic():void 
		{
			switch(menuCounter)
			{
				case 1:
					var newgameSel:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameSelImg);
					add(newgameSel);
					var controls:FlxSprite = new FlxSprite(160, 230, ImageFiles.controlsImg);
					add(controls);
					var credits:FlxSprite = new FlxSprite(160, 298, ImageFiles.creditsImg);
					add(credits);
					break;
				case 2:
					var newgame:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameImg);
					add(newgame);
					var controlsSel:FlxSprite = new FlxSprite(160, 230, ImageFiles.controlsSelImg);
					add(controlsSel);
					var credits:FlxSprite = new FlxSprite(160, 298, ImageFiles.creditsImg);
					add(credits);		
					break;
				case 3:
					var newgame:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameImg);
					add(newgame);
					var controls:FlxSprite = new FlxSprite(160, 230, ImageFiles.controlsImg);
					add(controls);
					var creditsSel:FlxSprite = new FlxSprite(160, 298, ImageFiles.creditsSelImg);
					add(creditsSel);	
					break;
			}

		}
		
		public function MenuState()
		{
			super();
		}  // end function MenuState
	} // end class
}// end package