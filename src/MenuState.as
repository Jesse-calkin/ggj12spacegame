package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		private var newgamehighlighted:Boolean = true;
		private var controlshighlighted:Boolean = false;
		private var creditshighlighted:Boolean = false;
		
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.spacesnakesTitleImg);
			add(background);
			var newgameSel:FlxSprite = new FlxSprite(160, 162, ImageFiles.newgameSelImg);
			add(newgameSel);
			var controls:FlxSprite = new FlxSprite(160, 162, ImageFiles.controlsImg);
			add(controls);
			var credits:FlxSprite = new FlxSprite(160, 162, ImageFiles.creditsImg);
			add(credits);
			
			loadMenuPics();
				
			var instructions:FlxText;
			
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Select");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
 
		} // end function create
 
 
		override public function update():void
		{
			getInput();
			loadMenuPics();
			super.update(); // calls update on everything you added to the game loop 
 
		} // end function update
 
		private function onFade():void
        {
            FlxG.switchState(new PlayState());
        }
		
		public function MenuState()
		{
			super();
		}  // end function MenuState
 
		public function loadMenuPics():void
		{
			if (newgamehighlighted = true)
			{

			}
			
			if (newgamehighlighted = false)
			{

			}
			
			if (controlshighlighted = true)
			{

			}
			
			if (controlshighlighted = false)
			{

			}
			
			if (creditshighlighted = true)
			{

			}
			
			if (creditshighlighted = false)
			{

			}
		}
		
		private function getInput():void
		{
			if (FlxG.keys.justPressed("UP"))
			{
				if (newgamehighlighted = true)
				{
					newgamehighlighted = false
					creditshighlighted = true
				}
				
				else if (creditshighlighted = true)
				{
					creditshighlighted = false
					controlshighlighted = true
				}
				
				else if (controlshighlighted = true)
				{
					controlshighlighted = false
					newgamehighlighted = true
				}
			}
			
			if (FlxG.keys.justPressed("DOWN"))
			{
				if (newgamehighlighted = true)
				{
					newgamehighlighted = false
					controlshighlighted = true
				}
				
				else if (controlshighlighted = true)
				{
					controlshighlighted = false
					creditshighlighted = true
				}
				
				else if (creditshighlighted = true)
				{
					creditshighlighted = false
					newgamehighlighted = true
				}
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.flash(0xffffffff, 0.75);
                FlxG.fade(0xff000000, 1, onFade);
			}
			
		}
	} // end class
}// end package