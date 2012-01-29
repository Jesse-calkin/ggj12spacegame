package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AsteroidClass extends FlxSprite
	{
		private const _AsteroidSpeedMultiplier:uint = 15;
		
		public function AsteroidClass() 
		{
			makeGraphic(35, 35, 0xffffffff);
		}
		
		override public function update():void
		{
		}
		
		private function respawn():void
		{
			
		}
		
	}

}