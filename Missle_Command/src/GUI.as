package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class GUI extends Sprite
	{
		public var level:TextField;
		public var bullet:TextField;
		public var box:TextField;
		public var format:TextFormat;
		public var giveScore:int;
		public var bulletCount:int;
		public var levelnumber:int;
		
		[Embed(source = "../lib/MicroExtendFLF.ttf", fontFamily = 'foo', embedAsCFF = 'false')]
		public var bar:String;
		
		public function GUI() 
		{
			format = new TextFormat();
			format.color = 0x333333;
			format.size = 13;
			format.align = "center";
			format.font = "foo";
			
			level = new TextField;
			level.defaultTextFormat = format;
			level.embedFonts = true;
			level.border = false;
			level.selectable = false;
			level.y = 10;
			level.width = 150;
			level.height = 40;
			addChild(level);
			
			box = new TextField;
			box.defaultTextFormat = format;
			box.embedFonts = true;
			box.border = false;
			box.selectable = false;
			box.y = 40;
			box.width = 150;
			box.height = 40;
			addChild(box);
			
			bullet = new TextField;
			bullet.defaultTextFormat = format;
			bullet.embedFonts = true;
			bullet.border = false;
			bullet.selectable = false;
			bullet.y = 70;
			bullet.width = 150;
			bullet.height = 40;
			addChild(bullet);
		}
		
		public function update():void
		{
			var levelcount:int = levelnumber;
			level.text = "Level : " + levelcount.toString();
			var bullets:int = bulletCount;
			bullet.text = "Bullets : " + bullets.toString();
			var score:int = giveScore;
			box.text = "Score : " + score.toString();
		}
	}

}