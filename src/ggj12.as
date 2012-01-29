package
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	
	import Game.FlxStates.*;
	
	[SWF(width = "800", height = "400", backgroundColor = "#000000")] //Set the size and color of the Flash file
	[Frame(factoryClass = "Preloader")]
 
	public class ggj12 extends FlxGame
	{
		public function ggj12()
		{
			super(800, 400, MenuState, 1, 60, 60); //Create a new FlxGame object at 800 x 400, then load PlayState
		}
	}
}