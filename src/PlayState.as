package
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import Powerups.MoveSpeed;
	import Powerups.Powerup;
	import Powerups.Shield;
	import Weapons.Rocket;
	
	public class PlayState extends FlxState
	{
		public static var alienGroup:FlxGroup;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			//FlxG.stream("../data/sounds/music/Theme.mp3", 0.5, true);
			
			Powerup.powerupsSpawned = 0;
			Powerup.alienKillGoal = FlxG.random() * 6 + 7;
			//trace(Powerup.alienKillGoal);
			
			var background:FlxSprite = new FlxSprite(0, 0, ImageFiles.level1backgroundImg);
			add(background);
			
			Registry.player1Planet = new FlxSprite(200 - 55 / 2, (FlxG.height / 2) - 55 / 2);
			Registry.player1Planet.loadGraphic(ImageFiles.bluePlanetImg, true, false, 55, 55);
			Registry.player1Planet.addAnimation("planet1", [0]);
			Registry.player1Planet.addAnimation("planet2", [1]);
			Registry.player1Planet.addAnimation("planet3", [2]);
			Registry.player1Planet.addAnimation("planet4", [3]);
			Registry.player1Planet.addAnimation("planet5", [4]);
			Registry.player1Planet.health = 100;
			add(Registry.player1Planet);
			
			Registry.player2Planet = new FlxSprite(600 - 55 / 2 , (FlxG.height / 2) - 55 / 2);
			Registry.player2Planet.loadGraphic(ImageFiles.orangePlanetImg, true, false, 55, 55);
			Registry.player2Planet.addAnimation("planet1", [0]);
			Registry.player2Planet.addAnimation("planet2", [1]);
			Registry.player2Planet.addAnimation("planet3", [2]);
			Registry.player2Planet.addAnimation("planet4", [3]);
			Registry.player2Planet.addAnimation("planet5", [4]);
			Registry.player2Planet.health = 100;
			add(Registry.player2Planet);
			
			Registry.player1Satellite = new SatelliteClass(1, 200 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg);
			add(Registry.player1Satellite);
			
			Registry.player2Satellite = new SatelliteClass(2, 600 - 55 / 2 , (FlxG.height / 2) - 55 / 2, ImageFiles.satelliteImg);
			add(Registry.player2Satellite);
			
			Registry.topShieldSpawner = powerupSpawnerSetup(true, new Shield());
			Registry.bottomShieldSpawner = powerupSpawnerSetup(true, new Shield());
			Registry.topMoveSpeedSpawner = powerupSpawnerSetup(true, new MoveSpeed());
			Registry.bottomMoveSpeedSpawner = powerupSpawnerSetup(true, new MoveSpeed());
			
			//var shieldParticleTop:Shield = new Shield();
			//var shieldParticleBottom:Shield = new Shield();
			//var moveSpeedParticleTop:MoveSpeed = new MoveSpeed();
			//var moveSpeedParticleBottom:MoveSpeed = new MoveSpeed();
			
			//Registry.topPowerUpSpawner = new FlxEmitter(FlxG.width / 2 - shieldParticleTop.width / 2, -shieldParticleTop.height, 2);
			//Registry.topPowerUpSpawner.setXSpeed(0, 0);
			//Registry.topPowerUpSpawner.setYSpeed(Powerup.POWERUP_SPEED * FlxG.elapsed, Powerup.POWERUP_SPEED * FlxG.elapsed);
			//Registry.topPowerUpSpawner.setRotation(0, 0);
			//Registry.topPowerUpSpawner.lifespan = 10;
			//shieldParticleTop.exists = false;
			//moveSpeedParticleTop.exists = false;
			//Registry.topPowerUpSpawner.add(shieldParticleTop);
			//Registry.topPowerUpSpawner.add(moveSpeedParticleTop);
			//
			//Registry.bottomPowerUpSpawner = new FlxEmitter(FlxG.width / 2 - shieldParticleBottom.width / 2, FlxG.height, 2);
			//Registry.bottomPowerUpSpawner.setXSpeed(0, 0);
			//Registry.bottomPowerUpSpawner.setYSpeed(-Powerup.POWERUP_SPEED * FlxG.elapsed, -Powerup.POWERUP_SPEED * FlxG.elapsed);
			//Registry.bottomPowerUpSpawner.setRotation(0, 0);
			//Registry.bottomPowerUpSpawner.lifespan = 10;
			//shieldParticleBottom.exists = false;
			//moveSpeedParticleBottom.exists = false;
			//Registry.bottomPowerUpSpawner.add(shieldParticleBottom);
			//Registry.bottomPowerUpSpawner.add(moveSpeedParticleBottom);
			
			add(Registry.topShieldSpawner);
			add(Registry.bottomShieldSpawner);
			add(Registry.topMoveSpeedSpawner);
			add(Registry.bottomMoveSpeedSpawner);
			Registry.spawnerGroup = new FlxGroup(4);
			Registry.spawnerGroup.add(Registry.topShieldSpawner);
			Registry.spawnerGroup.add(Registry.bottomShieldSpawner);			
			Registry.spawnerGroup.add(Registry.topMoveSpeedSpawner);
			Registry.spawnerGroup.add(Registry.bottomMoveSpeedSpawner);
			//Registry.topPowerUpSpawner.start();
			//Registry.bottomPowerUpSpawner.start();
			
			//Should move this to player + allow switching weapons via powerups
			//_rocketLauncher = new RocketLauncher(Registry.player1Satellite);
			//add(_rocketLauncher.group);
			add(Registry.player1Satellite._rocketLauncher.group);
			add(Registry.player2Satellite._rocketLauncher.group);
			
			alienGroup = new FlxGroup(100);
			//Registry.AlienPool = new FlxGroup();
			alienGroup.add(new AlienClass(1));
			alienGroup.add(new AlienClass(2));
			add(alienGroup);
			
			if (!(Registry.p1score == 0 && Registry.p2score == 0))
			{
				var p1scoreText:FlxText;
				p1scoreText = new FlxText(0, FlxG.height - 40, FlxG.width, Registry.p1score.toString());
				p1scoreText.setFormat (null, 32, 0x00CCFF, "left", 0xFFFFFFFF);
				add(p1scoreText);
				
				var p2scoreText:FlxText;
				p2scoreText = new FlxText(0, FlxG.height - 40, FlxG.width, Registry.p2score.toString());
				p2scoreText.setFormat (null, 32, 0xFF6600, "right", 0xFFFFFFFF);
				add(p2scoreText);
			}
		}
		
		private function powerupSpawnerSetup(top:Boolean, particle:FlxParticle):FlxEmitter
		{
			var spawner:FlxEmitter;
			if (top)
			{
				spawner = new FlxEmitter(FlxG.width / 2 - particle.width / 2, - particle.height, 1);
			}
			else
			{
				spawner = new FlxEmitter(FlxG.width / 2 - particle.width / 2, FlxG.height, 1);
			}

			spawner.setXSpeed(0, 0);
			var powerupSpeed:Number = (top ? Powerup.POWERUP_SPEED : -Powerup.POWERUP_SPEED) * FlxG.elapsed;
			spawner.setYSpeed(powerupSpeed, powerupSpeed);
			spawner.setRotation(0, 0);
			spawner.lifespan = 10;
			particle.exists = false;
			
			spawner.add(particle);
			return spawner;
		}
		
		override public function update():void
		{
			//Registry.player1Satellite.velocity.x = 0;
			//Registry.player1Satellite.velocity.y = 0;
			Registry.player1Satellite.angularAcceleration = 0;
			
			//Registry.player2Satellite.velocity.x = 0;
			//Registry.player2Satellite.velocity.y = 0;
			Registry.player2Satellite.angularAcceleration = 0;
			
			getInput();
			FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, alienGroup, AlienHit);
			FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, alienGroup, AlienHit);
			FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, Registry.spawnerGroup, PowerupHitByOne);
			FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, Registry.spawnerGroup, PowerupHitByTwo);
			//FlxG.overlap(Registry.player1Satellite._rocketLauncher.group, Registry.player2Planet, PlanetHit);
			//FlxG.overlap(Registry.player2Satellite._rocketLauncher.group, Registry.player1Planet, PlanetHit);
			
			if (isGameOver())
			{
				Registry.backgroundtheme.stop();
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
			
			if (FlxG.keys.W)
			{
				Registry.player1Satellite.Fire();
			}
			
			if (FlxG.keys.UP || FlxG.keys.NUMPADEIGHT)
			{
				Registry.player2Satellite.Fire();
			}
			
			if (Registry.player1Satellite.angularAcceleration == 0)
			{
				Registry.player1Satellite.idle();
			}
			
			if (Registry.player2Satellite.angularAcceleration == 0)
			{
				Registry.player2Satellite.idle();
			}
			
		}
		
		public function isGameOver():Boolean
		{
			return !(Registry.player1Planet.alive && Registry.player2Planet.alive);
		}
		
		public function AlienHit(bullet:Bullet, alien:AlienClass):void
		{
			var rocket:Rocket = Rocket(bullet);
			if (rocket != null)
			{
				alien.takeDamage(rocket.GetDmg());
			}
			else
			{
				alien.takeDamage(1);
			}
			bullet.kill();
		}
		
		public function PowerupHitByOne(rocket:Bullet, powerUp:Powerup):void
		{
			rocket.kill();
			powerUp.apply(Registry.player1Satellite);
		}
		
		public function PowerupHitByTwo(rocket:Bullet, powerUp:Powerup):void
		{
			rocket.kill();
			powerUp.apply(Registry.player2Satellite);
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
		public static function drawCircle(Sprite:FlxSprite, Center:FlxPoint, Radius:Number = 30, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void
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