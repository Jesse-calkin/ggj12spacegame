package  
{
	import org.flixel.*;
	
	import Weapons.RocketLauncher;
	import Powerups.MoveSpeed;
	
	/**
	 * ...
	 * @author B-Dog
	 */
	public class SatelliteClass extends FlxSprite
	{
		public static const CLOCKWISE:String = "clockwise";
		public static const COUNTER_CLOCKWISE:String = "counterClockwise";
		
		private var _angularAcceleration:Number;
		
		public var radius:Number;
		public var xcenter:Number;
		public var ycenter:Number;
		public var radian:Number = 0;
		
		public var powerupTime:Number;
		public var hasShield:Boolean;
		public var hasMoveSpeed:Boolean;
		public var shieldSprite:FlxSprite = new FlxSprite();
		
		public var _rocketLauncher:RocketLauncher;
		
		public function SatelliteClass(Player:uint, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y);
			loadGraphic(ImageFiles.satelliteImg);
			
			shieldSprite.exists = false;
			origin.x = 0;
			powerupTime = 0;
			radius = 100;
			_angularAcceleration = 300;
			
			shieldSprite.makeGraphic(radius, radius, 0x00000000);
			
			if (Player == 1)
			{
				xcenter = Registry.player1Planet.getMidpoint().x;
				ycenter = Registry.player1Planet.getMidpoint().y;
				shieldSprite.x = Registry.player1Planet.x - 45 / 2;
				shieldSprite.y = Registry.player1Planet.y - 45 / 2;
			}
			else
			{
				xcenter = Registry.player2Planet.getMidpoint().x;
				ycenter = Registry.player2Planet.getMidpoint().y;
				shieldSprite.x = Registry.player2Planet.x - 45 / 2;
				shieldSprite.y = Registry.player2Planet.y - 45 / 2;
			}
			
			x = xcenter;
			y = ycenter - height / 2;
			
			_rocketLauncher = new RocketLauncher(this);
			FlxG.state.add(_rocketLauncher.group);
		}
		
		public function rotate(direction:String):void
		{
			angularAcceleration = (direction == CLOCKWISE) ? _angularAcceleration : -_angularAcceleration;
			
			idle();
		}
		
		public function idle():void
		{
			radian = (angle / 180) * Math.PI;
			
			var parentClass:FlxSprite;
			if (this == Registry.player1Satellite)
			{
				parentClass = Registry.player1Planet;
			}
			else if (this == Registry.player2Satellite)
			{
				parentClass = Registry.player2Planet;
			}
			else
			{
				trace("Bad satellite reference.");
			}
			
			_rocketLauncher.setParent(parentClass, "x", "y", parentClass.origin.x + Math.cos(radian) * width, parentClass.origin.y + Math.sin(radian) * width);
		}
		
		public function Fire():void
		{
			_rocketLauncher.Fire(angle);
		}
		
		override public function update():void
		{
			if (hasShield)
			{
				powerupTime += FlxG.elapsed;
				
				shieldSprite.exists = true;
				PlayState.drawCircle(shieldSprite, new FlxPoint(shieldSprite.width / 2, shieldSprite.height / 2), radius / 2, 0xff33ff33, 0, 0x4433ff33);
				FlxG.state.add(shieldSprite);
				hasShield = false;
			}
			
			if (hasMoveSpeed)
			{
				powerupTime += FlxG.elapsed;
				
				_angularAcceleration = 400;
				maxAngular = 200;
				//hasMoveSpeed = false;
			}
			
			if (powerupTime)
			{
				powerupTime += FlxG.elapsed;
				
				if (hasMoveSpeed && powerupTime > MoveSpeed.TIME)
				{
					_angularAcceleration = 300;
					maxAngular = 100;
					powerupTime = 0;
				}
				
				if (shieldSprite.exists)
				{
					shieldSprite.alpha = Math.min(powerupTime, 1);
				}
			}
			
		}
		
	}

}