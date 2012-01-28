package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AlienClass extends FlxSprite
	{
		//Constants
		private const _StartingHealth:uint = 1;
		private const _MaxHealth:uint = 1;
		private const _MinHealth:uint = 0;
		private const _OnDeathSpawnRate:uint = 2;
		private const _SpawnDistanceFromScreen:uint = 50;
		private const _RandomSpawnPointSelectionLength:uint = (200 * 3) + (_SpawnDistanceFromScreen * 4);
		private const _SpawnZone1 = (FlxG.width / 2) + _SpawnDistanceFromScreen;
		private const _SpawnZone2 = FlxG.height + _SpawnDistanceFromScreen * 2 + _SpawnZone1;
		private const _SpawnZone3 = _SpawnZone1 * 2 + _SpawnZone2;
		
		//Variables
		private var _health:uint = null;
		private var _targetPlayer:uint = null;
		private var _xPos:int = 0;
		private var _yPos:int = 0;
		private var _inRangeOfPlayer:Boolean = null;
		private var _randomSpawnPoint:uint = null;
		
		public function AlienClass(targetPlayer:uint = null, SimpleGraphic:Class = null) 
		{
			health = _StartingHealth;
			
			if (targetPlayer != null)
			{
				_targetPlayer = targetPlayer;
			}
			else 
			{
				_targetPlayer = getClosestPlayer();
			}
			
			_inRangeOfPlayer = false;
			
			super(_xPos, _yPos, SimpleGraphic);
		}
		
		override public function update():void 
		{
			//if in range of player, attack and/or move
			
			//else, move towards player
		}
		
		private function move()
		{
			if (!_inRangeOfPlayer)
			{
				//move towards planet
				
				//check if in range of player
			}
			else
			{
				//move around planet
			}
		}
		
		private function attack()
		{
			
		}
		
		public function takeDamage(damage:uint)
		{
			health -= damage;
			
			if (health <= _MinHealth)
			{
				//kill alien
				
				//spawn aliens on enemy
			}
		}
		
		private function getClosestPlayer()
		{
			//find distance between alien and both players
			
			//set target to closest player
		}
		
		private function setSpawnPoint()
		{
			_randomSpawnPoint = FlxG.random() * _RandomSpawnPointSelectionLength;
			
			switch(_targetPlayer)
			{
			case 1:
				//spawn on left side of screen
				if (_randomSpawnPoint <= _SpawnZone1)
				{
					_xPos = _randomSpawnPoint - _SpawnDistanceFromScreen;
					_yPos = -_SpawnDistanceFromScreen;
				}
				else if (_randomSpawnPoint <= _SpawnZone2)
				{
					_xPos = -_SpawnDistanceFromScreen;
					_yPos = (_SpawnDistanceFromScreen - _SpawnZone1) - _SpawnDistanceFromScreen;
				}
				else if (_randomSpawnPoint <= _SpawnZone3)
				{
					_xPos = _randomSpawnPoint - _SpawnDistanceFromScreen - _SpawnZone2;
					_yPos = FlxG.height + _SpawnDistanceFromScreen;
				}
				else
				{
					FlxG.log("Alien Spawn Position Assignment Error.");
				}
				break;
			case 2:
				//spawn on right side of screen
				if (_randomSpawnPoint <= _SpawnZone1)
				{
					_xPos = _SpawnDistanceFromScreen + (FlxG.width / 2);
					_yPos = -_SpawnDistanceFromScreen;
				}
				else if (_randomSpawnPoint <= _SpawnZone2)
				{
					_xPos = FlxG.width + _SpawnDistanceFromScreen;
					_yPos = (_SpawnDistanceFromScreen - _SpawnZone1) - _SpawnDistanceFromScreen;
				}
				else if (_randomSpawnPoint <= _SpawnZone3)
				{
					_xPos = _randomSpawnPoint + (FlxG.width / 2) - _SpawnZone2;
					_yPos = FlxG.height + _SpawnDistanceFromScreen;
				}
				else
				{
					FlxG.log("Alien Spawn Position Assignment Error.");
				}
				break;
			default:
				FlxG.log("Alien Target Assignment Error.");
				break;
			}
		}
		
	}

}