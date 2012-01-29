package Weapons 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import ImageFiles;
	import SatelliteClass;
	
	/**
	 * ...
	 * @author Caleb
	 */
	public class RocketLauncher extends FlxWeapon
	{
		private const _rocketCount:int = 50;
		private const _maxRocketSpeed:FlxPoint = new FlxPoint(190, 190);
		private const _startRocketSpeed:int = 140;
		private const _rocketAcceleration:FlxPoint = new FlxPoint(10, 10);
		private const _rateOfFire:int = 400;
		
		public function RocketLauncher(satelite:SatelliteClass) 
		{
			super("RocketLauncher", satelite, "x", "y");
			makeImageBullet(_rocketCount, Rocket, ImageFiles.rocketImg, 5, 0, true, 360);
			setBulletSpeed(_startRocketSpeed);
			setBulletAcceleration(_rocketAcceleration.x, _rocketAcceleration.y, _maxRocketSpeed.x, _maxRocketSpeed.y);
			setBulletBounds(new FlxRect(0, 0, 800, 400)); // be nice to pass from play state or wherever
			setFireRate(_rateOfFire);
			onFireSound = new FlxSound().loadEmbedded(SoundFiles.laserFireSnd);
		}
	}

}