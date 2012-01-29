package Game.Utility
{
	import flash.display.Stage;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	import Game.Player.SatelliteClass;
		
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
		public static var p1score:uint = 0;
		public static var p2score:uint = 0;
		public static var timer:FlxDelay;
		public static var leftsnakeWiggle:FlxSprite;
		public static var rightsnakeWiggle:FlxSprite;
		public static var backgroundtheme:FlxSound;
		public static var endgameTheme:FlxSound;
		public static const menuRed:uint = 0xDC1A1A;
		public static const menulightgreen:uint = 0x1A9B05;
		public static const menudarkgreen:uint = 0x34DC1A;
		public static const menublue:uint = 0x004CFF;
		public static const menuorange:uint = 0xFF7700;
		
		public function Registry()
		{
			
		}
    }
}