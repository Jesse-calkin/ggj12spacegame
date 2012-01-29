package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		private var newgamehighlighted:Boolean = true;
		private var controlshighlighted:Boolean = false;
		private var creditshighlighted:Boolean = false;
		private var menuCounter:int = 1;
		
		private var newgame:FlxSprite;
		private var controls:FlxSprite;
		private var credits:FlxSprite;
		private var tempSound:FlxSound;
				
		override public function create():void
		{
			FlxG.stream("../data/sounds/music/Theme.mp3", 0.5, true);
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.spacesnakesTitleImg);
			add(background);

			newgame = new FlxSprite(160, 162, ImageFiles.newgameSelImg);
			add(newgame);
			controls = new FlxSprite(160, 230, ImageFiles.controlsImg);
			add(controls);
			credits = new FlxSprite(160, 298, ImageFiles.creditsImg);
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
				if (menuCounter > 0 && menuCounter <= 2)
				{
					tempSound = new FlxSound().loadEmbedded(SoundFiles.menuMoveSnd);
					tempSound.play();
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
				if (menuCounter > 1 && menuCounter <= 3)
				{
					tempSound = new FlxSound().loadEmbedded(SoundFiles.menuMoveSnd);
					tempSound.play();
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
				tempSound = new FlxSound().loadEmbedded(SoundFiles.menuSelectSnd);
				tempSound.play();
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
					newgame.loadGraphic(ImageFiles.newgameSelImg)
					controls.loadGraphic(ImageFiles.controlsImg)
					credits.loadGraphic(ImageFiles.creditsImg)
					break;
				case 2:	
					newgame.loadGraphic(ImageFiles.newgameImg)
					controls.loadGraphic(ImageFiles.controlsSelImg)
					credits.loadGraphic(ImageFiles.creditsImg)
					break;
				case 3:
					newgame.loadGraphic(ImageFiles.newgameImg)
					controls.loadGraphic(ImageFiles.controlsImg)
					credits.loadGraphic(ImageFiles.creditsSelImg)
					break;
			}
		}
		
		public function MenuState()
		{
			super();
		}  // end function MenuState
	} // end class
}// end package