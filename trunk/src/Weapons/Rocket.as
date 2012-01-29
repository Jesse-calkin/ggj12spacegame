package Weapons 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;

	public class Rocket extends Bullet
	{
		public var _propulsionEmitter:FlxEmitter;
		private var dmg:int = 1;
		
		public function Rocket(weapon:FlxWeapon, id:uint)
		{
			super(weapon, id);
		
			//initParticleSystem();
		}
		
		public function GetDmg():int
		{
			return dmg;
		}
		
		private function initParticleSystem():void
		{
			_propulsionEmitter = new FlxEmitter(200, 200, 4);
			_propulsionEmitter.lifespan = 10;
			_propulsionEmitter.frequency = 0.1;
			_propulsionEmitter.setXSpeed(0, 0);
			_propulsionEmitter.setYSpeed(0, 0);
			
			var particle:FlxParticle;
			for(var i:int = 0; i < _propulsionEmitter.maxSize; i++)
			{
				particle = new FlxParticle();
				if (i % 2 == 0)
				{
					particle.makeGraphic(20, 25, 0xffff00ff);
				}
				else
				{
					particle.makeGraphic(23, 23, 0xff00ff00);
				}
				
				_propulsionEmitter.add(particle);
			}
		}
		
		override public function fireFromAngle(fromX:int, fromY:int, fireAngle:int, speed:int):void 
		{
			super.fireFromAngle(fromX, fromY, fireAngle, speed);
			
			//RocketLaunched();
		}
		
		public function RocketLaunched():void
		{
			trace("launched");
			_propulsionEmitter.start(false,1,0.1);
		}
	}		
}