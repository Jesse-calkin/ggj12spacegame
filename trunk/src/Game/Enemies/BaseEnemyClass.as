package Game.Enemies
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class BaseEnemyClass extends FlxSprite
	{
		private var PlayerTarget:uint = null;
		
		public function BaseEnemyClass(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
		protected function aquirePlayerTarget()
		{
			//find distance betweeen enemy and both planets
			
			//set target as closer player
		}
		
		override public function update()
		{
		}
		
		protected function updatePosition()
		{
			
		}
		
	}

}