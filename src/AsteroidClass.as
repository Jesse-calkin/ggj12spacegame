package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class AsteroidClass extends FlxSprite
	{
		private const _MinRotationSpeed:uint = 5;
		private const _MaxRotationSpeed:uint = 10;
		
		private var _rotationSpeed:Number;
		private var _currentAngle:Number;
		private var _rotationAngle:Number;
		private var _clockwise:Boolean;
		
		public function AsteroidClass() 
		{
			x = FlxG.width / 2;
			y = FlxG.height / 2;
			makeGraphic(35, 35, 0xffffffff);
			centerOffsets(true);
		}
		
		override public function update():void
		{
			super.update();
			draw();
		}
		
		private function updateRotation():void
		{
			_rotationAngle = _rotationSpeed * FlxG.elapsed;
			if (!_clockwise)
			{
				_rotationAngle *= -1;
			}
		}
		
		public function activate():void
		{
			_rotationSpeed = FlxG.random() * (_MaxRotationSpeed - _MinRotationSpeed) + _MinRotationSpeed;
			_currentAngle = FlxG.random() * 360;
			if (FlxG.random() < 0.5)
			{
				_clockwise = true;
			}
			else
			{
				_clockwise = false;
			}
		}
		
		private function mitosis():void
		{
			
		}
		
	}

}