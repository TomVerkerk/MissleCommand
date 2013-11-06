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
		
		public var windX:Number;
		public var windY:Number;
						
		public function Missleclass():void 
		{
			windX = Math.random() - 0.5;
			windY = Math.random() + 0.8;
			
			missleBitmap.x = Math.random() * 1000;
			missleBitmap.y = -Math.random() * 200;
			this.addChild(missleBitmap);
		}
		
		public function update():void
		{
			missleBitmap.y += windY;
			missleBitmap.x += windX;
			missleBitmap.rotation += Math.random() * 4;
		}
	}
}