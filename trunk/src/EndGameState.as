package
{
	import org.flixel.*;
 
	public class EndGameState extends FlxState
	{
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			var title:FlxText;
			title = new FlxText(0, 8, FlxG.width, "Game Over");
			title.setFormat (null, 32, 0x00FF00, "center");
			add(title);
			
			if (!Registry.player1Planet.alive)
			{
				var player2Win:FlxText;
				player2Win = new FlxText(0, 150, FlxG.width, "Orange Player Wins!!!");
				player2Win.setFormat (null, 64, 0x00FF00, "center");
				add(player2Win);
			}
			
			else if (!Registry.player2Planet.alive)
			{
				var player1Win:FlxText;
				player1Win = new FlxText(0, 150, FlxG.width, "Blue Player Wins!!!");
				player1Win.setFormat (null, 64, 0x00FF00, "center");
				add(player1Win);
			}


			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Play Again");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new MenuState());
			}
 
		} // end function update
 
 
		public function EndGameState()
		{
			super();
 
		}  // end function ControlsState
 
	} // end class
}// end package