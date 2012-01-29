package
{
	import org.flixel.*;
 
	public class ControlsState extends FlxState
	{
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			var title:FlxText;
			title = new FlxText(0, 8, FlxG.width, "Controls");
			title.setFormat (null, 32, 0x00FF00, "center");
			add(title);


			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Return");
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
 
 
		public function ControlsState()
		{
			super();
 
		}  // end function ControlsState
 
	} // end class
}// end package