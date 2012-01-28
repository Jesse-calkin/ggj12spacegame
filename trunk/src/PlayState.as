package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		[Embed(source = "../data/gfx/SpaceBackground.png")] public static var level1backgroundImg:Class;
		[Embed(source = "../data/gfx/RedPlanet.png")] public static var redPlanetImg:Class;
		[Embed(source = "../data/gfx/BluePlanet.png")] public static var bluePlanetImg:Class;
		
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			var background:FlxSprite = new FlxSprite(0, 0, level1backgroundImg);
			add(background);
			
			var bluePlanet:FlxSprite = new FlxSprite(200 - 75 / 2, (FlxG.height / 2) - 75 / 2, bluePlanetImg);
			add(bluePlanet);
			
			var redPlanet:FlxSprite = new FlxSprite(600 - 75 / 2 , (FlxG.height / 2) - 75 / 2, redPlanetImg);
			add(redPlanet);			
		}
		
		override public function update():void
		{
			super.update();
		}		
	}
}