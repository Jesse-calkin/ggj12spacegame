package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class blood extends FlxSprite
	{
		private var timer:Number = 0.0;
		
		public function blood(X:int, Y:int) 
		{
			super(X, Y);
			makeGraphic(10, 10, 0xffff2222);
		}
		
		override public function update():void 
		{	
			if (alpha > 0.0)
			{
				timer += FlxG.elapsed;
				
				if (timer / 6.0 <= 1)
				{
					alpha = 1.0 - (timer / 6.0);
				}
				else
				{
					alpha = 0.0;
				}
				
				super.update();
			}
		}
		
	}

}