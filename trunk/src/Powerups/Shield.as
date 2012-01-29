package Powerups 
{
	
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Jay Wagner
	 */
	public class Shield extends Powerup
	{
		
		public function Shield(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
		protected override spawn()
		{
			// Spawn on the top
			if (FlxG.random() < .5)
			{
				x = FlxG.width / 2 - width / 2;
				
			}
		}
		
	}

}