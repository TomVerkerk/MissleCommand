package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class GunClass extends Sprite
	{
		[Embed(source = "../lib/gun.png")]
		public var gunImg:Class;
		public var gun1Bitmap:Bitmap = new gunImg;		
		
		public function GunClass():void
		{
			gun1Bitmap.x = -gun1Bitmap.width / 2;
			gun1Bitmap.y = -gun1Bitmap.height * (2/3);
			
			addEventListener(Event.ENTER_FRAME, Update);
			addChild(gun1Bitmap);
		}
		
		private function Update(e:Event):void
		{
			this.rotation = 180;
			var diff_X:Number = mouseX;
			var diff_Y:Number = mouseY;
			
			var radians:Number = Math.atan2(diff_X, diff_Y);
			var degrees:Number = radians * -180 / Math.PI;
			if (degrees > 90)
			{
				degrees = 90;
			}
			if (degrees < -90)
			{
				degrees = -90;
			}
			this.rotation = degrees;
		}
	}
}