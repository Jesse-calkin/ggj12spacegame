package Weapons 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.FlxG;

	public class Rocket extends Bullet
	{
		public var _propulsionEmitter:FlxEmitter;
		private var dmg:int = 1;
		
		public function Rocket(weapon:FlxWeapon, id:uint)
		{
			super(weapon, id);
		
			initParticleSystem();
		}
		
		public function GetDmg():int
		{
			return dmg;
		}
		
		private function initParticleSystem():void
		{
			_propulsionEmitter = new FlxEmitter( -100, -100, 4);
			_propulsionEmitter.visible = false;
			_propulsionEmitter.lifespan = 0.1;
			_propulsionEmitter.frequency = 0.1;
			_propulsionEmitter.setXSpeed(0, 0);
			_propulsionEmitter.setYSpeed(0, 0);
			
			var particle:FlxParticle;
			for(var i:int = 0; i < _propulsionEmitter.maxSize; i++)
			{
				particle = new FlxParticle();
				
				var color:uint;
				if (i % 2 == 0)
				{
					color = 0xffffff00;
				}
				else
				{
					color = 0xffff0000;
				}
				
				particle.makeGraphic(3, 3, color);
				particle.visible = false;
				particle.acceleration.x = acceleration.x;
				particle.acceleration.y = acceleration.y;
				
				
				_propulsionEmitter.add(particle);
			}
			FlxG.state.add(_propulsionEmitter);
		}
		
		override public function fireFromAngle(fromX:int, fromY:int, fireAngle:int, speed:int):void 
		{
			super.fireFromAngle(fromX, fromY, fireAngle, speed);
			
			RocketLaunched();
		}
		
		public override function update():void
		{
			_propulsionEmitter.x = x - (width/2);
			_propulsionEmitter.y = y;
		}
		
		public override function kill():void
		{
			_propulsionEmitter.kill()
			super.kill()			
		}
		
		public function RocketLaunched():void
		{
			_propulsionEmitter.x = x + (width/2);
			_propulsionEmitter.y = y;
			_propulsionEmitter.minParticleSpeed = new FlxPoint(velocity.x - 2, velocity.y - 2);
			_propulsionEmitter.maxParticleSpeed = new FlxPoint(velocity.x - 1, velocity.y - 1);;
			_propulsionEmitter.start(false,1,0.1);
		}
	}		
}