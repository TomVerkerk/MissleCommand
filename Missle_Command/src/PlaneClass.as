package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class PlaneClass extends Sprite
	{
		[Embed(source="../lib/plane3.png")]
		public var plane:Class;
		public var planeBitmap:Bitmap = new plane;
		
		public var time:Number = 0;
		
		public function PlaneClass() 
		{
			planeBitmap.x = 1100;
			planeBitmap.y = 200;
			addChild(planeBitmap);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(e:Event):void
		{
			time += (1 / 29);
			if (time >= 0)
			{
				planeBitmap.x -= 5;
			}
			if (time >= 15)
			{
				planeBitmap.x += 10;
				planeBitmap.scaleX = -1;
			}
			if (planeBitmap.x >= 1150)
			{
				planeBitmap.scaleX = 1;
				time = 0;
			}
		}
		
	}

}