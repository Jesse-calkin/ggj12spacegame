package Game.Powerups 
{
	import org.flixel.FlxG;
	
	import Game.Player.SatelliteClass;
	import Game.Utility.ImageFiles;
	
	/**
	 * ...
	 * @author Jay Wagner
	 */
	public class Shield extends Powerup
	{
		
		public function Shield() 
		{
			super(0, 0, ImageFiles.shieldPowerupImg);
		}
		
		override public function apply(who:SatelliteClass):void
		{
			kill();
			
			who.hasShield = true;
			trace();
		}
		
	}

}