package Powerups 
{
	
	import org.flixel.FlxG;
	
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
		
		//override protected function spawn():void
		//{
			//x = FlxG.width / 2 - width / 2;
			//
			// Spawn on the top
			//if (FlxG.random() < .5)
			//{
				//y = -height;
				//velocity.y = POWERUP_SPEED * FlxG.elapsed;
			//}
			//else
			//{
				//y = FlxG.height;
				//velocity.y = -POWERUP_SPEED * FlxG.elapsed;
			//}
		//}
		
		override public function apply(who:SatelliteClass):void
		{
			kill();
			
			who.hasShield = true;
			trace();
		}
		
	}

}