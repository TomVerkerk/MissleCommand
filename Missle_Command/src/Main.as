package 
{
	import adobe.utils.CustomActions;
	import flash.automation.StageCaptureEvent;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.display.StageDisplayState;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import GunClass;
	import Missleclass;
	import BombClass;
	
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	[SWF(width = "1000", height = "500", frameRate = "29")]


	public class Main extends Sprite 
	{
		[Embed(source = "../lib/ground.png")]
		public var ground:Class;
		public var groundBitmap:Bitmap = new ground;		
		[Embed(source = "../lib/lucht2.png")]
		public var lucht:Class;
		public var luchtBitmap:Bitmap = new lucht;
		[Embed(source = "../lib/City.png")]
		public var city:Class;
		public var city01Bitmap:Bitmap = new city;
		public var city02Bitmap:Bitmap = new city;
		public var city03Bitmap:Bitmap = new city;
		public var city04Bitmap:Bitmap = new city;
		[Embed(source = "../lib/City1.png")]
		public var city1:Class;
		public var city11Bitmap:Bitmap = new city1;
		public var city12Bitmap:Bitmap = new city1;
		public var city13Bitmap:Bitmap = new city1;
		public var city14Bitmap:Bitmap = new city1;
		[Embed(source = "../lib/fullscreen.png")]
		public var fullScreen:Class;
		public var fullScreenBitmap:Bitmap = new fullScreen;
		[Embed(source = "../lib/City2.png")]
		public var city2:Class;
		public var city21Bitmap:Bitmap = new city2;
		public var city22Bitmap:Bitmap = new city2;
		public var city23Bitmap:Bitmap = new city2;
		public var city24Bitmap:Bitmap = new city2;
		[Embed(source = "../lib/Menu.png")]
		public var menuBackground:Class;
		public var menuBackgroundBitmap:Bitmap = new menuBackground;
		[Embed(source = "../lib/highscorebackground.png")]
		public var highScoreBackground:Class;
		public var highScoreBackgroundBitmap:Bitmap = new highScoreBackground;
		[Embed(source = "../lib/back.png")]
		public var back:Class;
		public var backBitmap:Bitmap = new back;
		
		public var paused:Boolean = true;
		public var pause:Boolean = false;
		public var time:Number = 0;
		public var levelCount:int = 1;
		public var bullets:int = 20;
		private var plane:PlaneClass = new PlaneClass;
		public var boom:Sound = new Sound;
		private var gun1:GunClass = new GunClass;
		private var gun2:GunClass = new GunClass;
		private var gun3:GunClass = new GunClass;
		
		public var removeButton:Boolean = false;
		private var missle:Missleclass = new Missleclass;
		public var start:Boolean = false;
		public var first:Boolean = false;
		public var click:Boolean = false;
		public var full:Boolean = false;
		public var inMenu:Boolean = true;
		public var music:Boolean = false;
		public var screenfull:Boolean = false;
		public var play:Boolean = false;
		public var hitsCity1:int;
		public var hitsCity2:int;
		public var hitsCity3:int;
		public var hitsCity4:int;
		public var removed:Boolean = false;
		public var score:int = 0;
		public var j :int;
		public var whitchCity1:Bitmap;
		public var whitchCity2:Bitmap;
		public var whitchCity3:Bitmap;
		public var whitchCity4:Bitmap;
		public var bombs:Vector.<BombClass>;
		public var missles:Vector.<Missleclass>;
		public var explosions:Vector.<Explosion>;
		
		public var timer:Number = 0;
		public var fallingMissles:int = 5;
		public var Scores:Highscore = new Highscore;
		public var HUD:GUI = new GUI;
		public var fullscreen:Sprite;
		public var backButton:Sprite;
		public var menu:Sprite;
		public var scoreButton:Sprite;
		public var shared:SharedObject = SharedObject.getLocal("Missle_Command_Highscore_Data","/");
		
		private var aim:MouseClass = new MouseClass;
										
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			shared.data.nr1;
			shared.data.nr2;
			shared.data.nr3;
			shared.data.date = new Date();
			Scores.highScore1 = shared.data.nr1;
			Scores.highScore2 = shared.data.nr2;
			Scores.highScore3 = shared.data.nr3;
			Scores.update();
			if (first == false)
			{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			bombs = new Vector.<BombClass>;
			missles = new Vector.<Missleclass>;
			explosions = new Vector.<Explosion>;
			first = true;
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, esc);
			play = false;
			Mouse.hide();
			addMenuBackground();
			makeGuns();
			stage.addEventListener(Event.ENTER_FRAME, updateGuns);
			drawGround();
			drawAim();
			addCity();
			Scorebutton();
			menuButton();
			if (full == false)
			{
			fullscreenButton();
			}
			if (full == true)
			{
			fullscreen.addEventListener(MouseEvent.CLICK, goNormalScreen);
			stage.addChild(fullscreen);
			stage.addChild(fullScreenBitmap);
			}
		}
		
		public function startGame():void  {
			hitsCity1 = 0;
			hitsCity2 = 0;
			hitsCity3 = 0;
			hitsCity4 = 0;
			stage.removeEventListener(Event.ENTER_FRAME, clickBulletUpdate);
			play = true;
			inMenu = false;
			removeChild(menu);
			removeChild(scoreButton);
			Mouse.hide();
			addLucht();
			addChild(plane);
			stage.addEventListener(MouseEvent.CLICK, shoot);
			makeGuns();
			drawGround();
			drawAim();
			if (music == false)
			{
				var theme:Theme = new Theme;
				music = true;
			}
			missleFactory(5);
			addChild(HUD);
			buttonBack();
			addEventListener(Event.ENTER_FRAME, GUIgame);
			stage.addEventListener(Event.ENTER_FRAME, updateBullet);
			addCity();
		}
		public function addMenuBackground():void {
			menuBackgroundBitmap.y = -150;
			addChild(menuBackgroundBitmap);
		}
		
		public function buttonBack():void {
			backBitmap.x = 900;
			backBitmap.y = 27;
			if (removeButton == false)
			{
			stage.addChild(backBitmap);
			}
			backButton = new Sprite();
			backButton.graphics.beginFill(0xFF0000, 0.0);
			backButton.graphics.lineStyle(1, 0x000000, 0.0, true);
			backButton.graphics.drawRect(900, 27, 100, 30);
			backButton.graphics.endFill();
			backButton.buttonMode = true;
			backButton.useHandCursor = true;
			backButton.mouseChildren = false;
			backButton.addEventListener(MouseEvent.CLICK, goToBack);
			if (removeButton == false)
			{
			stage.addChild(backButton);
			}
			removeButton = false;
		}
		
		public function fullscreenButton():void {
			fullScreenBitmap.x = 900;
			fullScreenBitmap.y = 0;
			stage.addChild(fullScreenBitmap);
			fullscreen = new Sprite();
			fullscreen.graphics.beginFill(0xFF0000, 0.0);
			fullscreen.graphics.lineStyle(1, 0x000000, 0.0, true);
			fullscreen.graphics.drawRect(900, 0, 100, 30);
			fullscreen.graphics.endFill();
			fullscreen.buttonMode = true;
			fullscreen.useHandCursor = true;
			fullscreen.mouseChildren = false;
			fullscreen.addEventListener(MouseEvent.CLICK, goFullscreen);
			stage.addChild(fullscreen);
		}
		
		public function updateGuns(e:Event):void {
			gun1.Update();
			gun2.Update();
			gun3.Update();
		}
		
		public function goToBack (e:MouseEvent):void {
			goBack();
		}
		public function goBack ():void
		{
			inMenu = true;
			stage.removeChild(fullScreenBitmap);
			stage.removeChild(fullscreen);
			stage.removeChild(backBitmap);
			stage.removeChild(backButton);
			stage.removeEventListener(Event.ENTER_FRAME, GUIgame);
			stage.removeEventListener(Event.ENTER_FRAME, updateBullet);
			stage.removeEventListener(MouseEvent.CLICK, shoot);
			bombs.splice(0, bombs.length);
			missles.splice(0, missles.length);
			explosions.splice(0, explosions.length);
			levelCount = 1;
			fallingMissles = 5;
			score = 0;
			bullets = 20;
			init();
		}
		
		
		public function addLucht ():void {
			luchtBitmap.y = -200;
			addChild(luchtBitmap);
		}
		
		public function goFullscreen(e:Event):void
		{
			full = true;
			screenfull = true;
			fullscreen.removeEventListener(MouseEvent.CLICK, goFullscreen);
			fullscreen.addEventListener(MouseEvent.CLICK, goNormalScreen);
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		public function Scorebutton():void {
			scoreButton = new Sprite();
			scoreButton.graphics.beginFill(0xFF0000, 0.0);
			scoreButton.graphics.lineStyle(1, 0x000000, 0.0, true);
			scoreButton.graphics.drawRect(410, 274, 249, 76);
			scoreButton.graphics.endFill();
			scoreButton.buttonMode = true;
			scoreButton.useHandCursor = true;
			scoreButton.mouseChildren = false;
			scoreButton.addEventListener(MouseEvent.CLICK, startBooleanFalse);
			scoreButton.addEventListener(MouseEvent.CLICK, buttonClicked);
			addChild(scoreButton);
		}
		
		public function menuButton():void {
			menu = new Sprite();
			menu.graphics.beginFill(0xFF0000, 0.0);
			menu.graphics.lineStyle(1, 0x000000, 0.0, true);
			menu.graphics.drawRect(410, 153, 249, 76);
			menu.graphics.endFill();
			menu.buttonMode = true;
			menu.useHandCursor = true;
			menu.mouseChildren = false;
			menu.addEventListener(MouseEvent.CLICK, startBooleanTrue);
			menu.addEventListener(MouseEvent.CLICK, buttonClicked);
			addChild(menu);
		}
		
		public function startBooleanTrue(e:MouseEvent):void {
			start = true;
		}
		
		public function startBooleanFalse(e:MouseEvent):void {
			start = false;
		}
		
		public function buttonClicked(e:MouseEvent):void {
			var bomb:BombClass = new BombClass;
			var sound:Shoot = new Shoot;
			bombs.push(bomb);
			this.addChild(bomb);
			time = 0;
			stage.addEventListener(Event.ENTER_FRAME, clickBulletUpdate);
			menu.removeEventListener(MouseEvent.CLICK, buttonClicked);
			scoreButton.removeEventListener(MouseEvent.CLICK, buttonClicked);
		}
		
		public function clickBulletUpdate (e:Event):void {
			time += 1 / 29;
			var l : int = bombs.length;
			for (var i : int = l-1 ; i >=0 ; i-- )
			{
				bombs[i].update();
				if (bombs[i].bombBitmap.y <= bombs[i].posY && bombs[i].parent == this)
				{
					this.removeChild(bombs[i]);
					var explosion:Explosion = new Explosion(bombs[i].posX, bombs[i].posY);
					explosions.push(explosion);
					this.addChild(explosion);
					var boom:Bomb = new Bomb;
				}
			}			
			var explosionTotal : int = explosions.length;
			for (var ex : int = explosionTotal -1; ex > -1; ex --) {
				if (time >= 1.2) {
					explosions.splice(ex, 1);
					if (start == true)
					{
						startGame();
					}
					if (start == false)
					{
						Highscores();
					}
				}
			}
			
		}
		
		public function Highscores():void {
			inMenu = false;
			removeChild(scoreButton);
			removeChild(menu);
			addHighscoreBackground();
			makeGuns();
			drawGround();
			drawAim();
			addCity();
			Scores.update();
			buttonBack();
			if (full == false)
			{
			fullscreenButton();
			}
			if (full == true)
			{
			fullscreen.addEventListener(MouseEvent.CLICK, goNormalScreen);
			stage.addChild(fullscreen);
			stage.addChild(fullScreenBitmap);
			}
			addChild(Scores);
			}
			
		public function addHighscoreBackground():void {
			highScoreBackgroundBitmap.y = -150;
			addChild(highScoreBackgroundBitmap);
		}
		
		public function esc (e:KeyboardEvent):void {
			if (e.charCode == 112 && play == true && pause == true)
			{
				stage.addEventListener(Event.ENTER_FRAME, updateGuns);
				stage.addEventListener(Event.ENTER_FRAME, updateBullet);
				stage.addEventListener(MouseEvent.CLICK, shoot);
				pause = false;
				paused = false;
			}
			if (e.charCode == 112 && play == true && pause == false && paused == true)
			{
				stage.removeEventListener(Event.ENTER_FRAME, updateGuns);
				stage.removeEventListener(Event.ENTER_FRAME, updateBullet);
				stage.removeEventListener(MouseEvent.CLICK, shoot);
				pause = true;
			}
			paused = true;
			if (e.charCode == 27 && full == true)
			{
				full = false;
				stage.displayState = StageDisplayState.NORMAL;
				fullscreen.addEventListener(MouseEvent.CLICK, goFullscreen);
				fullscreen.removeEventListener(MouseEvent.CLICK, goNormalScreen);
				screenfull = false;
			}
		}
			
		public function goNormalScreen (e:MouseEvent):void {
			full = false;
			stage.displayState = StageDisplayState.NORMAL;
			fullscreen.addEventListener(MouseEvent.CLICK, goFullscreen);
			fullscreen.removeEventListener(MouseEvent.CLICK, goNormalScreen);
			screenfull = false;
		}
		
		public function gainScore(gain:int):void {
			score = score + gain;
			if (score >= Scores.highScore3 && score < Scores.highScore2)
			{
				shared.data.nr3 = score;
			}
			if (score >= Scores.highScore2 && score < Scores.highScore1)
			{
				shared.data.nr2 = score
			}
			if (score >= Scores.highScore1)
			{
				shared.data.nr1 = score;
			}
			shared.flush();
		}
		
		public function missleFactory(missleCount:int):void {
			
			for (var i:int = 0; i < missleCount; i++) 
			{
				var missle:Missleclass = new Missleclass;
				missles.push(missle);
				this.addChild(missle);
			}
		}
		
		public function drawAim():void {
			
			addChild(aim);
		}
				
		public function makeGuns():void {
			gun1.x = 55;
			gun1.y = 445;
			addChild(gun1);
			
			gun2.x = 495;
			gun2.y = 460;
			addChild(gun2);
			
			gun3.x = 953;
			gun3.y = 453;
			addChild(gun3);
		}
		
		public function GUIgame (e:Event):void
		{
			HUD.levelnumber = levelCount;
			HUD.bulletCount = bullets;
			HUD.giveScore = score;
			HUD.update();
		}
		
		public function removeCity (vervang:Bitmap, met:Bitmap):void
		{
			met.x = vervang.x;
			met.y = vervang.y;
			addChild(met);
			removeChild(vervang);
		}
		
		public function addCity ():void
		{
			city01Bitmap.x = 160;
			city01Bitmap.y = 462;
			addChild(city01Bitmap);
			city02Bitmap.x = 316;
			city02Bitmap.y = 451;
			addChild(city02Bitmap);
			city03Bitmap.x = 578;
			city03Bitmap.y = 453;
			addChild(city03Bitmap);
			city04Bitmap.x = 730;
			city04Bitmap.y = 465;
			addChild(city04Bitmap);
		}
		
		public function drawGround():void {
			groundBitmap.y = 300;
			addChild(groundBitmap);
		}
			
		public function shoot(e:MouseEvent):void {
			if (bullets > 0)
			{
			var bomb:BombClass = new BombClass;
			var sound:Shoot = new Shoot;
			bombs.push(bomb);
			this.addChild(bomb);
			bullets -= 1;
			}
		}
		
		public function updateBullet(e:Event):void
		{
			if (missles.length == 0)
			{
				if (play == true)
				{
				fallingMissles = fallingMissles + 3;
				levelCount = levelCount + 1;
				bullets = bullets + (fallingMissles);
				missleFactory(fallingMissles);
				}
			}
			var l : int = bombs.length;
			for (var i : int = l-1 ; i > -1 ; i-- )
			{
				bombs[i].update();
				if (bombs[i].bombBitmap.y <= bombs[i].posY && bombs[i].parent == this)
				{
					this.removeChild(bombs[i]);
					var explosion:Explosion = new Explosion(bombs[i].posX, bombs[i].posY);
					bombs.splice(i, 1);
					explosions.push(explosion);
					this.addChild(explosion);
					var boom:Bomb = new Bomb;
				}
			}	
			var explosionTotal : int = explosions.length;
			for (var ex : int = explosionTotal -1; ex > -1; ex --) {
				if (explosions[ex].time >= 1) {
					explosions.splice(ex, 1);
				}
			}
			if (hitsCity1 >= 2 && hitsCity2 >= 2 && hitsCity3 >= 2 && hitsCity4 >= 2)
				{
					timer += 1 / 29;
					if (timer > 0.8)
					{
					removeButton = true;
					timer = 0;
					Scores.update();
					goBack();
					}
				}
			var m : int = missles.length;
			for (j = m-1; j > -1; j--)
			{
				missles[j].level = levelCount;
				missles[j].hitCity1 = hitsCity1;
				missles[j].hitCity2 = hitsCity2;
				missles[j].hitCity3 = hitsCity3;
				missles[j].hitCity4 = hitsCity4;
				missles[j].update();
				for (var q : int = 0; q < explosions.length; q++ )
				{
					var explosion2 = explosions[q];
					if (missles[j].missleBitmap.x > explosion2.explosion1Bitmap.x &&
						missles[j].missleBitmap.x < explosion2.explosion1Bitmap.x + explosion2.explosion1Bitmap.width &&
						missles[j].missleBitmap.y > explosion2.explosion1Bitmap.y &&
						missles[j].missleBitmap.y < explosion2.explosion1Bitmap.y + explosion2.explosion1Bitmap.height)
						{
							var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
							explosions.push(explosion);
							this.addChild(explosion);
							this.removeChild(missles[j]);
							missles.splice(j, 1);
							gainScore(20);
							var boom:Bomb = new Bomb;
							removed = true;
							break;
						}
				}
			if (removed == true)
			{
				removed = false;
				break;
			}
			if (missles[j].missleBitmap.x < 0 || missles[j].missleBitmap.x > 1010)
			{
				this.removeChild(missles[j]);
				missles.splice(j, 1);
				removed = true;
				break;
			}
			if (removed == true)
			{
				removed = false;
				break;
			}
			
			if (missles[j].missleBitmap.x > 160 &&
				missles[j].missleBitmap.x < 160 + city01Bitmap.width &&
				missles[j].missleBitmap.y > 482 &&
				missles[j].missleBitmap.y < 462 + city01Bitmap.height)
				{
					hitsCity1 = hitsCity1 + 1;
					if (hitsCity1 == 1)
					{
						removeCity(city01Bitmap, city11Bitmap); 
					}
					if (hitsCity1 == 2)
					{
						removeCity(city11Bitmap, city21Bitmap);
					}
					var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
					explosions.push(explosion);
					this.addChild(explosion);
					this.removeChild(missles[j]);
					missles.splice(j, 1);
					var boom:Bomb = new Bomb;
					removed = true;
					break;
				}
			if (removed == true)
			{
				removed = false;
				break;
			}
			if (missles[j].missleBitmap.x > 316 &&
				missles[j].missleBitmap.x < 316 + city02Bitmap.width &&
				missles[j].missleBitmap.y > 471 &&
				missles[j].missleBitmap.y < 451 + city02Bitmap.height)
				{
					hitsCity2 = hitsCity2 + 1;
					if (hitsCity2 == 1)
					{
						removeCity(city02Bitmap, city12Bitmap);
					}
					if (hitsCity2 == 2)
					{
						removeCity(city12Bitmap, city22Bitmap);
					}
					var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
					explosions.push(explosion);
					this.addChild(explosion);
					this.removeChild(missles[j]);
					missles.splice(j, 1);
					var boom:Bomb = new Bomb;
					removed = true;
					break;
				}
			if (removed == true)
			{
				removed = false;
				break;
			}
			if (missles[j].missleBitmap.x > 578 &&
				missles[j].missleBitmap.x < 578 + city03Bitmap.width &&
				missles[j].missleBitmap.y > 473 &&
				missles[j].missleBitmap.y < 453 + city03Bitmap.height)
				{
					hitsCity3 = hitsCity3 + 1;
					if (hitsCity3 == 1)
					{
						removeCity( city03Bitmap, city13Bitmap);
					}
					if (hitsCity3 == 2)
					{
						removeCity(city13Bitmap, city23Bitmap);
					}
					var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
					explosions.push(explosion);
					this.addChild(explosion);
					this.removeChild(missles[j]);
					missles.splice(j, 1);
					var boom:Bomb = new Bomb;
					removed = true;
					break;
				}
			if (removed == true)
			{
				removed = false;
				break;
			}
			if (missles[j].missleBitmap.x > 730 &&
				missles[j].missleBitmap.x < 730 + city04Bitmap.width &&
				missles[j].missleBitmap.y > 485 &&
				missles[j].missleBitmap.y < 465 + city04Bitmap.height)
				{
					hitsCity4 = hitsCity4 + 1;
					if (hitsCity4 == 1)
					{
						removeCity(city04Bitmap, city14Bitmap);
					}
					if (hitsCity4 == 2)
					{
						removeCity(city14Bitmap, city24Bitmap);
					}
					var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
					explosions.push(explosion);
					this.addChild(explosion);
					this.removeChild(missles[j]);
					missles.splice(j, 1);
					var boom:Bomb = new Bomb;
					removed = true;
					break;
				}
			if (removed == true)
			{
				removed = false;
				break;
			}
			if (missles[j].missleBitmap.y > 480 + city04Bitmap.height)
				{
					var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
					explosions.push(explosion);
					this.addChild(explosion);
					this.removeChild(missles[j]);
					missles.splice(j, 1);
					var boom:Bomb = new Bomb;
					removed = true;
					break;
				}
			if (removed == true)
				{
					removed = false;
					break;
				}
			}
		}
	}		
}