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
		public var box:TextField;
		public var format:TextFormat;
		public var giveScore:int;
		
		[Embed(source = "../lib/MicroExtendFLF.ttf", fontFamily = 'foo', embedAsCFF = 'false')]
		public var bar:String;
		
		public function GUI() 
		{
			format = new TextFormat();
			format.color = 0x333333;
			format.size = 10;
			format.align = "center";
			format.font = "foo";
			
			box = new TextField;
			box.defaultTextFormat = format;
			box.embedFonts = true;
			box.border = true;
			box.selectable = false;
			box.width = 70;
			box.height = 20;
			box.text = "hallo";
			addEventListener(Event.ENTER_FRAME, setScore);
			addChild(box);
		}
		
		public function setScore(e:Event):void
		{
			box.text = "Score : " + giveScore;
		}
		
	}

}