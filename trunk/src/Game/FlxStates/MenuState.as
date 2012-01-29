package Game.FlxStates
{
	import org.flixel.*;
	
	import Game.Utility.ImageFiles;
	import Game.Utility.Registry;
	import Game.Utility.SoundFiles;
	
	public class MenuState extends FlxState
	{
		private var newgamehighlighted:Boolean = true;
		private var controlshighlighted:Boolean = false;
		private var creditshighlighted:Boolean = false;
		private var menuCounter:int = 1;
		private var advisoryText:FlxText;
		
		private var newgame:FlxSprite;
		private var controls:FlxSprite;
		private var credits:FlxSprite;
		private var tempSound:FlxSound;
		
		override public function create():void
		{
			Registry.p1score = 0;
			Registry.p2score = 0;

			Registry.backgroundtheme = new FlxSound();
			Registry.backgroundtheme.loadEmbedded(SoundFiles.themeSnd, true)
			Registry.backgroundtheme.volume = .5;
			Registry.backgroundtheme.play();
			
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.spacesnakesTitleImg);
			add(background);
			
			newgame = new FlxSprite(160, 162, ImageFiles.newgameSelImg);
			add(newgame);
			controls = new FlxSprite(160, 230, ImageFiles.controlsImg);
			add(controls);
			credits = new FlxSprite(160, 298, ImageFiles.creditsImg);
			add(credits);
			
			Registry.leftsnakeWiggle = new FlxSprite(120, FlxG.height - 100, ImageFiles.snakeImg); 
			Registry.leftsnakeWiggle.loadGraphic(ImageFiles.snakeImg, true, false, 15, 30);
			Registry.leftsnakeWiggle.addAnimation("LeftWiggle", [0, 1, 2, 3], 10);
			Registry.leftsnakeWiggle.scale.x = 3;
			Registry.leftsnakeWiggle.scale.y = 3;
			add(Registry.leftsnakeWiggle);
			Registry.leftsnakeWiggle.play("LeftWiggle");
			
			Registry.rightsnakeWiggle = new FlxSprite(FlxG.width - 135, FlxG.height - 100, ImageFiles.snakeImg); 
			Registry.rightsnakeWiggle.loadGraphic(ImageFiles.snakeImg, true, false, 15, 30);
			Registry.rightsnakeWiggle.addAnimation("RightWiggle", [0, 1, 2, 3], 10);
			Registry.rightsnakeWiggle.scale.x = 3;
			Registry.rightsnakeWiggle.scale.y = 3;
			add(Registry.rightsnakeWiggle);
			Registry.rightsnakeWiggle.play("RightWiggle");
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Select");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			advisoryText = new FlxText(0, 140, FlxG.width, "(2 Player Game)");
			advisoryText.setFormat(null, 20, 0xffffff, "center");
			add(advisoryText);
			
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
			
			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER"))
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