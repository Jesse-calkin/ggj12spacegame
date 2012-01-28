package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class Bullet extends FlxSprite
	{
		private const _size:uint = 8;
		private const _speed:uint = 600;
		
		private var direction:String;
		
		public function Bullet() 
		{
			super(GameState.heroPlayer.x + GameState.heroPlayer.width / 2 - _size / 2, GameState.heroPlayer.y + GameState.heroPlayer.height / 2 - _size / 2);
			makeGraphic(_size, _size, 0xffffff22);
			
			direction = GameState.heroPlayer.heroFacing;
			
			//if (GameState.heroPlayer.heroFacing == "up")
			//{
				//velocity.y += _speed;
			//}
			//else if (GameState.heroPlayer.heroFacing == "down")
			//{
				//velocity.y -= _speed;
			//}
			//else if (GameState.heroPlayer.heroFacing == "right")
			//{
				//velocity.x -= _speed;
			//}
			//else if (GameState.heroPlayer.heroFacing == "left")
			//{
				//velocity.x += _speed;
			//}
			
		}
		
		override public function update():void 
		{
			if (GameState.isGameRunning)
			{
				alpha = 1.0;
			}
			else
			{
				alpha = 0.0;
			}
			
			if (direction == "up")
			{
				velocity.y = _speed;
			}
			else if (direction == "down")
			{
				velocity.y = -_speed;
			}
			else if (direction == "right")
			{
				velocity.x = -_speed;
			}
			else if (direction == "left")
			{
				velocity.x = _speed;
			}
			
			super.update();
			
			//if (x < -10 || x > FlxG.width + 10 || y < -10 || y > FlxG.height + 10)
			//{
				//destroy();
			//}
		}
		
	}

}