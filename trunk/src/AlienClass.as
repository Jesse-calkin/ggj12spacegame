package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import Weapons.Rocket;
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
		private const _OnDeathExtraSpawnPercent:uint = 10;
		private const _HoldingPositionX:int = 100;
		private const _HoldingPositionY:int = 100;
		private const _MinFireDelay:uint = 2;
		private const _MaxFireDelay:uint = 4;
		private const _SpawnDistanceFromScreen:uint = 50;
		private const _SpawnDistanceFromScreenX:uint = 15;
		private const _SpawnDistanceFromScreenY:uint = 30;
		private const _PlanetEngagementRange:uint = 100;
		private const _AlienBulletDamageToPlanet:uint = 20;
		private const _AlienSpeedMultiplier:uint = 50;
		
		//Variables
		private var _targetPlayer:uint;
		private var _inRangeOfPlayer:Boolean;
		private var _fireDelayTimer:Number;
		private var _nextFireTime:Number;
		private var _clockwiseRotation:Boolean;
		private var _alienGun:FlxWeapon;
		public var isActive:Boolean;
		
		public function AlienClass(targetPlayer:uint = 0)
		{
			super(_HoldingPositionX, _HoldingPositionY, ImageFiles.snakeImg);
			
			_alienGun = new FlxWeapon("alienGun", this);
			_alienGun.makeImageBullet(1, Rocket, ImageFiles.rocketImg); //<----------------------------TODO: change to use alien bullet art
			_alienGun.setBulletSpeed(120);
			_alienGun.setBulletAcceleration(10, 10, 130, 130);
			_alienGun.setBulletBounds(new FlxRect(0, 0, FlxG.width, FlxG.height));
			FlxG.state.add(_alienGun.group);
			
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
			if (isActive)
			{
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
					//TODO: CHANGE! Put straifing and fireing AI here
					//takeDamage(1); //testing only
					
					inRangeCombatAI();  //<------------------------------------------------------------------<
				}
				
				draw();
			}
		}
		
		private function inRangeCombatAI():void
		{
			combatMove();
			checkAttack();
		}
		
		private function combatMove():void
		{
			
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
				
				if (Math.sqrt((tempXDifference * tempXDifference) + (tempYDifference * tempYDifference)) < 30)
				{
					switch(_targetPlayer)
					{
					case 1:
						Registry.player1Planet.health -= _AlienBulletDamageToPlanet;
						if (Registry.player1Planet.health <= 0 && Registry.player2Planet.alive)
						{
							Registry.player1Planet.kill();
						}
						break;
					case 2:
						Registry.player2Planet.health -= _AlienBulletDamageToPlanet;
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
				//spawn aliens on enemy
				if (FlxG.random() > ((100 - _OnDeathExtraSpawnPercent) / 100))
				{
					PlayState.alienGroup.add(new AlienClass(getNontargetPlayer()));
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
			
			if ((x > getPlanetXPosition() && y < getPlanetYPosition()) || (x < getPlanetXPosition() && y > getPlanetYPosition()))
			{
				_clockwiseRotation = false;
			}
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
		
		public function activate(targetPlayer:uint):void
		{
			isActive = true;
			health = _StartingHealth;
			_targetPlayer = targetPlayer;
			setSpawnPoint();
			assignVelocities();
			_inRangeOfPlayer = false;
			_fireDelayTimer = 0.0;
			setNextFireTime();
			_clockwiseRotation = true;
			if (_alienGun.currentBullet != null)
			{
				_alienGun.currentBullet.revive();
			}
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