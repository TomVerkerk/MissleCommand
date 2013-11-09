package 
{
	import adobe.utils.CustomActions;
	import flash.automation.StageCaptureEvent;
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
		
		public var levelCount:int = 1;
		public var bullets:int = 20;
		private var plane:PlaneClass = new PlaneClass;
		public var boom:Sound = new Sound;
		private var gun1:GunClass = new GunClass;
		private var gun2:GunClass = new GunClass;
		private var gun3:GunClass = new GunClass;
		
		public var inMenu:Boolean = true;
		public var full:Boolean = false;
		public var shots:int = 0;
		public var music:Boolean = false;
		public var screenfull:Boolean = false;
		public var play:Boolean = false;
		public var hitCity1:int =0;
		public var hitCity2:int =0;
		public var hitCity3:int =0;
		public var hitCity4:int =0;
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
		
		public var fallingMissles:int = 5;
		public var Scores:Highscore = new Highscore;
		public var HUD:GUI = new GUI;
		public var fullscreen:Sprite;
		public var menu:Sprite;
		public var scoreButton:Sprite;
		
		private var aim:MouseClass = new MouseClass;
										
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, returnToMenu);
			bombs = new Vector.<BombClass>;
			missles = new Vector.<Missleclass>;
			explosions = new Vector.<Explosion>;
			play = false;
			Mouse.show();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addMenuBackground();
			Scorebutton();
			menuButton();
			drawGround();
			if (full == false)
			{
			fullscreenButton();
			}
			if (music == false)
			{
				var theme:Theme = new Theme;
				music = true;
			}
		}
		
		public function startGame(e:Event):void  {
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
			//if (full == false && added == false)
			//{
			//	fullscreenButton();
			//}
			missleFactory(5);
			addChild(HUD);
			addEventListener(Event.ENTER_FRAME, GUIgame);
			addEventListener(Event.ENTER_FRAME, updateBullet);
			addCity();
		}
		public function addMenuBackground():void {
			menuBackgroundBitmap.y = -150;
			addChild(menuBackgroundBitmap);
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
		
		public function addLucht ():void {
			luchtBitmap.y = -200;
			addChild(luchtBitmap);
		}
		
		public function goFullscreen(e:Event):void
		{
			full = true;
			stage.removeChild(fullScreenBitmap);
			stage.removeChild(fullscreen);
			screenfull = true;
			stage.displayState = StageDisplayState.FULL_SCREEN;
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
			menu.addEventListener(MouseEvent.CLICK, startGame);
			addChild(menu);
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
			scoreButton.addEventListener(MouseEvent.CLICK, Highscores);
			addChild(scoreButton);
		}
		
		public function Highscores(e:Event):void {
			inMenu = false;
			removeChild(scoreButton);
			removeChild(menu);
			addHighscoreBackground();
			drawGround();
			Scores.update();
			if (full == false)
			{
			fullscreenButton();
			}
			addChild(Scores);
			}
			
		public function addHighscoreBackground():void {
			highScoreBackgroundBitmap.y = -150;
			addChild(highScoreBackgroundBitmap);
		}
			
		public function returnToMenu (e:KeyboardEvent):void {
			if (e.charCode == 27 && full == true)
			{
				full = false;
				screenfull = false;
				fullscreenButton();
			}
			if (e.charCode == 8 && inMenu == false)
			{
				inMenu = true;
				if (full == false)
				{
				stage.removeChild(fullScreenBitmap);
				stage.removeChild(fullscreen);
				}
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, returnToMenu);
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
		}
		
		public function gainScore(gain:int):void {
			score = score + gain;
			if (score >= Scores.highScore3 && score < Scores.highScore2)
			{
				Scores.highScore3 = score;
			}
			if (score >= Scores.highScore2 && score < Scores.highScore1)
			{
				Scores.highScore2 = score
			}
			if (score >= Scores.highScore1)
			{
				Scores.highScore1 = score;
			}
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
				
		private function makeGuns():void {
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
			shots = shots + 1
			if (bullets > 0 && shots > 1)
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
			var l : int = bombs.length;
			var explosionTotal : int = explosions.length;
			if (missles.length == 0)
			{
				if (play == true)
				{
				fallingMissles = fallingMissles + 3;
				levelCount = levelCount + 1;
				bullets = bullets + (fallingMissles/1.5);
				missleFactory(fallingMissles);
				}
			}
			for (var i : int = l-1 ; i >=0 ; i-- )
			{
				if (bombs[i].bombBitmap.y <= bombs[i].posY && bombs[i].parent == this)
				{
					this.removeChild(bombs[i]);
					var explosion:Explosion = new Explosion(bombs[i].posX, bombs[i].posY);
					explosions.push(explosion);
					this.addChild(explosion);
					var boom:Bomb = new Bomb;
				}
			}			
			for (var ex : int = explosionTotal -1; ex > -1; ex --) {
				if (explosions[ex].time >= 1) {
					explosions.splice(ex, 1);
				}
			}
			if (hitCity1 >= 2 && hitCity2 >= 2 && hitCity3 >= 2 && hitCity4 >= 2)
				{
				addChild(fullScreenBitmap);
				addChild(fullscreen);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, returnToMenu);
				stage.removeEventListener(Event.ENTER_FRAME, GUIgame);
				stage.removeEventListener(Event.ENTER_FRAME, updateBullet);
				stage.removeEventListener(MouseEvent.CLICK, shoot);
				bombs.splice(0, bombs.length);
				missles.splice(0, missles.length);
				explosions.splice(0, explosions.length);
				levelCount = 1;
				fallingMissles = 5;
				score = 0;
				bullets = 50;
				init();
				}
			var m : int = missles.length;
			for (j = m-1; j > -1; j--)
			{
				missles[j].hittedCity1 = hitCity1;
				missles[j].hittedCity2 = hitCity2;
				missles[j].hittedCity3 = hitCity3;
				missles[j].hittedCity4 = hitCity4;
				
				missles[j].update();
				for (var q : int = 0; q < explosions.length; q++ )
				{
					var explosion = explosions[q];
					if (missles[j].missleBitmap.x > explosion.explosion1Bitmap.x &&
						missles[j].missleBitmap.x < explosion.explosion1Bitmap.x + explosion.explosion1Bitmap.width &&
						missles[j].missleBitmap.y > explosion.explosion1Bitmap.y &&
						missles[j].missleBitmap.y < explosion.explosion1Bitmap.y + explosion.explosion1Bitmap.height)
						{
							var explosion:Explosion = new Explosion(missles[j].missleBitmap.x, missles[j].missleBitmap.y);
							explosions.push(explosion);
							this.addChild(explosion);
							this.removeChild(missles[j]);
							missles.splice(j, 1);
							gainScore(20);
							var boom:Bomb = new Bomb;
							j = missles.length - 1;
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
				missles[j].missleBitmap.y > 462 &&
				missles[j].missleBitmap.y < 462 + city01Bitmap.height)
				{
					hitCity1 = hitCity1 + 1;
					if (hitCity1 == 1)
					{
						removeCity(city01Bitmap, city11Bitmap); 
					}
					if (hitCity1 == 2)
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
				missles[j].missleBitmap.y > 451 &&
				missles[j].missleBitmap.y < 451 + city02Bitmap.height)
				{
					hitCity2 = hitCity2 + 1;
					if (hitCity2 == 1)
					{
						removeCity(city02Bitmap, city12Bitmap);
					}
					if (hitCity2 == 2)
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
				missles[j].missleBitmap.y > 453 &&
				missles[j].missleBitmap.y < 453 + city03Bitmap.height)
				{
					hitCity3 = hitCity3 + 1;
					if (hitCity3 == 1)
					{
						removeCity( city03Bitmap, city13Bitmap);
					}
					if (hitCity3 == 2)
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
				missles[j].missleBitmap.y > 465 &&
				missles[j].missleBitmap.y < 465 + city04Bitmap.height)
				{
					hitCity4 = hitCity4 + 1;
					if (hitCity4 == 1)
					{
						removeCity(city04Bitmap, city14Bitmap);
					}
					if (hitCity4 == 2)
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