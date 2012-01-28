package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import Weapons.RocketLauncher;
	
	/**
	 * ...
	 * @author B-Dog
	 */
	public class SatelliteClass extends FlxSprite
	{
		public var radius:Number = 30;
		public var speed:Number = 1;
		public var xcenter:int;
		public var ycenter:int
		public var degree:Number = 0;
		public var radian:Number;
		
		public var _rocketLauncher:RocketLauncher;
		
		public function SatelliteClass(Player:uint, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);

			//loadRotatedGraphic(SimpleGraphic, 360,
			if (Player == 1)
			{
				xcenter = Registry.player1Planet.x + (Registry.player1Planet.width / 2);
				ycenter = Registry.player1Planet.y + (Registry.player1Planet.height / 2);
			}
			else
			{
				xcenter = Registry.player2Planet.x + (Registry.player2Planet.width / 2);
				ycenter = Registry.player2Planet.y + (Registry.player2Planet.height / 2);
			}
			
			_rocketLauncher = new RocketLauncher(this)
		}
		
		public function MoveClockwise():void
		{
			degree -= speed;
			angle = degree + 90;
			radian = (degree / 180) * Math.PI;
			x = xcenter + Math.cos(radian) * radius;
			y = ycenter - Math.sin(radian) * radius;
		}
		
		public function MoveCounterclockwise():void
		{
			degree += speed;
			angle = degree + 90;
			radian = (degree / 180) * Math.PI;
			x = xcenter + Math.cos(radian) * radius;
			y = ycenter - Math.sin(radian) * radius;
		}
		
		public function Fire():void
		{
			//trace("X: " + x);
			//trace("Y: " + y);
			//trace("D: " + degree);
			FlxG.play(SoundFiles.rocketFireSnd);
			_rocketLauncher.fireFromAngle(degree);
		}
		
	}

}