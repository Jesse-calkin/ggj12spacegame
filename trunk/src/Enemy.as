package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Lachlan McInnes
	 */
	public class Enemy extends FlxSprite
	{
		private const _enemySize:uint = 38;
		private const _enemySpeed:Number = 3.0;
		
		private var randArray:FlxGroup;
		
		private var lastSpawnPoint:uint = 0;
		private var numberOfSpawnPoints:uint = 12;
		
		public function Enemy(num:uint) 
		{
			super(FlxG.width / 2, -30);
			
			makeGraphic(_enemySize, _enemySize, 0xff22ee22);
			health = 100;
			
			lastSpawnPoint = num;
		}
		
		override public function update():void 
		{
			if (GameState.isGameRunning)
			{
				alpha = 1.0;
				
				super.update();
				
				if (GameState.heroPlayer.x < x)
				{
					x -= _enemySpeed;
				}
				else
				{
					x += _enemySpeed;
				}
				
				if (GameState.heroPlayer.y < y)
				{
					y -= _enemySpeed;
				}
				else
				{
					y += _enemySpeed;
				}
			}
			else
			{
				alpha = 0.0;
			}
			
			lastSpawnPoint++;
			if (lastSpawnPoint > numberOfSpawnPoints - 1)
			{
				lastSpawnPoint = 0;
			}
			
			collisionWithBullets();
			collisionWithPlayer();
		}
		
		private function collisionWithBullets():void
		{
			if (FlxG.collide(GameState.bulletGroup, this))
			{
				if (GameState.skinnerTextTimer > 1.4)
				{
					switch (lastSpawnPoint)
					{
					case 0:
						GameState.skinnerTextTimer = 0.0;
						GameState.skinnerText.text = "x3";
						GameState.Qscore += 50000;
						FlxG.play(SoundFiles.award);
						break;
					case 1:
						GameState.skinnerText.color = 0xffffff22;
						break;
					case 2:
						GameState.skinnerText.color = 0xffff2222;
						break;
					case 3:
						GameState.skinnerTextTimer = 0.0;
						GameState.skinnerText.text = "Awesome!";
						FlxG.play(SoundFiles.award);
						break;
					case 4:
						GameState.skinnerText.color = 0xffff22ff;
						break;
					case 5:
						GameState.skinnerText.color = 0xff22ff22;
						break;
					case 6:
						GameState.skinnerTextTimer = 0.0;
						GameState.skinnerText.text = "x5!";
						FlxG.play(SoundFiles.award);
						GameState.Qscore += 100000;
						break;
					case 7:
						GameState.skinnerText.color = 0xff22ffff;
						break;
					case 8:
						GameState.skinnerText.color = 0xff2222ff;
						break;
					case 9:
						GameState.skinnerTextTimer = 0.0;
						GameState.skinnerText.text = "PWND!";
						FlxG.play(SoundFiles.award);
						break;
					case 10:
						GameState.extraEnemyGroup.add(FlxG.state.add(new Enemy(1)));
						break;
					case 11:
						GameState.skinnerText.color = 0xffffffff;
						break;
					}
				}
				
				//ADD EMITTER
				
				setEnemySpawnLocation();
				
				GameState.Qscore += 25000;
			}
		}
		
		private function collisionWithPlayer():void
		{
			if (FlxG.collide(GameState.heroPlayer, this))
			{
				FlxG.play(SoundFiles.death);
				
				GameState.playerDead = true;
			}
		}
		
		public function setEnemySpawnLocation():void
		{
			velocity.x = 0.0;
			velocity.y = 0.0;
			
			FlxG.play(SoundFiles.hit);
			
			GameState.bloodGroup.add(FlxG.state.add(new blood(x + 10, y + 10)));
			GameState.bloodGroup.add(FlxG.state.add(new blood(x + 15, y + 15)));			
			switch(lastSpawnPoint)
			{
				case 0:
					y = -30;
					x = FlxG.width / 4;
					break;
				case 1:
					y = -30;
					x = FlxG.width / 2;
					break;
				case 2:
					y = -30;
					x = FlxG.width * 3 / 4;
					break;
				case 3:
					x = -30;
					y = FlxG.height / 4;
					break;
				case 4:
					x = -30;
					y = FlxG.height / 2;
					break;
				case 5:
					x = -30;
					y = FlxG.height * 3 / 4;
					break;
				case 6:
					y = FlxG.height + 30;
					x = FlxG.width / 4;
					break;
				case 7:
					y = FlxG.height + 30;
					x = FlxG.width / 2;
					break;
				case 8:
					y = FlxG.height + 30;
					x = FlxG.width * 3 / 4;
					break;
				case 9:
					x = FlxG.width + 30;
					y = FlxG.height / 4;
					break;
				case 10:
					x = FlxG.width + 30;
					y = FlxG.height / 2;
					break;
				case 11:
					x = FlxG.width + 30;
					y = FlxG.height * 3 / 4;
					break;
			}
		}
		
	}

}