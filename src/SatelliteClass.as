package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxFlectrum;
	
	import org.flixel.FlxG;
	import Weapons.RocketLauncher;
	
	/**
	 * ...
	 * @author B-Dog
	 */
	public class SatelliteClass extends FlxSprite
	{
		public var radius:Number = 55;
		public var speed:Number = 1;
		public var xcenter:Number;
		public var ycenter:Number;
		public var degree:Number = 180;
		public var radian:Number = (degree / 180) * Math.PI;
		
		public var _rocketLauncher:RocketLauncher;
		
		public function SatelliteClass(Player:uint, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);

			//loadRotatedGraphic(SimpleGraphic, 360,
			trace(origin.x + " " + origin.y);
			origin.x = 0;
			origin.y = 0;
			trace(origin.x + " " + origin.y);
			
			radius = 100;
			
			if (Player == 1)
			{
				xcenter = Registry.player1Planet.getMidpoint().x;
				ycenter = Registry.player1Planet.getMidpoint().y;
			}
			else
			{
				xcenter = Registry.player2Planet.getMidpoint().x;
				ycenter = Registry.player2Planet.getMidpoint().y;
			}
			
			angle = 270;
			x = xcenter + Math.cos(radian) * radius / 2;
			y = ycenter + Math.sin(radian) * radius / 2;
			
			_rocketLauncher = new RocketLauncher(this)
		}
		
		public function MoveClockwise():void
		{
			//var _endpointX:Number;
			//var _endpointY:Number;
			//var _arrowRadians:Number;
			//
			//_arrowRadians = angle * (Math.PI / 180);   //"angle" is arrow angle in degrees
			//_endpointX = x + (width*.5) - (_hypotenuse * (Math.cos(Math.PI - _theta - _arrowRadians)));
			//_endpointY = y + (height * .5) + (_hypotenuse * (Math.sin(_theta + _arrowRadians)));
			//
			//x = _endpointX;
			//y = _endpointY;
			
			degree += speed;
			degree %= 360;
			radian = (degree / 180) * Math.PI;
			angle = degree +90;
			
			x = xcenter + Math.cos(radian) * radius / 2;
			y = ycenter + Math.sin(radian) * radius / 2;
		}
		
		public function MoveCounterclockwise():void
		{
			degree -= speed;
			degree %= 360;
			radian = (degree / 180) * Math.PI;
			angle = degree;
			
			x = xcenter + Math.cos(radian) * radius / 2;
			y = ycenter + Math.sin(radian) * radius / 2;
		}
		
		public function Fire():void
		{
			//trace("X: " + x);
			//trace("Y: " + y);
			//trace("D: " + degree);
			FlxG.play(SoundFiles.laserFireSnd);
			_rocketLauncher.fireFromAngle(degree);
		}
		
	}

}