package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class HeroPlayer extends FlxSprite
	{
		private var _heroSize:uint = 34;
		public const heroSpeed:Number = 5.0;
		public var heroFacing:String = "right";
		private var _shotTimer:Number = 0.0;
		private const _minShotTime:Number = 0.2;
		
		public function HeroPlayer() 
		{
			super(0, 0);
			makeGraphic(_heroSize, _heroSize, 0xff2222ff);
			alpha = 0.0;
		}
		
		override public function update():void 
		{
			if (GameState.isGameRunning && !GameState.playerDead)
			{
				alpha = 1.0;
				
				_shotTimer += FlxG.elapsed;
				
				if (_shotTimer >= _minShotTime)
				{
					FlxG.play(SoundFiles.shoot);
					
					_shotTimer = 0.0;
					GameState.bulletGroup.add(FlxG.state.add(new Bullet()));
				}
			}
			else
			{
				alpha = 0.0;
			}
			
			super.update();
		}
		
	}

}