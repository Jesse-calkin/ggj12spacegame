package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		//[Embed(source = "../data/gfx/level1background.png")] public static var level1background:Class;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
		}
		
		override public function update():void
		{
			super.update();
		}		
	}
}