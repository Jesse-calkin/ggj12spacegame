package
{
	/**
	 * ...
	 * @author Brandon Davis
	 */
		
	import adobe.utils.CustomActions;
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
			
			var p1controltitle:FlxText;
			p1controltitle = new FlxText(0, 100, FlxG.width, "Blue Player:");
			p1controltitle.setFormat (null, 32, 0x00CCFF, "center");
			add(p1controltitle);
			
			var player1a:FlxText;
			player1a = new FlxText(0, 140, FlxG.width, "A: Rotate Left");
			player1a.setFormat (null, 16, 0x00CCFF, "center");
			add(player1a);
			
			var player1d:FlxText;
			player1d = new FlxText(0, 160, FlxG.width, "D: Rotate Right");
			player1d.setFormat (null, 16, 0x00CCFF, "center");
			add(player1d);
			
			var player1w:FlxText;
			player1w = new FlxText(0, 180, FlxG.width, "W: Fire");
			player1w.setFormat (null, 16, 0x00CCFF, "center");
			add(player1w);
			
			var p2controltitle:FlxText;
			p2controltitle = new FlxText(0, 225, FlxG.width, "Orange Player:");
			p2controltitle.setFormat (null, 32, 0xFF6600, "center");
			add(p2controltitle);

			var player2left:FlxText;
			player2left = new FlxText(0, 265, FlxG.width, "Left Arrow: Rotate Left");
			player2left.setFormat (null, 16, 0x00CCFF, "center");
			add(player2left);
			
			var player2right:FlxText;
			player2right = new FlxText(0, 285, FlxG.width, "Right Arrow: Rotate Right");
			player2right.setFormat (null, 16, 0x00CCFF, "center");
			add(player2right);
			
			var player2up:FlxText;
			player2up = new FlxText(0, 305, FlxG.width, "Up Arrow: Fire");
			player2up.setFormat (null, 16, 0x00CCFF, "center");
			add(player2up);
			

			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Return");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
		} // end function create
		
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
			
			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("ENTER"))
			{
				var temp:FlxSound;
				temp = new FlxSound().loadEmbedded(SoundFiles.menuSelectSnd);
				temp.play();
				FlxG.switchState(new MenuState());
			}
			
		} // end function update
		
		public function ControlsState()
		{
			super();
			
		}  // end function ControlsState
 
	} // end class
}// end package