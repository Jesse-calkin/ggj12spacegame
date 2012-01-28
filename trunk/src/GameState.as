package  
{
	import org.flixel.*;
	
	/**
	 * @author Dramble
	 * Ludum Dare 21
	 * 8/19/2011
	 * Theme: ESCAPE
	 */
	
	public class GameState extends FlxState
	{
		private const screenWidth:int = 960;
		private const screenHeight:int = 720;
		private const screenBuffer:int = 45;
		
		private var _gameTitle:FlxText;
		
		public static var Qscore:uint;
		public static var QhighScore:uint = 25000;
		
		public static var playerDead:Boolean = true;
		
		public static var isGameRunning:Boolean = false;
		private var _asleep:Boolean = false;
		private var _sleepTimer:Number = 0.0;
		
		private var _instructionsText1:FlxText;
		private var _instructionsText2:FlxText;
		
		public static var playerSprite:FlxSprite;
		private var _playerSpeed:Number = 1.5;
		private var _playerSize:int = 30;
		private var _playerInteractionText:FlxText;
		private var _actionDelayTimer:Number = 2.0;
		
		public static var heroPlayer:HeroPlayer;
		private var _toggle:Boolean = false;
		
		//background
		private var _homeBackgroundSprite:FlxSprite;
		private var _workBackgroundSprite:FlxSprite;
		private var _homeWorkTunnel:FlxSprite;
		private var _homeLabel:FlxText;
		private var _workLabel:FlxText;
		
		//Meters
		private var _energyLabel:FlxText;
		private var _moneyLabel:FlxText;
		private var _meterTimer:Number = 0.0;
		private var _energyPerSec:Number = 2.0;
		private var _moneyPerSec:Number = .5;
		private var _energyValue:Number = 100;
		private var _moneyValue:Number = 100;
		
		//Room stuff
		private var _bedSprite1:FlxSprite;
		private var _bedSprite2:FlxSprite;
		private var _TVSprite1:FlxSprite;
		private var _TVSprite2:FlxSprite;
		private var _consoleSprite:FlxSprite;
		private var _fridgeSprite:FlxSprite;
		private var _counterSprite:FlxSprite;
		private var _foodSprite1:FlxSprite;
		private var _foodSprite2:FlxSprite;
		private var _foodSprite3:FlxSprite;
		private var _foodSprite4:FlxSprite;
		//private var _homeComputerSprite:FlxSprite;
		
		//work stuff
		private var _workDesk:FlxSprite;
		private var _workDesk0:FlxSprite;
		private var _workDesk1:FlxSprite;
		private var _workDesk3:FlxSprite;
		private var _workDesk4:FlxSprite;
		private var _workDesk5:FlxSprite;
		private var _workDesk6:FlxSprite;
		private var _workDesk7:FlxSprite;
		private var _workDeskPerson0:FlxSprite;
		private var _workDeskPerson1:FlxSprite;
		private var _workDeskPerson3:FlxSprite;
		private var _workDeskPerson4:FlxSprite;
		private var _workDeskPerson5:FlxSprite;
		private var _workDeskPerson6:FlxSprite;
		private var _workDeskPerson7:FlxSprite;
		private var _cubicleWall0:FlxSprite;
		private var _cubicleWall1:FlxSprite;
		private var _cubicleWall2:FlxSprite;
		private var _cubicleWall3:FlxSprite;
		private var _cubicleWall4:FlxSprite;
		private var _cubicleWall5:FlxSprite;
		private var _cubicleWall6:FlxSprite;
		private var _cubicleWall7:FlxSprite;
		private var _cubicleBreak1:FlxSprite;
		private var _cubicleBreak2:FlxSprite;
		
		//fade stuff
		private var _fadeSprite:FlxSprite;
		//private var _fadeTime:Number = 2.0;
		//private var _fadeTimeCounter:Number = 0.0;
		//private var _fadeOutToggle:Boolean = false;
		
		private var gameBackground1:FlxSprite;
		private var gameBackground2:FlxSprite;
		private var gameBackground3:FlxSprite;
		
		private var enemy1:Enemy;
		private var enemy2:Enemy;
		private var enemy3:Enemy;
		private var enemy4:Enemy;
		
		public static var extraEnemyGroup:FlxGroup;
		public static var bloodGroup:FlxGroup;
		
		private var gameTitleText:FlxText;
		
		public static var bulletGroup:FlxGroup;
		
		//--------------------------------------------------------------------------------
		private var _scoreText:FlxText;
		private var _highScoreText:FlxText;
		private var _playText:FlxText;
		public static var skinnerText:FlxText;
		public static var skinnerTextTimer:Number = 0.0;
		
		public function GameState() 
		{
			_gameTitle = new FlxText(25, 40, 350, "Escapism").setFormat(null, 30, 0xffbb9999, "center");
			add(_gameTitle);
			
			//background stuff
			_homeBackgroundSprite = new FlxSprite(screenBuffer * 2, screenBuffer * 4).makeGraphic(screenWidth / 2 - screenBuffer * 6, screenHeight - screenBuffer * 9, 0xff222222);
			add(_homeBackgroundSprite);
			_workBackgroundSprite = new FlxSprite(screenWidth / 2 - screenBuffer * 3, screenBuffer).makeGraphic(screenWidth / 2 + screenBuffer * 2, screenHeight - screenBuffer * 2, 0xff444444);
			add(_workBackgroundSprite);
			add(new FlxSprite(_workBackgroundSprite.x + 70, _workBackgroundSprite.y).makeGraphic(300, _workBackgroundSprite.height, 0xff222222));
			for (var i:uint = 0; i <= 4; i++)
			{
				add(new FlxSprite(_workBackgroundSprite.x + 25, _workBackgroundSprite.height / 4 * (i + 1) - 50).makeGraphic(20, 20, 0xff335533));
			}
			for (var n:uint = 0; n <= 4; n++)
			{
				add(new FlxSprite(_workBackgroundSprite.x + 395, _workBackgroundSprite.height / 4 * (n + 1)).makeGraphic(20, 20, 0xff335533));
			}
			add(new FlxSprite(_workBackgroundSprite.x + 210, _workBackgroundSprite.y).makeGraphic(5, _workBackgroundSprite.height, 0xffbbbb66));
			add(new FlxSprite(_workBackgroundSprite.x + 220, _workBackgroundSprite.y).makeGraphic(5, _workBackgroundSprite.height, 0xffbbbb66));
			_homeWorkTunnel = new FlxSprite(_homeBackgroundSprite.x + _homeBackgroundSprite.width, screenHeight / 2 - screenBuffer / 2).makeGraphic(screenBuffer, screenBuffer + 1, 0xff333333);
			add(_homeWorkTunnel);
			
			//Cosmetic Labels
			_homeLabel = new FlxText(_homeBackgroundSprite.x, _homeBackgroundSprite.y - screenBuffer / 2, _homeBackgroundSprite.width, "Home").setFormat(null, 12, 0xffffff, "center");
			add(_homeLabel);
			_workLabel = new FlxText(_workBackgroundSprite.x, _workBackgroundSprite.y - screenBuffer / 2, _workBackgroundSprite.width, "Work").setFormat(null, 12, 0xffffff, "center");
			add(_workLabel);
			
			//Instructions
			_instructionsText1 = new FlxText(40, _homeBackgroundSprite.y + _homeBackgroundSprite.height + 20, screenWidth - screenBuffer * 2 - _workBackgroundSprite.width, "Use WASD or arrows to move.").setFormat(null, 12, 0xffffff, "center");
			add(_instructionsText1);
			_instructionsText2 = new FlxText(40, _instructionsText1.y + 20, _instructionsText1.width, "Press Spacebar to interact.").setFormat(null, 12, 0xffffff, "center");
			add(_instructionsText2);
			
			//Home cosmetic
			_bedSprite1 = new FlxSprite(_homeBackgroundSprite.x + 5, _homeBackgroundSprite.y + _homeBackgroundSprite.height - _playerSize - 15).makeGraphic(_playerSize - 5, _playerSize + 10, 0xffeeeeee);
			add(_bedSprite1);
			_bedSprite2 = new FlxSprite(_bedSprite1.x + _bedSprite1.width, _bedSprite1.y).makeGraphic(_playerSize * 2, _bedSprite1.height, 0xff442222);
			add(_bedSprite2);
			_TVSprite1 = new FlxSprite(_homeBackgroundSprite.x + 25, _homeBackgroundSprite.y + 5).makeGraphic(_playerSize + 5, _playerSize - 10, 0xff332219);
			add(_TVSprite1);
			_TVSprite2 = new FlxSprite(_TVSprite1.x + 2, _TVSprite1.y + _TVSprite1.height).makeGraphic(_TVSprite1.width - 4, 3, 0xffbbbbbb);
			add(_TVSprite2);
			_consoleSprite = new FlxSprite(_TVSprite1.x - 5, _TVSprite1.y + _TVSprite1.height + 15).makeGraphic(10, 15, 0xff111111);
			add(_consoleSprite);
			_fridgeSprite = new FlxSprite (_homeBackgroundSprite.x + _homeBackgroundSprite.width - (_playerSize - 5) - 5, _homeBackgroundSprite.y + 5).makeGraphic(_playerSize - 5, _playerSize + 5, 0xffcccbbb);
			add(_fridgeSprite);
			_counterSprite = new FlxSprite(_homeBackgroundSprite.x + _homeBackgroundSprite.width - _playerSize, _fridgeSprite.y + _fridgeSprite.height + 5).makeGraphic(_playerSize, 100, 0xff332211);
			add(_counterSprite);
			_foodSprite1 = new FlxSprite(_counterSprite.x + 4, _counterSprite.y + 20).makeGraphic(_counterSprite.width - 10, 5, 0xff22222f);
			add(_foodSprite1);
			_foodSprite2 = new FlxSprite(_counterSprite.x + 6, _counterSprite.y + 30).makeGraphic(_counterSprite.width - 10, 5, 0xff222f22);
			add(_foodSprite2);
			_foodSprite3 = new FlxSprite(_counterSprite.x + 8, _counterSprite.y + 90).makeGraphic(_counterSprite.width - 10, 5, 0xff2f2222);
			add(_foodSprite3);
			_foodSprite4 = new FlxSprite(_counterSprite.x + 18, _counterSprite.y + 50).makeGraphic(_counterSprite.width - 20, _counterSprite.width - 10, 0xff222f2f);
			add(_foodSprite4);
			//_homeComputerSprite = new FlxSprite(_homeBackgroundSprite.x + 5, _homeBackgroundSprite.y + 150).makeGraphic(_playerSize - 5, _playerSize - 5, 0xff888888);
			//add(_homeComputerSprite);
			
			//workCosmetic
			var wallWidth:int = 80;
			var numVertical:int = 7;
			
			_cubicleWall0 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - wallWidth, _workBackgroundSprite.y).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall0);
			_cubicleWall1 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - wallWidth, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (1))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall1);
			_cubicleWall2 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (2))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall2);
			_cubicleWall3 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (3))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall3);
			_cubicleWall4 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (4))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall4);
			_cubicleWall5 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (5))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall5);
			_cubicleWall6 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (6))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall6);
			_cubicleWall7 = new FlxSprite(_cubicleWall1.x, _workBackgroundSprite.y + (_workBackgroundSprite.height / (1 + numVertical) * (7))).makeGraphic(wallWidth, 10, 0xff666666);
			add(_cubicleWall7);
			
			_workDesk0 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _workBackgroundSprite.y + _cubicleWall1.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk0);
			_workDesk1 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall1.y + _cubicleWall1.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk1);
			_workDesk3 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall3.y + _cubicleWall3.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk3);
			_workDesk4 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall4.y + _cubicleWall4.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk4);
			_workDesk5 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall5.y + _cubicleWall5.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk5);
			_workDesk6 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall6.y + _cubicleWall6.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk6);
			_workDesk7 = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall7.y + _cubicleWall7.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk7);
			
			_workDeskPerson0 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk0.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson0);
			_workDeskPerson1 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk1.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson1);
			_workDeskPerson3 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk3.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson3);
			_workDeskPerson4 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk4.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson4);
			_workDeskPerson5 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk5.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson5);
			_workDeskPerson6 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk6.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson6);
			_workDeskPerson7 = new FlxSprite(_workDesk0.x - _playerSize - 3, _workDesk7.y + 17).makeGraphic(_playerSize, _playerSize, 0xff776666);
			add(_workDeskPerson7);
			
			_cubicleBreak1 = new FlxSprite(_cubicleWall1.x - _playerSize * 2, _workBackgroundSprite.y).makeGraphic(10, 330, 0xff666666);
			add(_cubicleBreak1);
			_cubicleBreak2 = new FlxSprite(_cubicleBreak1.x, _cubicleBreak1.y + _cubicleBreak1.height + _playerSize * 2).makeGraphic(10, _workBackgroundSprite.height - _cubicleBreak1.height - _playerSize * 2, 0xff666666);
			add(_cubicleBreak2);
			
			_workDesk = new FlxSprite(_workBackgroundSprite.x + _workBackgroundSprite.width - 40, _cubicleWall2.y + _cubicleWall2.height + 2).makeGraphic(35, 65, 0xff332f11);
			add(_workDesk);
			
			//Player
			playerSprite = new FlxSprite(screenWidth / 2 - 340, screenHeight / 2 - _playerSize / 2 + 50).makeGraphic(_playerSize, _playerSize, 0xff886666);
			add(playerSprite);
			_playerInteractionText = new FlxText(0, 0, 100).setFormat(null, 8, playerSprite.color, "center");
			add(_playerInteractionText);
			
			//GUI
			_energyLabel = new FlxText(140, 600, 150, "Energy:").setFormat(null, 12, 0xffffff, "left");
			add(_energyLabel);
			_moneyLabel = new FlxText(140, 620, 150, "Money:").setFormat(null, 12, 0xffffff, "left");
			add(_moneyLabel);
			
			//FadeSprite
			_fadeSprite = new FlxSprite(15, 15).makeGraphic(screenWidth - 30, screenHeight - 30, 0xff115511);
			_fadeSprite.alpha = 0;
			add(_fadeSprite);
			
			gameBackground1 = new FlxSprite(65, 65).makeGraphic(FlxG.width - 130, FlxG.height - 130, 0xffbb22bb);
			gameBackground1.alpha = 0;
			add(gameBackground1);
			gameBackground2 = new FlxSprite(75, 75).makeGraphic(FlxG.width - 150, FlxG.height - 150, 0xff115511);
			gameBackground2.alpha = 0;
			add(gameBackground2);
			gameBackground3 = new FlxSprite(150, 150).makeGraphic(FlxG.width - 300, FlxG.height - 300, 0xff004400);
			gameBackground3.alpha = 0;
			add(gameBackground3);
			
			//Above Fade
			_scoreText = new FlxText(15, 15, FlxG.width - 30, "0 :SCORE").setFormat(null, 28, 0xffffaa11, "right");
			_scoreText.alpha = 0.0;
			add(_scoreText);
			
			bloodGroup = new FlxGroup();
			add(bloodGroup);
			
			enemy1 = new Enemy(1);
			add(enemy1);
			enemy2 = new Enemy(4);
			add(enemy2);
			enemy3 = new Enemy(7);
			add(enemy3);
			enemy4 = new Enemy(10);
			add(enemy4);
			
			extraEnemyGroup = new FlxGroup();
			
			heroPlayer = new HeroPlayer();
			add(heroPlayer);
			
			setStartingPositions();
			
			bulletGroup = new FlxGroup();
			
			gameTitleText = new FlxText(0, 220, FlxG.width, "Escape the Zombies!").setFormat(null, 30, 0xffee2222, "center");
			gameTitleText.alpha = 0.0;
			add(gameTitleText);
			_highScoreText = new FlxText(0, 350, FlxG.width, "High Score: 25000").setFormat(null, 22, 0xffffaa22, "center");
			_highScoreText.alpha = 0.0;
			add(_highScoreText);
			_playText = new FlxText(0, 450, FlxG.width, "(P)lay\t\tesc - Quit").setFormat(null, 22, 0xffcccc11, "center");
			_playText.alpha = 0.0;
			add(_playText);
			skinnerText = new FlxText(0, 80, FlxG.width, "").setFormat(null, 30, 0xffffffff, "center");
			skinnerText.alpha = 0.0;
			add(skinnerText);
		}
		
		override public function update():void 
		{
			if (_energyValue <= 0 && IsPlayerInHome())
			{
				isGameRunning = false;
				_asleep = true;
			}
			
			if (!isGameRunning)
			{
				MakeGameInvisable();
				UpdateMeters();
				
				if (_asleep)
				{
					bloodGroup.kill();
					bloodGroup = new FlxGroup();
					skinnerText.text = "";
					_highScoreText.alpha = 0.0;
					_playText.alpha = 0.0;
					gameTitleText.alpha = 0.0;
					
					_playerInteractionText.text = "Zzz";
					
					playerDead = true;
					
					_sleepTimer += FlxG.elapsed;
					
					if (_sleepTimer > 5.0)
					{
						_asleep = false;
						_sleepTimer = 0.0;
						_energyValue = 10.0;
						_playerInteractionText.text = "";
					}
				}
				else
				{
					GetInput();
				}
			}
			else
			{
				MakeGameVisable();
				
				UpdateMeters();
				
				if (playerDead)
				{
					UpdateGameMainMenu();
					//isGameRunning = false;
				}
				else
				{
					UpdateGame();
					UpdateScore();
				}
			}
			
			super.update();
		}
		
		private function UpdateGameMainMenu():void
		{
			_scoreText.alpha = 0.0;
			bulletGroup.kill();
			bulletGroup = new FlxGroup();
			bloodGroup.kill();
			bloodGroup = new FlxGroup();
			gameTitleText.alpha = 1.0;
			_highScoreText.alpha = 1.0;
			_playText.alpha = 1.0;
			Qscore = 0;
			skinnerText.text = "";
			bloodGroup.visible = false;
			
			extraEnemyGroup.kill();
			extraEnemyGroup = new FlxGroup();
			
			setStartingPositions();
			
			if (FlxG.keys.P)
			{
				FlxG.play(SoundFiles.ping1);
				
				playerDead = false;
			}
			
			if (FlxG.keys.ESCAPE)
			{
				FlxG.play(SoundFiles.ping2);
				
				isGameRunning = false;
				
				gameTitleText.alpha = 0.0;
				_highScoreText.alpha = 0.0;
				_playText.alpha = 0.0;
			}
		}
		
		private function UpdateScore():void
		{
			Qscore += 19;
			
			_scoreText.text = Qscore + " :SCORE";
			_scoreText.alpha = 1.0;
			
			if (QhighScore < Qscore)
			{
				QhighScore = Qscore;
			}
			
			_highScoreText.text = "High Score: " + QhighScore;
		}
		
		private function UpdateGame():void
		{
			bulletGroup.visible = true;
			gameTitleText.alpha = 0.0;
			_highScoreText.alpha = 0.0;
			_playText.alpha = 0.0;
			bloodGroup.visible = true;
			
			skinnerTextTimer += FlxG.elapsed;
			
			if (skinnerText.text != "")
			{
				skinnerText.alpha = 1.0;
				
				if (skinnerTextTimer > 1.0)
				{
					skinnerText.text = "";
				}
			}
			else
			{
				skinnerText.alpha = 0.0;
			}
			
			if (FlxG.keys.A || FlxG.keys.LEFT)
			{
				heroPlayer.x -= heroPlayer.heroSpeed;
				heroPlayer.heroFacing = "left";
			}
			
			if (FlxG.keys.D || FlxG.keys.RIGHT)
			{
				heroPlayer.x += heroPlayer.heroSpeed;
				heroPlayer.heroFacing = "right";
			}
			
			if (FlxG.keys.W || FlxG.keys.UP)
			{
				heroPlayer.y -= heroPlayer.heroSpeed;
				heroPlayer.heroFacing = "up";
			}
			
			if (FlxG.keys.S || FlxG.keys.DOWN)
			{
				heroPlayer.y += heroPlayer.heroSpeed;
				heroPlayer.heroFacing = "down";
			}
			
			KeepPlayerOnScreen();
		}
		
		private function MakeGameVisable():void
		{
			_fadeSprite.alpha = 1.0;
			_playText.alpha = 1.0;
			_scoreText.alpha = 1.0;
			gameBackground1.alpha = 1.0;
			gameBackground2.alpha = 1.0;
			gameBackground3.alpha = 1.0;
			//setStartingPositions();
		}
		
		private function MakeGameInvisable():void
		{
			_toggle = false;
			_fadeSprite.alpha = 0.0;
			_playText.alpha = 0.0;
			_scoreText.alpha = 0.0;
			Qscore = 0;
			gameBackground1.alpha = 0.0;
			gameBackground2.alpha = 0.0;
			gameBackground3.alpha = 0.0;
			bloodGroup.visible = false;
		}
		
		private function UpdateMeters():void
		{
			_meterTimer += FlxG.elapsed;
			
			if (_meterTimer >= 2.0)
			{
				_meterTimer = 0.0;
				
				_energyValue -= _energyPerSec;
				_moneyValue -= _moneyPerSec;
				
				if (isGameRunning && !playerDead)
				{
					_energyValue += _energyPerSec / 2;
				}
			}
			
			if (_energyValue < 0)
			{
				_energyValue = 0;
			}
			if (_moneyValue < 0)
			{
				_moneyValue = 0;
			}
			
			if (_energyValue > 100)
			{
				_energyValue = 100;
			}
			if (_moneyValue > 100)
			{
				_moneyValue = 100;
			}
			
			_energyLabel.text = "Energy: " + _energyValue.toString();
			_moneyLabel.text = "Money: " + _moneyValue.toString();
			
			if (_moneyValue >= 80)
			{
				_foodSprite1.alpha = 1.0;
				_foodSprite2.alpha = 1.0;
				_foodSprite3.alpha = 1.0;
				_foodSprite4.alpha = 1.0;
			}
			else if (_moneyValue >= 60)
			{
				_foodSprite1.alpha = 1.0;
				_foodSprite2.alpha = 0.0;
				_foodSprite3.alpha = 1.0;
				_foodSprite4.alpha = 1.0;
			}
			else if (_moneyValue >= 40)
			{
				_foodSprite1.alpha = 1.0;
				_foodSprite2.alpha = 0.0;
				_foodSprite3.alpha = 1.0;
				_foodSprite4.alpha = 0.0;
			}
			else if (_moneyValue >= 20)
			{
				_foodSprite1.alpha = 1.0;
				_foodSprite2.alpha = 0.0;
				_foodSprite3.alpha = 0.0;
				_foodSprite4.alpha = 0.0;
			}
			else
			{
				_foodSprite1.alpha = 0.0;
				_foodSprite2.alpha = 0.0;
				_foodSprite3.alpha = 0.0;
				_foodSprite4.alpha = 0.0;
			}
		}
		
		private function GetInput():void
		{
			if (FlxG.keys.A || FlxG.keys.LEFT)
			{
				playerSprite.x -= _playerSpeed;
				
				if (MovePlayerBack())
				{
					playerSprite.x += _playerSpeed;
				}
			}
			
			if (FlxG.keys.D || FlxG.keys.RIGHT)
			{
				playerSprite.x += _playerSpeed;
				
				if (MovePlayerBack())
				{
					playerSprite.x -= _playerSpeed;
				}
			}
			
			if (FlxG.keys.W || FlxG.keys.UP)
			{
				playerSprite.y -= _playerSpeed;
				
				if (MovePlayerBack())
				{
					playerSprite.y += _playerSpeed;
				}
			}
			
			if (FlxG.keys.S || FlxG.keys.DOWN)
			{
				playerSprite.y += _playerSpeed;
				
				if (MovePlayerBack())
				{
					playerSprite.y -= _playerSpeed;
				}
			}
			
			KeepPlayerOnScreen();
			
			_playerInteractionText.x = playerSprite.x - _playerInteractionText.width / 2 + playerSprite.width / 2 - 1;
			_playerInteractionText.y = playerSprite.y - 12;
			
			CheckPlayerInteraction();
			
			if (FlxG.keys.SPACE)
			{
				Interact();
			}
		}
		
		private function MovePlayerBack():Boolean
		{
			if (!KeepPlayerInRooms() || IsPlayerOnDecoration())
			{
				return true;
			}
			
			return false;
		}
		
		private function KeepPlayerOnScreen():void
		{
			if (heroPlayer.x < 15)
			{
				heroPlayer.x = 15;
			}
			
			if (heroPlayer.x + heroPlayer.width > screenWidth - 15)
			{
				heroPlayer.x = screenWidth - 15 - heroPlayer.width;
			}
			
			if (heroPlayer.y < 15)
			{
				heroPlayer.y = 15;
			}
			
			if (heroPlayer.y + heroPlayer.height > screenHeight - 15)
			{
				heroPlayer.y = screenHeight - 15 - heroPlayer.height;
			}
		}
		
		private function KeepPlayerInRooms():Boolean
		{
			if (!IsPlayerInHome() && !IsPlayerInTunnel() && !IsPlayerInWork())
			{
				return false;
			}
			
			return true;
		}
		
		private function IsPlayerInHome():Boolean
		{
			return IsPlayerInX(_homeBackgroundSprite);
		}
		
		private function IsPlayerInTunnel():Boolean
		{
			if ((playerSprite.x < _homeWorkTunnel.x - 100 || playerSprite.x + playerSprite.width > _homeWorkTunnel.x + _homeWorkTunnel.width + 100) ||
				(playerSprite.y < _homeWorkTunnel.y || playerSprite.y + playerSprite.height > _homeWorkTunnel.y + _homeWorkTunnel.height))
			{
				return false;
			}
			
			return true;
		}
		
		private function IsPlayerInWork():Boolean
		{
			return IsPlayerInX(_workBackgroundSprite);
		}
		
		private function IsPlayerInX(place:FlxSprite):Boolean
		{
			if (playerSprite.x < place.x || playerSprite.x + playerSprite.width > place.x + place.width ||
				playerSprite.y < place.y || playerSprite.y + playerSprite.height > place.y + place.height)
			{
				return false;
			}
			
			return true;
		}
		
		private function IsPlayerOnDecoration():Boolean
		{
			if (IsPlayerOnX(_TVSprite1) || IsPlayerOnX(_TVSprite2))
			{
				return true;
			}
			else if (IsPlayerOnX(_fridgeSprite) || IsPlayerOnX(_counterSprite))
			{
				return true;
			}
			else if (IsPlayerOnX(_workDesk))
			{
				return true;
			}
			else if (IsPlayerOnX(_cubicleBreak1) || IsPlayerOnX(_cubicleBreak2) || IsPlayerOnX(_cubicleWall7) || IsPlayerOnX(_cubicleWall6) || IsPlayerOnX(_cubicleWall5) || IsPlayerOnX(_cubicleWall4) || IsPlayerOnX(_cubicleWall3) || IsPlayerOnX(_cubicleWall2) || IsPlayerOnX(_cubicleWall1) || IsPlayerOnX(_cubicleWall0))
			{
				return true;
			}
			else if (IsPlayerOnX(_workDeskPerson0) || IsPlayerOnX(_workDeskPerson1) || IsPlayerOnX(_workDeskPerson3) || IsPlayerOnX(_workDeskPerson4) || IsPlayerOnX(_workDeskPerson5) || IsPlayerOnX(_workDeskPerson6) || IsPlayerOnX(_workDeskPerson7))
			{
				return true;
			}
			
			return false;
		}
		
		private function IsPlayerOnX(place:FlxSprite):Boolean
		{
			if ((playerSprite.x + playerSprite.width > place.x && playerSprite.x < place.x + place.width) &&
				(playerSprite.y + playerSprite.height > place.y && playerSprite.y < place.y + place.height))
				{
					return true;
				}
				
				return false;
		}
		
		private function IsPlayerTouchingX(place:FlxSprite):Boolean
		{
			var buffer:int = _playerSpeed + 1;
			
			if (((playerSprite.x + playerSprite.width + buffer * 2 > place.x && playerSprite.x - buffer < place.x + place.width) &&
				(playerSprite.y + playerSprite.height > place.y && playerSprite.y < place.y + place.height)) ||
				((playerSprite.y + playerSprite.height + buffer * 2 > place.y && playerSprite.y - buffer < place.y + place.height) &&
				(playerSprite.x + playerSprite.width > place.x && playerSprite.x < place.x + place.width)))
			{
				return true;
			}
			
			return false;
		}
		
		private function CheckPlayerInteraction():void
		{
			if (IsPlayerOnX(_bedSprite1) || IsPlayerOnX(_bedSprite2))
			{
				if (_energyValue < 35)
				{
					_playerInteractionText.text = "Sleep";
				}
			}
			else if (IsPlayerTouchingX(_TVSprite1) || IsPlayerTouchingX(_TVSprite2) || IsPlayerTouchingX(_consoleSprite))
			{
				_playerInteractionText.text = "Play";
			}
			else if (IsPlayerTouchingX(_fridgeSprite) || IsPlayerTouchingX(_counterSprite))
			{
				if (_moneyValue > 4.5 && _actionDelayTimer >= 2.0)
				{
					_playerInteractionText.text = "Eat";
				}
			}
			else if (IsPlayerTouchingX(_workDesk))
			{
				if (_energyValue > 50)
				{
					_playerInteractionText.text = "Work";
				}
			}
			else if (_energyValue <= 10)
			{
				_playerInteractionText.text = "Need some sleep";
			}
			else
			{
				_playerInteractionText.text = "";
			}
			
			if (!(_actionDelayTimer > 2.0))
			{
				_actionDelayTimer += FlxG.elapsed;
			}
		}
		
		private function Interact():void
		{
			_actionDelayTimer = 0.0;
			
			if (_playerInteractionText.text == "Sleep")
			{
				_energyValue += 80;
			}
			else if (_playerInteractionText.text == "Play")
			{
				FlxG.play(SoundFiles.ping1);
				setStartingPositions();
				isGameRunning = true;
			}
			else if (_playerInteractionText.text == "Work")
			{
				_energyValue -= 55;
				_moneyValue += 20;
			}
			else if (_playerInteractionText.text == "Eat")
			{
				if (_moneyValue > 8.5)
				{
					_moneyValue -= 8.5;
					_energyValue += 8.5;
				}
			}
			else 
			{
				//Do Nothing (play failure sound?)
			}
			
			_playerInteractionText.text = "";
		}
		
		private function setStartingPositions():void
		{
			enemy1.x = 15;
			enemy1.y = FlxG.height / 2 - enemy1.height / 2;
			
			enemy2.x = FlxG.width / 2 - enemy2.width / 2;
			enemy2.y = 15;
			
			enemy3.x = FlxG.width - 15 - enemy3.width;
			enemy3.y = FlxG.height / 2 - enemy1.height / 2;
			
			enemy4.x = FlxG.width / 2 - enemy2.width / 2;
			enemy4.y = FlxG.height - 15 - enemy4.height;
			
			heroPlayer.x = FlxG.width / 2 - heroPlayer.width / 2;
			heroPlayer.y = FlxG.height / 2 - heroPlayer.height / 2;
		}
		
	}

}