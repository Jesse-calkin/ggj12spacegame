package
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import Powerups.Powerup;
	import Powerups.Shield;
	
	public class PlayState extends FlxState
	{	
		public static var alienGroup:FlxGroup;
		
		//private var testCircle:FlxSprite = new FlxSprite();
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			FlxG.stream("../data/sounds/music/Theme.mp3", 0.5, true);
			
			Powerup.powerupsSpawned = 0;
			Powerup.alienKillGoal = FlxG.random() * 6 + 7;
			trace(Powerup.alienKillGoal);
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			Registry.player1Planet = new FlxSprite(200 - 55 / 2, (FlxG.height / 2) - 55 / 2, ImageFiles.bluePlanetImg);
			Registry.player1Planet.health = 100;
			add(Registry.player1Planet);
			
			Registry.player2Planet = new FlxSprite(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.orangePlanetImg);
			Registry.player2Planet.health = 100;
			add(Registry.player2Planet);
			
			Registry.player1Satellite = new SatelliteClass(1, 200 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg)
			add(Registry.player1Satellite);
			
			Registry.player2Satellite = new SatelliteClass(2, 600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg)
			add(Registry.player2Satellite);
			
			var shieldParticle:Shield = new Shield();
			Registry.topPowerUpSpawner = new FlxEmitter(FlxG.width / 2 - shieldParticle.width / 2, -shieldParticle.height, 1);
			Registry.topPowerUpSpawner.setXSpeed(0, 0);
			Registry.topPowerUpSpawner.setYSpeed(Powerup.POWERUP_SPEED * FlxG.elapsed, Powerup.POWERUP_SPEED * FlxG.elapsed);
			Registry.topPowerUpSpawner.setRotation(0, 0);
			Registry.topPowerUpSpawner.add(new Shield());
			
			Registry.bottomPowerUpSpawner = new FlxEmitter(FlxG.width / 2 - shieldParticle.width / 2, FlxG.height, 1);
			Registry.bottomPowerUpSpawner.setXSpeed(0, 0);
			Registry.bottomPowerUpSpawner.setYSpeed(-Powerup.POWERUP_SPEED * FlxG.elapsed, -Powerup.POWERUP_SPEED * FlxG.elapsed);
			Registry.bottomPowerUpSpawner.setRotation(0, 0);
			Registry.bottomPowerUpSpawner.add(new Shield());
			
			add(Registry.topPowerUpSpawner);
			add(Registry.bottomPowerUpSpawner);
			//Registry.topPowerUpSpawner.start();
			//Registry.bottomPowerUpSpawner.start();
			
			//testCircle = new FlxSprite();
			//testCircle.makeGraphic(Registry.player1Satellite.radius, Registry.player1Satellite.radius, 0x00000000);
			//testCircle.x = Registry.player1Planet.x - 45 / 2;
			//testCircle.y = Registry.player1Planet.y - 45 / 2;
			//drawCircle(testCircle, new FlxPoint(testCircle.width / 2, testCircle.height / 2), Registry.player1Satellite.radius / 2, 0xff33ff33, 1, 0x4433ff33);
			//add(testCircle);
			
			//Should move this to player + allow switching weapons via powerups
			//_rocketLauncher = new RocketLauncher(Registry.player1Satellite);
			//add(_rocketLauncher.group);
			add(Registry.player1Satellite._rocketLauncher.group);
			add(Registry.player2Satellite._rocketLauncher.group);
			
			alienGroup = new FlxGroup(100);
			alienGroup.add(new AlienClass(1));
			alienGroup.add(new AlienClass(2));
			add(alienGroup);
			
			var p1scoreText:FlxText;
			p1scoreText = new FlxText(0, FlxG.height - 40, FlxG.width, Registry.p1score.toString());
			p1scoreText.setFormat (null, 32, 0x00CCFF, "left");
			add(p1scoreText);
			
			var p2scoreText:FlxText;
			p2scoreText = new FlxText(0, FlxG.height - 40, FlxG.width, Registry.p2score.toString());
			p2scoreText.setFormat (null, 32, 0xFF6600, "right");
			add(p2scoreText);
		}
		
		override public function update():void
		{
			Registry.player1Satellite.velocity.x = 0;
			Registry.player1Satellite.velocity.y = 0;
			Registry.player1Satellite.angularVelocity = 0;
			
			Registry.player2Satellite.velocity.x = 0;
			Registry.player2Satellite.velocity.y = 0;
			Registry.player2Satellite.angularVelocity = 0;
			
			getInput();
			FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, alienGroup, AlienHit);
			FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, alienGroup, AlienHit);		
			//FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, Registry.player2Planet, PlanetHit);
			//FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, Registry.player1Planet, PlanetHit);
			
			if (isGameOver())
			{
				FlxG.switchState(new EndGameState());
			}
			
			super.update();
		}	
		
		public function getInput():void
		{
			if (FlxG.keys.D)
			{
				Registry.player1Satellite.rotate(SatelliteClass.CLOCKWISE);
			}
			
			if (FlxG.keys.A)
			{
				Registry.player1Satellite.rotate(SatelliteClass.COUNTER_CLOCKWISE);
			}
			
			if (FlxG.keys.RIGHT || FlxG.keys.NUMPADSIX)
			{
				Registry.player2Satellite.rotate(SatelliteClass.CLOCKWISE);
			}
			
			if (FlxG.keys.LEFT || FlxG.keys.NUMPADFOUR)
			{
				Registry.player2Satellite.rotate(SatelliteClass.COUNTER_CLOCKWISE);
			}
			
			if (FlxG.keys.justPressed("W"))
			{
				Registry.player1Satellite.Fire();
			}
			
			if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("NUMPADEIGHT"))
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
		
		public function PlanetHit(rocket:Bullet, planet:FlxSprite):void
		{
			rocket.kill();
			planet.hurt(20);
		}
		
		/**
		 * Draw a circle to a sprite.
		 * 
		 * @param   Sprite          The FlxSprite to draw to 
		 * @param   Center          x,y coordinates of the circle's center 
		 * @param   Radius          Radius in pixels 
		 * @param   LineColor       Outline color
		 * @param   LineThickness   Outline thickness
		 * @param   FillColor       Fill color 
		 * */
		 public function drawCircle(Sprite:FlxSprite, Center:FlxPoint, Radius:Number = 30, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void
		 {
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
			
			// Line alpha
			var alphaComponent:Number = Number((LineColor >> 24) & 0xFF) / 255;
			if (alphaComponent <= 0)
				alphaComponent = 1;
			
			gfx.lineStyle(LineThickness, LineColor, alphaComponent);
			
			// Fill alpha
			alphaComponent = Number((FillColor >> 24) & 0xFF) / 255;
			if (alphaComponent <= 0)
				alphaComponent = 1;
			
			gfx.beginFill(FillColor & 0x00ffffff, alphaComponent);
			gfx.drawCircle(Center.x, Center.y, Radius);
			gfx.endFill(); 
			
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
		}
		
	}
}