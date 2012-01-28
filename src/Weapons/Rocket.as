package Weapons 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	
	public class Rocket extends Bullet
	{
		public var _propulsionEmitter:FlxEmitter;
		//private var _propulsionParticles:Array;
		//private var _explosionParticle:FlxParticle;
		
		public function Rocket(weapon:FlxWeapon, id:uint)
		{
			super(weapon, id);
			//initParticleSystem();
		}
		
		/*private function initParticleSystem()
		{
			_propulsionEmitter = new FlxEmitter(this.x, this.y, 5);
			_propulsionEmitter.add(new FlxParticle().makeGraphic(2, 2, 0xFFFF0000));
			_propulsionEmitter.add(new FlxParticle().makeGraphic(2, 2, 0xFFFFFF00));
		}*/
		
		/*private function initPropulsionParticles() {
			_propulsionParticles[0] = new FlxParticle();
			_propulsionParticles[0].makeGraphic(2, 2, 0xFFFF0000);
			_propulsionParticles[1] = new FlxParticle();
			_propulsionParticles[1].makeGraphic(2, 2, 0xFFFFFF00);
		}*/
		
		/*override public function update():void
		{
			_propulsionEmitter.emitParticle();
			
			super.update()
		}*/
		
		/*private function initExplosionParticles() {
			//TODO: //
			
		}*/
		
		/*override public function kill():void 
		{
			
			super.kill();
		}*/
	}		
}