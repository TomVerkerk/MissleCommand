package  
{
	import flash.display.Bitmap;
	import flash.display.InterpolationMethod;
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
		
		public var level:int;
		public var rotate:Number;
		public var hitCity1:int;
		public var hitCity2:int;
		public var hitCity3:int;
		public var hitCity4:int;
		public var placed:Boolean = false;
		public var random1:int;
		public var random2:int;
		public var start1:int = 0;
		public var start2:int;
		public var windX:Number;
		public var windY:Number;
						
		public function Missleclass():void 
		{
			rotate = (Math.random() - 0.5) * 8;
			windX = Math.random() - 0.5;
			if (level <= 9)
			{
				windY = Math.random() + 0.8;
			}
			if (level > 9)
			{
				windY = Math.random() * 2 + 0.8;
			}
			missleBitmap.x = 0;
			if (level <= 9)
			{
			missleBitmap.y = - 50 - Math.random() * 200;
			}
			if (level > 9)
			{
				missleBitmap.y = -50 - Math.random() * 400;
			}
			this.addChild(missleBitmap);
		}
		
		public function update():void
		{
			missleBitmap.y += windY;
			missleBitmap.x += windX;
			missleBitmap.rotation += rotate;
			
			if (hitCity1 >= 2)
			{
				if (hitCity2 >= 2)
				{
					if (hitCity3 >= 2)
					{
						start1 = 750;
						random1 = 250;
						start2 = 750;
						random2 = 250;
					}
					if (hitCity4 >= 2)
					{
						start1 = 500;
						random1 = 250;
						start2 = 500;
						random2 = 250;
					}
					if (hitCity3 < 2 && hitCity4 < 2)
					{
					start1 = 500;
					random1 = 500;
					start2 = 500;
					random2 = 500;
					}
				}
				if (hitCity3 >= 2)
				{
					if (hitCity4 >= 2 && hitCity2 <2)
					{
						start1 = 250;
						random1 = 250;
						start2 = 250;
						random2 = 250;
					}
					if (hitCity4 < 2 && hitCity2 <2)
					{
						start1 = 250;
						random1 = 250;
						start2 = 750;
						random2 = 250;
					}
				}
				if (hitCity4 >= 2)
				{
					if (hitCity2 < 2 && hitCity3 < 2)
					{
					start1 = 250;
					random1 = 500;
					start2 = 250;
					random2 = 500;
					}
				}
				if (hitCity2 < 2 && hitCity3 < 2 && hitCity4 < 2)
				{
				start1 = 250;
				random1 = 750;
				start2 = 250;
				random2 = 750;
				}
			}
			if (hitCity2 >= 2)
			{
				if (hitCity3 >= 2)
				{
					if (hitCity4 >= 2 && hitCity1 <2)
					{
						start1 = 0;
						random1 = 250;
						start2 = 0;
						random2 = 250;
					}
					if (hitCity4 < 2 && hitCity1 <2)
					{
						start1 = 0;
						random1 = 250;
						start2 = 750;
						random2 = 250;
					}
				}
				if (hitCity4 >= 2)
				{
					if (hitCity1 < 2 && hitCity3 < 2)
					{
					start1 = 0;
					random1 = 250;
					start2 = 500;
					random2 = 250;
					}
				}
				if (hitCity1 <2 && hitCity3 < 2 && hitCity4 < 2)
				{
				start1 = 0;
				random1 = 250;
				start2 = 500;
				random2 = 500;
				}
			}
			if (hitCity3 >= 2)
			{
				if (hitCity4 >= 2 && hitCity1 <2 && hitCity2 <2)
				{
					start1 = 0;
					random1 = 500;
					start2 = 0;
					random2 = 500;
				}
				if (hitCity4 < 2 && hitCity1 <2 && hitCity2 <2)
				{
				start1 = 0;
				random1 = 500;
				start2 = 750;
				random2 = 250;
				}
			}
			if (hitCity4 >= 2 && hitCity1 <2 && hitCity2 <2 && hitCity3 <2)
			{
				start1 = 0;
				random1 = 750;
				start2 = 0;
				random2 = 750;
			}
			if (hitCity1 < 2 && hitCity2 < 2 && hitCity4 < 2 && hitCity3 < 2)
			{
				start1 = 0;
				random1 = 1000;
				start2 = 0;
				random2 = 1000;
			}
			if (placed == false)
			{
				var random = Math.random();
				if (random < 0.5)
				{
					missleBitmap.x = start1 + (Math.random() * random1);
				}
				if (random >= 0.5)
				{
					missleBitmap.x = start2 + (Math.random() * random2);
				}
				placed = true;
			}
		}
	}
}


