package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class Highscore extends Sprite
	{
		public var Score1:TextField;
		public var Score2:TextField;
		public var Score3:TextField;
		public var format:TextFormat;
		public var highScore1:int;
		public var highScore2:int;
		public var highScore3:int;
		
		[Embed(source = "../lib/MicroExtendFLF.ttf", fontFamily = 'foo', embedAsCFF = 'false')]
		public var bar:String;
		
		public function Highscore() 
		{
			format = new TextFormat();
			format.color = 0x333333;
			format.size = 40;
			format.align = "center";
			format.font = "foo";
			
			Score1 = new TextField;
			Score1.defaultTextFormat = format;
			Score1.embedFonts = true;
			Score1.border = false;
			Score1.selectable = false;
			Score1.x = 300;
			Score1.y = 130;
			Score1.width = 400;
			Score1.height = 40;
			addChild(Score1);
			Score1.appendText
			
			Score2 = new TextField;
			Score2.defaultTextFormat = format;
			Score2.embedFonts = true;
			Score2.border = false;
			Score2.selectable = false;
			Score2.x = 300;
			Score2.y = 200;
			Score2.width = 400;
			Score2.height = 40;
			addChild(Score2);
			
			Score3 = new TextField;
			Score3.defaultTextFormat = format;
			Score3.embedFonts = true;
			Score3.border = false;
			Score3.selectable = false;
			Score3.x = 300;
			Score3.y = 270;
			Score3.width = 400;
			Score3.height = 40;
			addChild(Score3);
		}
		
		public function update():void
		{
			var scoreText1 = highScore1;
			Score1.text = "1.  " + scoreText1.toString();
			var scoreText2 = highScore2;
			Score2.text = "2.  " + scoreText2.toString();
			var scoreText3 = highScore3;
			Score3.text = "3.  " + scoreText3.toString();
		}
		
	}

}