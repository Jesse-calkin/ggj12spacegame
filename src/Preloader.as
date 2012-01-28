package
{
	import org.flixel.FlxPreloader
	[Frame(factoryClass="Preloader")] //Tells Flixel to use our preloader
 
	public class Preloader extends FlxPreloader
	{
		public function Preloader():void
		{
			className = "ggj12";
			super();
		}
	}
}