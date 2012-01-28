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
			
			var bluePlanet:FlxSprite = new FlxSprite(200 - 55 / 2, (FlxG.height / 2) - 55 / 2, bluePlanetImg);
			add(bluePlanet);
			
			var orangePlanet:FlxSprite = new FlxSprite(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, orangePlanetImg);
			add(orangePlanet);
		}
		
		override public function update():void
		{
			super.update();
		}		
	}
}