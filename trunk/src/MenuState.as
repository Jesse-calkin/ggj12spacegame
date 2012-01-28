package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.spacesnakesTitleImg);
			add(background);
			
			var newgame:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameImg);
			add(newgame);
			
			var controls:FlxSprite = new FlxSprite(160, 230, ImageFiles.controlsImg);
			add(controls);
			
			var credits:FlxSprite = new FlxSprite(160, 298, ImageFiles.creditsImg);
			add(credits);
				


 
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Play");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
 
		} // end function create
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.switchState(new PlayState());
			}
 
		} // end function update
 
 
		public function MenuState()
		{
			super();
 
		}  // end function MenuState
 
	} // end class
}// end package