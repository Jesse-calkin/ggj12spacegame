package
{
	import org.flixel.*;
	//import Registry;
	
 
	public class PlayState extends FlxState
	{	


		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			Registry.player1Planet = new FlxSprite(200 - 55 / 2, (FlxG.height / 2) - 55 / 2, ImageFiles.bluePlanetImg);
			Registry.player1Planet.health = 100;
			add(Registry.player1Planet);
			
			Registry.player2Planet = new FlxSprite(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.orangePlanetImg);
			Registry.player2Planet.health = 100;
			add(Registry.player2Planet);
			
			Registry.Satellite = new SatelliteClass(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg)
			add(Registry.Satellite);
		}
		
		override public function update():void
		{

			getInput();
			super.update();
		}	
		
		public function getInput():void
		{
			if (FlxG.keys.RIGHT)
			{
				Registry.Satellite.degree -= Registry.Satellite.speed;
				Registry.Satellite.radian = (Registry.Satellite.degree/180)*Math.PI;
				Registry.Satellite.x = Registry.Satellite.xcenter+Math.cos(Registry.Satellite.radian)*Registry.Satellite.radius;
				Registry.Satellite.y = Registry.Satellite.ycenter-Math.sin(Registry.Satellite.radian)*Registry.Satellite.radius;
			}
			
			if (FlxG.keys.LEFT)
			{
				Registry.Satellite.degree += Registry.Satellite.speed;
				Registry.Satellite.radian = (Registry.Satellite.degree/180)*Math.PI;
				Registry.Satellite.x = Registry.Satellite.xcenter+Math.cos(Registry.Satellite.radian)*Registry.Satellite.radius;
				Registry.Satellite.y = Registry.Satellite.ycenter-Math.sin(Registry.Satellite.radian)*Registry.Satellite.radius;
			}
		}
	}
}