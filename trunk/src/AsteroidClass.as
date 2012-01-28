package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AsteroidClass extends FlxSprite
	{
		private const _MaxHealth:uint = 5;
		private const _SpawnDistanceFromScreen:uint = 40;
		private const _AsteroidSpeedMultiplier:uint = 15;
		private var _clockwise:Boolean; 
		
		public function AsteroidClass() 
		{
			makeGraphic(35, 35, 0xffffffff);
			activate();
		}
		
		override public function update():void
		{
		}
		
		public function activate():void
		{
		}
		
		public function takeDamage(damage:uint):void
		{
			health -= damage;
			
			if (health <= 0)
			{	
				activate();
			}
		}
		
	}

}