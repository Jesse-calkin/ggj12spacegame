package Game.FlxStates
{
	import org.flixel.*;
	
	import Game.Utility.ImageFiles;
	import Game.Utility.SoundFiles;
	import Game.Utility.Registry;
	
	public class CreditsState extends FlxState
	{
		override public function create():void
		{
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			var title:FlxText;
			title = new FlxText(0, 8, FlxG.width, "Credits");
			title.setFormat (null, 32, Registry.menulightgreen, "center");
			add(title);
			//------------------------------------------------------------------------
			var art:FlxText;
			art = new FlxText(0, 50, FlxG.width, "Art:");
			art.setFormat (null, 24, Registry.menuRed, "center");
			add(art);
			
			var garuda:FlxText;
			garuda = new FlxText(0, 80, FlxG.width, "Garuda Illo");
			garuda.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(garuda);
			//------------------------------------------------------------------------
			var programming:FlxText;
			programming = new FlxText(0, 110, FlxG.width, "Programming:");
			programming.setFormat (null, 24, Registry.menuRed, "center");
			add(programming);
			
			var brandon:FlxText;
			brandon = new FlxText(0, 140, FlxG.width, "Brandon Davis");
			brandon.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(brandon);
			
			var caleb:FlxText;
			caleb = new FlxText(0, 160, FlxG.width, "Caleb Smith");
			caleb.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(caleb);
			
			var jay:FlxText;
			jay = new FlxText(0, 180, FlxG.width, "Jay Wagner");
			jay.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(jay);

			var lachlan:FlxText;
			lachlan = new FlxText(0, 200, FlxG.width, "Lachlan McInnes");
			lachlan.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(lachlan);
			//------------------------------------------------------------------------
			var planning:FlxText;
			planning = new FlxText(0, 230, FlxG.width, "Planning");
			planning.setFormat (null, 24, Registry.menuRed, "center");
			add(planning);		

			var jessie:FlxText;
			jessie = new FlxText(0, 260, FlxG.width, "Jesse Calkin");
			jessie.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(jessie);			
			//------------------------------------------------------------------------
			var sound:FlxText;
			sound = new FlxText(0, 290, FlxG.width, "Sound Engineering:");
			sound.setFormat (null, 24, Registry.menuRed, "center");
			add(sound);			
 
			var robert:FlxText;
			robert = new FlxText(0, 320, FlxG.width, "Robert Merritt");
			robert.setFormat (null, 16, Registry.menudarkgreen, "center");
			add(robert);
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press Space To Return");
			instructions.setFormat (null, 12, 0xFFFFFFFF, "center");
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
 
		public function CreditsState()
		{
			super();
 
		}  // end function CreditsState
 
	} // end class
}// end package