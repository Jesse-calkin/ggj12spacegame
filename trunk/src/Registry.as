package
{
        import flash.display.Stage;
        import org.flixel.*;
		import org.flixel.plugin.photonstorm.FlxDelay;

	public class Registry
	{
		public static var stage:Stage;
		
		public static var player1Planet:FlxSprite;
		public static var player2Planet:FlxSprite;
		public static var player1Satellite:SatelliteClass;
		public static var player2Satellite:SatelliteClass;
		public static var spawnerGroup:FlxGroup;
		public static var topShieldSpawner:FlxEmitter;
		public static var bottomShieldSpawner:FlxEmitter;
		public static var topMoveSpeedSpawner:FlxEmitter;
		public static var bottomMoveSpeedSpawner:FlxEmitter;
		public static var p1score:Number;
		public static var p2score:Number;
		public static var timer:FlxDelay;
		public static var leftsnakeWiggle:FlxSprite;
		public static var rightsnakeWiggle:FlxSprite;
				
		
		public function Registry()
		{

		}
    }
}