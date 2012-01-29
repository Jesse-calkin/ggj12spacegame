package Game.FlxStates
{
	import org.flixel.*;
	
	import Game.FlxStates.MenuState;
	import Game.FlxStates.PlayState;
	import Game.Utility.*;
	
	public class EndGameState extends FlxState
	{
		private var tempSound:FlxSound;
		private var music:FlxSound;
		
		override public function create():void
		{
			Registry.endgameTheme = new FlxSound();
			Registry.endgameTheme.loadEmbedded(SoundFiles.gameOverSnd, true)
			Registry.endgameTheme.volume = 1;
			Registry.endgameTheme.play();
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			var title:FlxText;
			title = new FlxText(0, 8, FlxG.width, "Game Over");
			title.setFormat (null, 32, 0x00FF00, "center");
			add(title);
			
			var winnerSound:FlxSound;
			
			if (!Registry.player1Planet.alive)
			{
				var player2Win:FlxText;
				player2Win = new FlxText(0, 150, FlxG.width, "Orange Player Wins!!!");
				winnerSound = new FlxSound().loadEmbedded(SoundFiles.player1WinsSnd);
				player2Win.setFormat (null, 64, 0xFF6600, "center");
				add(player2Win);
				Registry.p2score += 1;
			}
			
			else if (!Registry.player2Planet.alive)
			{
				var player1Win:FlxText;
				player1Win = new FlxText(0, 150, FlxG.width, "Blue Player Wins!!!");
				winnerSound = new FlxSound().loadEmbedded(SoundFiles.player2WinsSnd);
				player1Win.setFormat (null, 64, 0x00CCFF, "center");
				add(player1Win);
				Registry.p1score += 1;
			}
			winnerSound.play();
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Return to Menu");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			var replaytext:FlxText;
			replaytext = new FlxText(0, FlxG.height - 22, FlxG.width, "Press R To Play Again");
			replaytext.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(replaytext);
			
			var p1scoreText:FlxText;
			p1scoreText = new FlxText(0, FlxG.height - 130, FlxG.width, Registry.p1score.toString());
			p1scoreText.setFormat (null, 120, 0x00CCFF, "left");
			add(p1scoreText);
			
			var p2scoreText:FlxText;
			p2scoreText = new FlxText(0, FlxG.height - 130, FlxG.width, Registry.p2score.toString());
			p2scoreText.setFormat (null, 120, 0xFF6600, "right");
			add(p2scoreText);
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER"))
			{
				tempSound = new FlxSound().loadEmbedded(SoundFiles.menuSelectSnd);
				tempSound.play();
				Registry.endgameTheme.stop();
				FlxG.switchState(new MenuState());
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				tempSound = new FlxSound().loadEmbedded(SoundFiles.menuSelectSnd);
				tempSound.play();
				Registry.endgameTheme.stop();
				Registry.backgroundtheme.play();
				FlxG.switchState(new PlayState());
			}
 
		} // end function update
 
		public function EndGameState()
		{
			super();
 
		}  // end function ControlsState
 
	} // end class
}// end package