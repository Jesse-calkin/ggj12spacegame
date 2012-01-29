package
{
        import flash.display.Stage;
        import org.flixel.*;

	public class Registry
	{
		public static var stage:Stage;
		
		public static var player1Planet:FlxSprite;
		public static var player2Planet:FlxSprite;
		public static var player1Satellite:SatelliteClass;
		public static var player2Satellite:SatelliteClass;
		public static var topPowerUpSpawner:FlxEmitter;
		public static var bottomPowerUpSpawner:FlxEmitter;
		public static var p1score:Number;
		public static var p2score:Number;
		
		public function Registry()
		{

		}
    }
}