package  
{
	import org.flixel.*;
	
	import Weapons.RocketLauncher;
	
	/**
	 * ...
	 * @author B-Dog
	 */
	public class SatelliteClass extends FlxSprite
	{
		public static const CLOCKWISE:String = "clockwise";
		public static const COUNTER_CLOCKWISE:String = "counterClockwise";
		
		public var radius:Number = 55;
		public var speed:Number = 1.3;
		public var xcenter:Number;
		public var ycenter:Number;
		public var degree:Number = 0;
		public var radian:Number = (degree / 180) * Math.PI;
		
		public var powerupTime:Number;
		public var hasShield:Boolean;
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
			degree = (direction == CLOCKWISE ? degree + speed : degree - speed);
			degree %= 360;
			angle = degree;
			radian = (degree / 180) * Math.PI;
			
			//var pixel:FlxSprite = new FlxSprite(xcenter + Math.cos(radian) * (radius / 2 + 5), ycenter + Math.sin(radian) * (radius / 2 + 5)).makeGraphic(1, 1);
			//FlxG.state.add(pixel);
			
			var parentClass:FlxSprite
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
			_rocketLauncher.fireFromAngle(degree);
			_rocketLauncher.currentBullet.angle = degree + 90;
			_rocketLauncher.currentBullet.x -= 2; // correct for images
			_rocketLauncher.currentBullet.y -= 3; // correct for images
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
			
			if (powerupTime)
			{
				powerupTime += FlxG.elapsed;
				
				shieldSprite.alpha = Math.min(powerupTime, 1);
			}
			
		}
		
	}

}