package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		[Embed(source = "../data/gfx/level1background.png")] public static var level1background:Class;
		[Embed(source = "../data/gfx/zombiewalk.png")] public static var playerImg:Class;
		[Embed(source = "../data/gfx/zombiethrow.png")] public static var playerThrowImg:Class;
		[Embed(source = "../data/gfx/knife.png")] public static var knifeImg:Class;
		[Embed(source = "../data/gfx/knifehit.png")] public static var knifeHitImg:Class;
		
		public var level:FlxTilemap;
		public var player:FlxSprite;
		public var playerThrow:FlxSprite;
		
		public var knives:FlxGroup;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			
			var background:FlxSprite = new FlxSprite(0, 0, level1background);
			add(background);
			
			//Create player
			player = new FlxSprite(FlxG.width / 2 - 5, 2 * FlxG.height / 4);
			player.loadGraphic(playerImg, true, true, 64, 64, true);
			player.addAnimation("idle", [0], 15);
			player.addAnimation("walk", [0, 1, 2, 3, 4, 5, 6, 7], 12, true);
			player.addAnimation("walkUp", [8, 9, 10, 11, 12, 13, 14, 15], 12, true);
			player.maxVelocity.x = 100;
			player.maxVelocity.y = 100;
			add(player);
			
			//Create player
			playerThrow = new FlxSprite(FlxG.width / 2 - 5, 2 * FlxG.height / 4 - 9);
			playerThrow.loadGraphic(playerThrowImg, true, true, 71, 71, true);
			playerThrow.addAnimation("throw", [0, 1, 2, 3, 4, 5], 12, false);
			playerThrow.addAnimationCallback(throwEnd);
			playerThrow.maxVelocity.x = 100;
			playerThrow.maxVelocity.y = 100;
			playerThrow.visible = false;
			
			add(playerThrow);
			
			knives = new FlxGroup();
			add(knives);
		}
		
		public function throwEnd(animName:String, currentFrame:uint, currentIndex:uint):void
		{
			if ((animName == "throw") && (currentFrame == 3))
			{
				var newKnife:FlxSprite = new FlxSprite(player.x + 17, player.y + 3);
				newKnife.loadGraphic(knifeImg, false, true);
				
				newKnife.facing = player.facing;
				if (newKnife.facing == FlxObject.LEFT)
				{
					newKnife.velocity.x = -200;
				}
				else
				{
					newKnife.velocity.x = 200;
				}
				
				
				knives.add(newKnife);
				
			}
			
			//trace("Animation Name: " + animName);
			//trace("Current Frame: " + currentFrame);
			//trace("Current Index: " + currentIndex);
		}
		
		override public function update():void
		{
			//player.acceleration.x = 0;
			//player.acceleration.y = 0;
			player.velocity.x = 0;
			player.velocity.y = 0;
			playerThrow.velocity.x = 0;
			playerThrow.velocity.y = 0;
			//player.play("idle");
			
			if (FlxG.keys.LEFT)
			{
				player.visible = true;
				playerThrow.visible = false;
				player.play("walk");
				player.facing = FlxObject.LEFT;
				playerThrow.facing = FlxObject.LEFT;
				player.velocity.x = -player.maxVelocity.x;
				playerThrow.velocity.x = -player.maxVelocity.x;
				//player.acceleration.x = -player.maxVelocity.x * 16;
			}
			if (FlxG.keys.RIGHT)
			{
				player.visible = true;
				playerThrow.visible = false;
				player.play("walk");
				player.facing = FlxObject.RIGHT;				
				playerThrow.facing = FlxObject.RIGHT;				
				player.velocity.x = player.maxVelocity.x;
				playerThrow.velocity.x = player.maxVelocity.x;
				//player.acceleration.x = player.maxVelocity.x * 16;
			}
			if (FlxG.keys.UP)
			{
				player.visible = true;
				playerThrow.visible = false;
				player.play("walkUp");
				player.velocity.y = -player.maxVelocity.y;
				playerThrow.velocity.y = -player.maxVelocity.y;
				//player.acceleration.y = -player.maxVelocity.y * 16;
			}
			if (FlxG.keys.DOWN)
			{
				player.visible = true;
				playerThrow.visible = false;
				player.play("walk");
				player.velocity.y = player.maxVelocity.y;
				playerThrow.velocity.y = player.maxVelocity.y;
				//player.acceleration.y = player.maxVelocity.y * 16;
			}
			
			if (FlxG.keys.S)
			{
				// Throw a knife
				player.visible = false;
				playerThrow.visible = true;
				playerThrow.play("throw");
			}
			
			if ((player.velocity.x == 0) && (player.velocity.y == 0))
			{  
				player.play("idle");
			}
			
			//if(FlxG.keys.SPACE && player.isTouching(FlxObject.FLOOR))
				//player.velocity.y = -player.maxVelocity.y / 2;
		 
			//FlxG.log(player.acceleration);
			super.update();
		 
			//FlxG.collide(level,player);
		}		
	}
}