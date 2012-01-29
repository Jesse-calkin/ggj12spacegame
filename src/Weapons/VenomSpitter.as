package Weapons 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import ImageFiles;
	import AlienClass;
	
	/**
	 * ...
	 * @author Caleb
	 */
	public class VenomSpitter extends FlxWeapon
	{
		private const _venomCount:int = 150;
		private const _maxSpeed:FlxPoint = new FlxPoint(130, 130);
		private const _startSpeed:int = 120;
		private const _acceleration:FlxPoint = new FlxPoint(10, 10);
		
		public function VenomSpitter(alien:AlienClass) 
		{
			super("VenomSpitter");
			makeImageBullet(_venomCount, VenomBomb, ImageFiles.venomImg, alien.x, alien.y);
			setBulletSpeed(_startSpeed);
			setBulletAcceleration(_acceleration.x, _acceleration.y, _maxSpeed.x, _maxSpeed.y);
			setBulletBounds(FlxG.worldBounds);
			onFireSound = new FlxSound().loadEmbedded(SoundFiles.laserFireSnd);
		}
	}
}