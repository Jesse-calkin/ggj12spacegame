package
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import Weapons.RocketLauncher;
	
	public class PlayState extends FlxState
	{	
		//TODO: Move to player
		private var _rocketLauncher:RocketLauncher;
		public static var alienGroup:FlxGroup;
		
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
			
			Registry.player1Satellite = new SatelliteClass(1, 600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg)
			add(Registry.player1Satellite);
			
			Registry.player2Satellite = new SatelliteClass(2, 600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg)
			add(Registry.player2Satellite);
			
			//Should move this to player + allow switching weapons via powerups
			_rocketLauncher = new RocketLauncher(Registry.player1Satellite);
			add(_rocketLauncher.group);
			
			alienGroup = new FlxGroup(500);
			alienGroup.add(new AlienClass(1));
			alienGroup.add(new AlienClass(2));
			add(alienGroup);
		}
		
		override public function update():void
		{
			getInput();
			super.update();
		}	
		
		public function getInput():void //TODO: set up player 1 controls (WASD)
		{
			Registry.player1Satellite.velocity.x = 0;
			Registry.player1Satellite.velocity.y = 0;
			
			if (FlxG.keys.A)
			{
				Registry.player1Satellite.MoveClockwise();
			}
			
			if (FlxG.keys.D)
			{
				Registry.player1Satellite.MoveCounterclockwise();
			}
			
			if (FlxG.keys.RIGHT)
			{
				Registry.player2Satellite.MoveClockwise();
			}
			
			if (FlxG.keys.LEFT)
			{
				Registry.player2Satellite.MoveCounterclockwise();
			}
			
			if (FlxG.keys.justPressed("UP"))
			{
				_rocketLauncher.fireFromAngle(0); // pelt the orange planet...for now...
				//trace("Fire!");
			}
		}
		
		public function isGameOver():Boolean
		{
			return !(Registry.player1Planet.alive && Registry.player2Planet.alive);
		}
		
	}
}