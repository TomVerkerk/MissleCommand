package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import BombClass;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class Explosion extends Sprite
	{
		[Embed(source = "../lib/explosion1.png")]
		var explosion1:Class;
		var explosion1Bitmap:Bitmap = new explosion1;
		[Embed(source = "../lib/explosion2.png")]
		var explosion2:Class;
		var explosion2Bitmap:Bitmap = new explosion2;
		[Embed(source = "../lib/explosion3.png")]
		var explosion3:Class;
		var explosion3Bitmap:Bitmap = new explosion3;
		[Embed(source = "../lib/explosion4.png")]
		var explosion4:Class;
		var explosion4Bitmap:Bitmap = new explosion4;
		
		public var posX:Number;
		public var posY:Number;
		public var time:Number = 0;
		
		public function Explosion(_x,_y) 
		{
			explosion1Bitmap.x = _x - explosion1Bitmap.width / 2;
			explosion1Bitmap.y = _y - explosion1Bitmap.width / 2;
			explosion2Bitmap.x = explosion1Bitmap.x;
			explosion2Bitmap.y = explosion1Bitmap.y;
			explosion3Bitmap.x = explosion1Bitmap.x;
			explosion3Bitmap.y = explosion1Bitmap.y;
			explosion4Bitmap.x = explosion1Bitmap.x;
			explosion4Bitmap.y = explosion1Bitmap.y;
			addEventListener(Event.ENTER_FRAME, counter);
		}
		
		public function counter(e:Event):void {
			time += (1 / 29);
			addChild(explosion1Bitmap);
			if (time >= 0.1)
			{
				addChild(explosion2Bitmap);
				removeChild(explosion1Bitmap);
			}
			if (time >= 0.3)
			{
				addChild(explosion3Bitmap);
				removeChild(explosion2Bitmap);
			}
			if (time >= 0.5)
			{
				addChild(explosion4Bitmap);
				removeChild(explosion3Bitmap);
			}
			if (time >= 0.8)
			{
				removeChild(explosion4Bitmap);
			}
		}	
	}
}