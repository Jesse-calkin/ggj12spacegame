package Game.Powerups 
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	
	import Game.Player.SatelliteClass;
	
	/**
	 * ...
	 * @author Jay Wagner
	 */
	public class Powerup extends FlxParticle
	{
		public static const POWERUP_SPEED:Number = 3000;
		
		public static var alienKillGoal:uint;
		public static var powerupsSpawned:uint;
		
		public function Powerup(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super();
			loadGraphic(SimpleGraphic);
		}
		
		public function apply(who:SatelliteClass):void
		{
			kill();
			trace("Powerup base class apply");
		}
		
		//override public function update():void
		//{
			//
		//}
	}

}