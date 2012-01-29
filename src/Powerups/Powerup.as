package Powerups 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jay Wagner
	 */
	public class Powerup extends FlxSprite
	{
		
		public function Powerup(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
		protected function spawn()
		{
			
		}
	}

}