package Weapons 
{
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class VenomBomb extends Bullet
	{
		private var dmg:int = 1;
		
		public function VenomBomb(weapon:FlxWeapon, id:uint)
		{
			super(weapon, id);
		}
		
		public function GetDmg():int
		{
			return dmg;
		}
	}		
}