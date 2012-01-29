package Powerups 
{
	
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Jay Wagner
	 */
	public class MoveSpeed extends Powerup
	{
		public static const TIME:Number = 5.0;
		
		public function MoveSpeed() 
		{
			super(0, 0, ImageFiles.moveSpeedPowerupImg);
		}
		
		override public function apply(who:SatelliteClass):void
		{
			kill();
			
			who.hasMoveSpeed = true;
			trace("Movespeed!");
		}
		
	}

}