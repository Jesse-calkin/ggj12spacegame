package
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="800", height="400", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class ggj12 extends FlxGame
	{
		public function ggj12()
		{
			super(800, 400, PlayState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		}
	}
}