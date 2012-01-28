package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author B-Dog
	 */
	public class SatelliteClass extends FlxSprite
	{
		public var radius:Number = 30;
		public var speed:Number = 1;
		public var xcenter:int = Registry.player1Planet.x+(Registry.player1Planet.width/2);
		public var ycenter:int = Registry.player1Planet.y+(Registry.player1Planet.height/2);
		public var degree:Number = 0;
		public var radian:Number;
		
		public function SatelliteClass(X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		
	}

}