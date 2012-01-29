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
		private var _propulsionEmitter:FlxEmitter;
		private const _propulsionParticalSize:int = 3;
		
		private var _explosionEmitter:FlxEmitter;
		
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
			initPropulsionParticleSystem();
			initExplosionParticleSystem();
		}
		
		private function initExplosionParticleSystem():void
		{
			_explosionEmitter = new FlxEmitter(0, 0, 15);
			_explosionEmitter.exists = false;
			//_explosionEmitter.visible = false;
			
			var particle:FlxParticle
			for (var i:int = 0; i < _explosionEmitter.maxSize; i++)
			{
				particle = new FlxParticle();
				
				var color:uint
				if (i % 3 == 0)
				{
					color = 0xffffff00;
				}
				else if (i % 2 == 0)
				{
					color = 0xffff0000;
				}
				else
				{
					color = 0xffffa500;
				}
				
				particle.makeGraphic(2, 2, color);
				particle.exists = false;
				particle.lifespan = 1;
				
				_explosionEmitter.add(particle);
			}
			FlxG.state.add(_explosionEmitter);			
		}
		
		private function initPropulsionParticleSystem():void
		{
			_propulsionEmitter = new FlxEmitter( -100, -100, 3);
			//_propulsionEmitter.alive = false;
			_propulsionEmitter.exists = false;
			//_propulsionEmitter.visible = false;
			_propulsionEmitter.lifespan = 10;
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
				
				particle.makeGraphic(_propulsionParticalSize, _propulsionParticalSize, color);
				particle.exists = false;
				particle.lifespan = 0.1;
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
			_propulsionEmitter.x = x + 3;
			_propulsionEmitter.y = y + 3;
		}
		
		public override function kill():void
		{
			_propulsionEmitter.kill();
			_explosionEmitter.x = x;
			_explosionEmitter.y = y;
			_explosionEmitter.start(true, 1, 0.1, 0);
			super.kill()			
		}
		
		public function RocketLaunched():void
		{
			_propulsionEmitter.x = x + 3;
			_propulsionEmitter.y = y + 3;
			_propulsionEmitter.minParticleSpeed = new FlxPoint(velocity.x - 2, velocity.y - 2);
			_propulsionEmitter.maxParticleSpeed = new FlxPoint(velocity.x - 1, velocity.y - 1);
			_propulsionEmitter.start(false, 1, 0.03);
		}
	}		
}