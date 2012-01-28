package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AlienClass extends BaseEnemyClass
	{
		//Constants
		private const StartingHealth:uint = 1;
		private const MaxHealth:uint = 1;
		
		//Variables
		private var health:uint = StartingHealth;
		
		public function AlienClass(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
		private function attack()
		{
			
		}
		
	}

}