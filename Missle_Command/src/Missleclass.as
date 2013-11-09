package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import BombClass;
	import flash.geom.Point;
	import flash.net.drm.DRMVoucherDownloadContext;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
			
	public class Missleclass extends Sprite
	{
		[Embed(source = "../lib/missle.png")]
		public var missle:Class;
		public var missleBitmap:Bitmap = new missle;
		
		public var hittedCity1:int;
		public var hittedCity2:int;
		public var hittedCity3:int;
		public var hittedCity4:int;
		public var start1:Number;
		public var start2:Number;
		public var random1:Number;
		public var random2:Number;
		public var full:Boolean;
		public var windX:Number;
		public var windY:Number;
						
		public function Missleclass():void 
		{
			windX = Math.random() - 0.5;
			windY = Math.random() + 0.8;
			
			update();
			missleBitmap.x = start1 + (Math.random() * random1) || start2 + (Math.random() * random2);
			missleBitmap.y = - 50 - Math.random() * 200;
			this.addChild(missleBitmap);
		}
		
		public function update():void
		{
			full = full;
			hittedCity1 = hittedCity1;
			hittedCity2 = hittedCity2;
			hittedCity3 = hittedCity3;
			hittedCity4 = hittedCity4;
			
			
			if (hittedCity1 >= 2)
			{
				if (hittedCity2 >= 2)
				{
					if (hittedCity3 >= 2)
					{
						start1 = 750;
						random1 = 250;
						start2 = 750;
						random2 = 250;
					}
					if (hittedCity4 >= 2)
					{
						start1 = 500;
						random1 = 250;
						start2 = 500;
						random2 = 250;
					}
					start1 = 500;
					random1 = 500;
					start2 = 500;
					random2 = 500;
				}
				if (hittedCity3 >= 2)
				{
					if (hittedCity4 >= 2)
					{
						start1 = 250;
						random1 = 250;
						start2 = 250;
						random2 = 250;
					}
					start1 = 250;
					random1 = 250;
					start2 = 750;
					random2 = 250;
				}
				if (hittedCity4 >= 2)
				{
					start1 = 250;
					random1 = 500;
					start2 = 250;
					random2 = 500;
				}
				start1 = 250;
				random1 = 750;
				start2 = 250;
				random2 = 750;
			}
			if (hittedCity2 >= 2)
			{
				if (hittedCity3 >= 2)
				{
					if (hittedCity4 >= 2)
					{
						start1 = 0;
						random1 = 250;
						start2 = 0;
						random2 = 250;
					}
					start1 = 0;
					random1 = 250;
					start2 = 750;
					random2 = 250;
				}
				if (hittedCity4 >= 2)
				{
					start1 = 0;
					random1 = 250;
					start2 = 500;
					random2 = 250;
				}
				start1 = 0;
				random1 = 250;
				start2 = 500;
				random2 = 500;
			}
			if (hittedCity3 >= 2)
			{
				if (hittedCity4 >= 2)
				{
					start1 = 0;
					random1 = 500;
					start2 = 0;
					random2 = 500;
				}
				start1 = 0;
				random1 = 500;
				start2 = 750;
				random2 = 250;
			}
			if (hittedCity4 >= 2)
			{
				start1 = 0;
				random1 = 750;
				start2 = 0;
				random2 = 750;
			}
			if (hittedCity1 < 2 && hittedCity2 < 2 && hittedCity4 < 2 && hittedCity3 < 2)
			{
				start1 = 0;
				random1 = 1000;
				start2 = 0;
				random2 = 1000;
			}
			
			missleBitmap.y += windY;
			missleBitmap.x += windX;
			missleBitmap.rotation += Math.random() * 4;
		}
	}
}