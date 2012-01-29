package Weapons 
{
	import org.flixel.FlxEmitter;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	
	public class VenomBomb extends Bullet
	{
		private var dmg:int = 1;
		
		private var _venomEmitter:FlxEmitter;
		
		public function VenomBomb(weapon:FlxWeapon, id:uint)
		{
			super(weapon, id);
			initParticleSystems();
		}
		
		private function initParticleSystems():void
		{
			_venomEmitter = new FlxEmitter(0, 0, 4);
			_venomEmitter.visible = false;
			
			var particle:FlxParticle
			for (var i:int = 0; i < _venomEmitter.maxSize; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(1, 1, 0xFF00FF00);
				particle.visible = false;
				particle.lifespan = 1;
				
				_venomEmitter.add(particle);
			}
			FlxG.state.add(_venomEmitter);			
		}
		
		public function GetDmg():int
		{
			return dmg;
		}
		
		override public function kill():void 
		{
			_venomEmitter.x = x;
			_venomEmitter.y = y;
			_venomEmitter.start(true, 1, 0.1, 0);
			super.kill();
		}
	}		
}