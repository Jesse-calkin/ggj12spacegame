package
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import Weapons.RocketLauncher;
	
	public class PlayState extends FlxState
	{	
		//TODO: Move to player
		private var _rocketLauncher:RocketLauncher;
		public static var _alienGroup:FlxGroup;
		
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
			
			//Should move this to player + allow switching weapons via powerups
			_rocketLauncher = new RocketLauncher(Registry.Satellite);
			add(_rocketLauncher.group);
			
			_alienGroup = new FlxGroup(500);
			_alienGroup.add(new AlienClass(1));
			_alienGroup.add(new AlienClass(2));
			add(_alienGroup);
		}
		
		override public function update():void
		{
			getInput();
			super.update();
		}	
		
		public function getInput():void //TODO: set up player 1 controls (WASD)
		{
			if (FlxG.keys.RIGHT)
			{
				Registry.Satellite.MoveClockwise();
			}
			
			if (FlxG.keys.LEFT)
			{
				Registry.Satellite.MoveCounterclockwise();
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				_rocketLauncher.fireFromAngle(0); // pelt the orange planet...for now...
				//trace("Fire!");
			}
		}
		
	}
}