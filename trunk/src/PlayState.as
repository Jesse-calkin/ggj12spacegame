package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		[Embed(source = "../data/gfx/SpaceBackground.png")] public static var level1backgroundImg:Class;
		[Embed(source = "../data/gfx/OrangePlanet.png")] public static var orangePlanetImg:Class;
		[Embed(source = "../data/gfx/BluePlanet.png")] public static var bluePlanetImg:Class;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			var background:FlxSprite = new FlxSprite(0, 0, level1backgroundImg);
			add(background);
			
			Registry.player1Planet = new FlxSprite(200 - 55 / 2, (FlxG.height / 2) - 55 / 2, bluePlanetImg);
			Registry.player1health = 100;
			add(Registry.player1Planet);
			
			Registry.player2Planet = new FlxSprite(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, orangePlanetImg);
			Registry.player2health = 100;
			add(Registry.player2Planet);
		}
		
		override public function update():void
		{
			super.update();
		}		
	}
}