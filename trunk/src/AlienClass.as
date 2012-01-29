package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import Weapons.Rocket;
	import Weapons.VenomSpitter;
	import Powerups.Powerup;
	
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AlienClass extends FlxSprite
	{
		//Constants
		private const _Planet1XPos:uint = Registry.player1Planet.x + Registry.player1Planet.width/2;
		private const _Planet1YPos:uint = Registry.player1Planet.y + Registry.player1Planet.height/2;
		private const _Planet2XPos:uint = Registry.player2Planet.x + Registry.player2Planet.width/2;
		private const _Planet2YPos:uint = Registry.player2Planet.y + Registry.player2Planet.height/2;
		private const _StartingHealth:uint = 1;
		private const _OnDeathExtraSpawnPercent:uint = 25;
		private const _HoldingPositionX:int = 100;
		private const _HoldingPositionY:int = 100;
		private const _MinFireDelay:uint = 2;
		private const _MaxFireDelay:uint = 4;
		private const _SpawnDistanceFromScreenX:uint = 15;
		private const _SpawnDistanceFromScreenY:uint = 30;
		private const _PlanetEngagementRange:uint = 100;
		private const _AlienBulletDamageToPlanet:uint = 15;
		private const _AlienSpeedMultiplier:uint = 40;
		private const _AlienRotationSpeed:Number = 40;
		
		//Variables
		private var _targetPlayer:uint;
		private var _inRangeOfPlayer:Boolean;
		private var _fireDelayTimer:Number;
		private var _nextFireTime:Number;
		private var _clockwiseRotation:Boolean;
		private var _alienGun:VenomSpitter;
		private var _newMob:Boolean;
		private var warningImage:FlxSprite;
		public var isActive:Boolean;
		
		public function AlienClass(targetPlayer:uint = 0, newMob:Boolean = false)
		{
			warningImage = new FlxSprite( -50, -50, ImageFiles.enemyWarningImg);
			warningImage.alpha = 1;
			FlxG.state.add(warningImage);
			
			super(_HoldingPositionX, _HoldingPositionY, ImageFiles.snakeImg);
			
			_alienGun = new VenomSpitter(this);
			FlxG.state.add(_alienGun.group);
			
			_newMob = newMob;
			
			if (targetPlayer != 0)
			{
				activate(targetPlayer);
			}
			else
			{
				isActive = false;
			}
			
			loadGraphic(ImageFiles.snakeImg, true, false, 15, 30);
			addAnimation("Move", [0,1,2,3], 10);
			play("Move");
		}
		
		override public function update():void 
		{
			if (_newMob && (x > 0 && x < FlxG.width) && (y > 0 && y < FlxG.height))
			{
				_newMob = false;
				var alienSound:FlxSound = new FlxSound();
				alienSound.loadEmbedded(SoundFiles.alienSnd);
				alienSound.play();
			}
			
			if (isActive)
			{
				displayWarning();
				
				if (!_inRangeOfPlayer)
				{
					super.update();
					
					if (getDistanceToPlayer() < _PlanetEngagementRange)
					{
						_inRangeOfPlayer = true;
						velocity.x = 0;
						velocity.y = 0;
					}
				}
				else
				{
					rotateAroundPlanet();
					checkAttack();
				}
				
				draw();
			}
		}
		
		private function displayWarning():void
		{
			if ((x < 0 || x > FlxG.width) || (y < 0 || y > FlxG.height))
			{
				if (y < 0)
				{
					warningImage.y = 0 - warningImage.height / 2;
					warningImage.x = x - warningImage.width / 2;
				}
				else if (y > FlxG.height)
				{
					warningImage.y = FlxG.height - warningImage.height / 2;
					warningImage.x = x - warningImage.width / 2;
				}
				else if (x < 0)
				{
					warningImage.x = 0 - warningImage.width / 2;
					warningImage.y = y - warningImage.height / 2;
				}
				else if (x > FlxG.width)
				{
					warningImage.x = FlxG.width - warningImage.width / 2;
					warningImage.y = y + warningImage.height / 2;
				}
			}
			
			warningImage.alpha -= FlxG.elapsed / 3;
		}
		
		private function rotateAroundPlanet():void
		{
			var distanceToPlayer:Number = getDistanceToPlayer();
			
			var myPosition:FlxPoint = new FlxPoint(x, y);
			var planetPosition:FlxPoint = new FlxPoint(getPlanetXPosition(), getPlanetYPosition());
			var degreesAngle:Number = FlxU.getAngle(myPosition, planetPosition);
			var radianAngle:Number = (degreesAngle / 180) * Math.PI;
			
			angle = degreesAngle;
			
			if (_clockwiseRotation)
			{
				x += Math.cos(radianAngle) * FlxG.elapsed * _AlienRotationSpeed;
				y += Math.sin(radianAngle) * FlxG.elapsed * _AlienRotationSpeed;
			}
			else
			{
				x -= Math.cos(radianAngle) * FlxG.elapsed * _AlienRotationSpeed;
				y -= Math.sin(radianAngle) * FlxG.elapsed * _AlienRotationSpeed;
			}
		}
		
		private function checkAttack():void
		{
			_fireDelayTimer += FlxG.elapsed;
			
			if (_fireDelayTimer >= _nextFireTime)
			{
				fireShot();
				_fireDelayTimer = 0.0;
				setNextFireTime();
			}
			
			checkBulletCollision();
		}
		
		private function fireShot():void
		{
			if (Registry.player1Planet.alive && Registry.player2Planet.alive)
			{
				_alienGun.fireAtTarget(new FlxSprite(getPlanetXPosition(), getPlanetYPosition()));
				_alienGun.currentBullet.angle = angle;
				_alienGun.currentBullet.revive();
			}
		}
		
		private function checkBulletCollision():void
		{
			if (_alienGun.currentBullet != null && _alienGun.currentBullet.alive)
			{
				var tempXDifference:uint = 0;
				var tempYDifference:uint = 0;
				
				if (_alienGun.currentBullet.x < getPlanetXPosition())
				{
					tempXDifference = getPlanetXPosition() - _alienGun.currentBullet.x;
				}
				else if (_alienGun.currentBullet.x > getPlanetXPosition())
				{
					tempXDifference = _alienGun.currentBullet.x - getPlanetXPosition();
				}
				
				if (_alienGun.currentBullet.y < getPlanetYPosition())
				{
					tempYDifference = getPlanetYPosition() - _alienGun.currentBullet.y;
				}
				else if (_alienGun.currentBullet.y > getPlanetYPosition())
				{
					tempYDifference = _alienGun.currentBullet.y - getPlanetYPosition();
				}
				
				if (Registry.player1Satellite.powerupTime > 0 && _targetPlayer == 1)
				{
					if (Math.sqrt((tempXDifference * tempXDifference) + (tempYDifference * tempYDifference)) < 55)
					{
						_alienGun.currentBullet.kill();
						
						Registry.player1Satellite.shieldSprite.exists = false;
						Registry.player1Satellite.powerupTime = 0;
					}
				}
				else if (Registry.player2Satellite.powerupTime > 0 && _targetPlayer == 2)
				{
					if (Math.sqrt((tempXDifference * tempXDifference) + (tempYDifference * tempYDifference)) < 55)
					{
						_alienGun.currentBullet.kill();
						
						Registry.player2Satellite.shieldSprite.exists = false;
						Registry.player2Satellite.powerupTime = 0;
					}
				}
				else if (Math.sqrt((tempXDifference * tempXDifference) + (tempYDifference * tempYDifference)) < 30)
				{
					var temp:FlxSound;
					temp = new FlxSound().loadEmbedded(SoundFiles.asteroidExplosionSnd);
					temp.play();
					switch(_targetPlayer)
					{
					case 1:
						Registry.player1Planet.health -= _AlienBulletDamageToPlanet;
						var health1:Number = Registry.player1Planet.health;
						
						if (health1 >= 80 && health1 < 100)
						{
							Registry.player1Planet.play("planet2");
						}
						else if (health1 >= 60 && health1 < 80)
						{
							Registry.player1Planet.play("planet3");
						}
						else if (health1 >= 40 && health1 < 60)
						{
							Registry.player1Planet.play("planet4");
						}
						else if (health1 >= 20 && health1 < 40)
						{
							Registry.player1Planet.play("planet5");
						}
						
						Registry.player1Planet.flicker(0.2);
						FlxG.shake(0.01, 0.2);
						if (Registry.player1Planet.health <= 0 && Registry.player2Planet.alive)
						{
							Registry.player1Planet.kill();
						}
						break;
					case 2:
						Registry.player2Planet.health -= _AlienBulletDamageToPlanet;
						var health2:Number = Registry.player2Planet.health;
						if (health2 >= 80 && health2 < 100)
						{
							Registry.player2Planet.play("planet2");
						}
						else if (health2 >= 60 && health2 < 80)
						{
							Registry.player2Planet.play("planet3");
						}
						else if (health2 >= 40 && health2 < 60)
						{
							Registry.player2Planet.play("planet4");
						}
						else if (health2 >= 20 && health2 < 40)
						{
							Registry.player2Planet.play("planet5");
						}
						
						Registry.player2Planet.flicker(0.2);
						FlxG.shake(0.01, 0.2);
						if (Registry.player2Planet.health <= 0 && Registry.player1Planet.alive)
						{
							Registry.player2Planet.kill();
						}
						break;
					}
					_alienGun.currentBullet.kill();
				}
			}
		}
		
		public function takeDamage(damage:Number):void
		{
			health -= damage;
			
			if (health <= 0)
			{
				if (--Powerup.alienKillGoal <= 0)
				{
					Powerup.powerupsSpawned++;
					Powerup.alienKillGoal = FlxG.random() * 6 + 7 + Powerup.powerupsSpawned * 3;
					//trace(Powerup.alienKillGoal);
					
					if (FlxG.random() < .5)
					{
						switch (int(FlxG.random() * 2))
						{
							case 0:
								Registry.topShieldSpawner.emitParticle();
								break;
							case 1:
								Registry.topMoveSpeedSpawner.emitParticle();
								break;
							default:
								trace("Bad spawner number.");
								break;
						}
					}
					else
					{
						switch (int(FlxG.random() * 2))
						{
							case 0:
								Registry.bottomShieldSpawner.emitParticle();
								break;
							case 1:
								Registry.bottomMoveSpeedSpawner.emitParticle();
								break;
							default:
								trace("Bad spawner number.");
								break;
						}
					} 
				}
				
				//spawn aliens on enemy
				if (FlxG.random() > ((100 - _OnDeathExtraSpawnPercent) / 100))
				{
					PlayState.alienGroup.add(new AlienClass(getNontargetPlayer(), true));
				}
				else
				{
					var alienDeathSound:FlxSound = new FlxSound();
					alienDeathSound.loadEmbedded(SoundFiles.alienDeathSnd);
					alienDeathSound.play();
				}
				
				//kill alien
				if (_alienGun.currentBullet != null)
				{
					_alienGun.currentBullet.kill();
				}
				activate(getNontargetPlayer());
			}
		}
		
		private function setSpawnPoint():void
		{
			switch (_targetPlayer)
			{
			case 1: //left side
				switch(((int)(FlxG.random() * 2.999 + 0.00001)) + 1)
				{
				case 1:
					x = FlxG.random() * 200 * 2;
					y = -_SpawnDistanceFromScreenY;
					break;
				case 2:
					x = -_SpawnDistanceFromScreenX;
					y = FlxG.random() * 200 * 2;
					break;
				case 3:
					x = FlxG.random() * 200 * 2;
					y = FlxG.height + _SpawnDistanceFromScreenY;
					break;
				default:
					FlxG.log("Random Side Selector Error.");
					break;
				}
				break;
			case 2: //right side
				switch(((int)(FlxG.random() * 2.999 + 0.00001)) + 1)
				{
				case 1:
					x = FlxG.random() * 200 * 2 + 400;
					y = -_SpawnDistanceFromScreenY;
					break;
				case 2:
					x = FlxG.width + _SpawnDistanceFromScreenX;
					y = FlxG.random() * 200 * 2;
					break;
				case 3:
					x = FlxG.random() * 200 * 2 + 400;
					y = FlxG.height + _SpawnDistanceFromScreenY;
					break;
				default:
					FlxG.log("Random Side Selector Error.");
					break;
				}
				break;
			default:
				FlxG.log("Target Player Assignment Error");
				break;
			}
			
			//if ((x > getPlanetXPosition() && y < getPlanetYPosition()) || (x < getPlanetXPosition() && y > getPlanetYPosition()))
			//{
				//_clockwiseRotation = false;
			//}
		}
		
		private function assignVelocities():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			var tempXDifference:uint = 0;
			var tempYDifference:uint = 0;
			
			if (x < getPlanetXPosition())
			{
				tempXDifference = getPlanetXPosition() - x;
			}
			else if (x > getPlanetXPosition())
			{
				tempXDifference = x - getPlanetXPosition();
			}
			
			if (y < getPlanetYPosition())
			{
				tempYDifference = getPlanetYPosition() - y;
			}
			
			else if (y > getPlanetYPosition())
			{
				tempYDifference = y - getPlanetYPosition();
			}
			
			var tempAngle:Number = Math.atan2(tempYDifference, tempXDifference);
			
			velocity.y = Math.sin(tempAngle) * _AlienSpeedMultiplier;
			velocity.x = Math.cos(tempAngle) * _AlienSpeedMultiplier;
			
			if (x > getPlanetXPosition())
			{
				velocity.x *= -1;
			}
			if (y > getPlanetYPosition())
			{
				velocity.y *= -1;
			}
			
			angle = FlxU.getAngle(new FlxPoint(x, y), new FlxPoint(getPlanetXPosition(), getPlanetYPosition()));
		}
		
		public function activate(targetPlayer:uint, newMob:Boolean = false):void
		{
			isActive = true;
			health = _StartingHealth;
			_targetPlayer = targetPlayer;
			setSpawnPoint();
			assignVelocities();
			_inRangeOfPlayer = false;
			_fireDelayTimer = 0.0;
			setNextFireTime();
			_clockwiseRotation = FlxG.random() < .5;
			if (_alienGun.currentBullet != null)
			{
				_alienGun.currentBullet.reset(x, y);
			}
			warningImage.alpha = 1;
		}
		
		private function getDistanceToPlayer():Number
		{
			var tempXDifference:uint = 0;
			var tempYDifference:uint = 0;
			
			if (x < getPlanetXPosition())
			{
				tempXDifference = getPlanetXPosition() - x;
			}
			else if (x > getPlanetXPosition())
			{
				tempXDifference = x - getPlanetXPosition();
			}
			
			if (y < getPlanetYPosition())
			{
				tempYDifference = getPlanetYPosition() - y;
			}
			else if (y > getPlanetYPosition())
			{
				tempYDifference = y - getPlanetYPosition();
			}
			
			return Math.sqrt((tempXDifference * tempXDifference) + (tempYDifference * tempYDifference));
		}
		
		private function getPlanetXPosition():uint
		{
			switch(_targetPlayer)
			{
			case 1:
				return _Planet1XPos;
				break;
			case 2:
				return _Planet2XPos;
				break;
			default:
				FlxG.log("Target Player Assignment Error");
				break;
			}
			return 0;
		}
		
		private function getPlanetYPosition():uint
		{
			switch(_targetPlayer)
			{
			case 1:
				return _Planet1YPos;
				break;
			case 2:
				return _Planet2YPos;
				break;
			default:
				FlxG.log("Target Player Assignment Error");
				break;
			}
			return 0;
		}
		
		private function setNextFireTime():void
		{
			_nextFireTime = (FlxG.random() * Math.abs(_MaxFireDelay - _MinFireDelay) + _MinFireDelay);
		}
		
		public function getTargetPlayer():uint
		{
			return _targetPlayer;
		}
		
		private function getNontargetPlayer():uint
		{
			switch(_targetPlayer)
			{
			case 1:
				return 2;
				break;
			case 2:
				return 1;
				break;
			}
			return 0;
		}
		
	}

}