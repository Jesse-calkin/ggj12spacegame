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
		public static const CLOCKWISE:String = "clockwise";
		public static const COUNTER_CLOCKWISE:String = "counterClockwise";
		
		public var radius:Number = 55;
		public var speed:Number = 1;
		public var xcenter:Number;
		public var ycenter:Number;
		public var degree:Number = 0;
		public var radian:Number = (degree / 180) * Math.PI;
		
		public var _rocketLauncher:RocketLauncher;
		
		public function SatelliteClass(Player:uint, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y);
			loadGraphic(ImageFiles.satelliteImg);
			
			origin.x = 0;	
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
			
			//angle = 270;
			x = xcenter;
			y = ycenter - height / 2;
			
			_rocketLauncher = new RocketLauncher(this)
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
			//trace("X: " + x);
			//trace("Y: " + y);
			//trace("D: " + degree);
			_rocketLauncher.fireFromAngle(degree);
		}
		
	}

}