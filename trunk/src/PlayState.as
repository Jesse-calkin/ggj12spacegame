package
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayState extends FlxState
	{	
		public static var alienGroup:FlxGroup;		
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			FlxG.stream("../data/sounds/music/Theme.mp3",0.5,true);
			
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
			
			add(Registry.player1Satellite._rocketLauncher.group);
			add(Registry.player2Satellite._rocketLauncher.group);
			
			alienGroup = new FlxGroup(100);
			alienGroup.add(new AlienClass(1));
			alienGroup.add(new AlienClass(2));
			add(alienGroup);
		}
		
		override public function update():void
		{
			FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, alienGroup, AlienHit);
			FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, alienGroup, AlienHit);		
			
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
			
			if (FlxG.keys.W)
			{
				Registry.player1Satellite.Fire();
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
				Registry.player2Satellite.Fire();
			}
			
		}
		
		public function isGameOver():Boolean
		{
			return !(Registry.player1Planet.alive && Registry.player2Planet.alive);
		}
		
		public function AlienHit(rocket:Bullet, alien:AlienClass):void
		{
			//TODO: Add dmg to bullets instead of kills.
			rocket.kill();
			//TODO: Switch hard coded dmg with bullet dmg.
			alien.takeDamage(1); 
		}
	}
}