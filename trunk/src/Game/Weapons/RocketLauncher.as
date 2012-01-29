package Game.Weapons
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	import Game.Player.SatelliteClass;
	import Game.Utility.ImageFiles;
	import Game.Utility.SoundFiles;
	
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
		
		public function RocketLauncher(satellite:SatelliteClass) 
		{
			super("RocketLauncher");
			makeImageBullet(_rocketCount, Rocket, ImageFiles.rocketImg, 0, 0);
			setBulletSpeed(_startRocketSpeed);
			setBulletAcceleration(_rocketAcceleration.x, _rocketAcceleration.y, _maxRocketSpeed.x, _maxRocketSpeed.y);
			//setBulletBounds(FlxG.worldBounds); -- useless, weapon never checks.
			setFireRate(_rateOfFire);
			onFireSound = new FlxSound().loadEmbedded(SoundFiles.laserFireSnd);
		}
		
		public function Fire(angle:Number):void
		{
			if (fireFromAngle(angle))
			{
				currentBullet.angle = angle + 90;
				currentBullet.x -= 2; // correct for images
				currentBullet.y -= 3; // correct for images	
			}
		}
	}

}