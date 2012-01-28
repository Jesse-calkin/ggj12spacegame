package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AlienClass extends FlxSprite
	{
		private const _TEMPSPEED:uint = 1;
		
		//Constants
		private const _Planet1XPos:uint = Registry.player1Planet.x + Registry.player1Planet.width/2;
		private const _Planet1YPos:uint = Registry.player1Planet.y + Registry.player1Planet.height/2;
		private const _Planet2XPos:uint = Registry.player2Planet.x + Registry.player2Planet.width/2;
		private const _Planet2YPos:uint = Registry.player2Planet.y + Registry.player2Planet.height/2;
		private const _StartingHealth:uint = 1;
		private const _OnDeathExtraSpawnPercent:uint = 20;
		private const _HoldingPositionX:int = 100;
		private const _HoldingPositionY:int = 100;
		private const _MinFireDelay:uint = 2;
		private const _MaxFireDelay:uint = 4;
		private const _SpawnDistanceFromScreen:uint = 50;
		private const _SpawnDistanceFromScreenX:uint = 15;
		private const _SpawnDistanceFromScreenY:uint = 30;
		private const _PlanetEngagementRange:uint = 100;
		
		//Variables
		private var _targetPlayer:uint;
		private var _inRangeOfPlayer:Boolean;
		private var _fireDelayTimer:Number;
		private var _nextFireTime:Number;
		private var _clockwiseRotation:Boolean;
		public var isActive:Boolean;
		
		public function AlienClass(targetPlayer:uint = 0)
		{
			super(_HoldingPositionX, _HoldingPositionY, ImageFiles.snakeImg);
			
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
					moveIntoRange();
					
					if (getDistanceToPlayer() < _PlanetEngagementRange)
					{
						_inRangeOfPlayer = true;
					}
				}
				else
				{
					//TODO: CHANGE! Put straifing and fireing AI here
					takeDamage(1); //testing only
					
					//inRangeCombatAI();  //<------------------------------------------------------------------<
				}
				
				//draw();
			}
			draw();
		}
		
		private function moveIntoRange():void
		{
			//TODO: re-write move AI Code  //<-------------------------------------------------------------<
			if (x < getPlanetXPosition())
			{
				x += _TEMPSPEED;
			}
			else if (x > getPlanetXPosition())
			{
				x -= _TEMPSPEED;
			}
			
			if (y < getPlanetYPosition())
			{
				y += _TEMPSPEED;
			}
			else if (y > getPlanetYPosition())
			{
				y -= _TEMPSPEED;
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
		}
		
		private function fireShot():void
		{
			
		}
		
		public function takeDamage(damage:Number):void
		{
			health -= damage;
			
			if (health <= 0)
			{
				//spawn aliens on enemy
				if (FlxG.random() > ((100 - _OnDeathExtraSpawnPercent) / 100))
				{
					PlayState._alienGroup.add(new AlienClass(getNontargetPlayer()));
				}
				
				//kill alien
				activate(getNontargetPlayer());
			}
		}
		
		private function setSpawnPoint():void  //<--------------------------------------------TODO: investigate & set clockwiseRotation to false if in upper-right or lower-left corner
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
		
		public function activate(targetPlayer:uint):void
		{
			isActive = true;
			health = _StartingHealth;
			_targetPlayer = targetPlayer;
			setSpawnPoint();
			_inRangeOfPlayer = false;
			_fireDelayTimer = 0.0;
			setNextFireTime();
			_clockwiseRotation = true;
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