package  
{
	import flash.display.Bitmap;
	import flash.display.NativeMenuItem;
	import flash.display.Sprite;
	import flash.events.Event;
	import Missleclass;
	import Main;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class BombClass extends Sprite
	{
		[Embed(source = "../lib/bomb.png")]
		public var bomb:Class;
		public var bombBitmap:Bitmap = new bomb;
		
		public var aim:MouseClass = new MouseClass;
		public var xDirection:Number;
		public var yDirection:Number;
		public var xDiff:Number;
		public var yDiff:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var speed:int = 10;
		public var posX:Number;
		public var posY:Number;
		
		public function BombClass():void
		{
			posX = mouseX + aim.width / 2;
			posY = mouseY + aim.width / 2;
			if (posX <= 275)
			{
				bombBitmap.x = 55;
				bombBitmap.y = 445;
			}
			if (posX >= 724)
			{
				bombBitmap.x = 953;
				bombBitmap.y = 453;
			}
			if(posX >= 275 && posX <= 724)
			{
				bombBitmap.x = 495;
				bombBitmap.y = 460;
			}
			var changeInX:Number = bombBitmap.x - posX;
			var changeInY:Number = bombBitmap.y - posY;
			var radians:Number = Math.atan2(changeInY, changeInX);
			var degrees:Number = radians * 180 / Math.PI;
			xDirection = (posX - bombBitmap.x >=0)?1:-1;
			yDirection = (posY - bombBitmap.y >=0)?1:-1;
			xDiff = posX - bombBitmap.x;
			yDiff = posY - bombBitmap.y;
			xSpeed = speed * Math.abs(xDiff / yDiff) * xDirection;
			ySpeed = speed * Math.abs(yDiff / xDiff) * yDirection;
			if (Math.abs(xSpeed) > speed)
			{
				xSpeed=speed*xDirection;
			}
			if (Math.abs(ySpeed) > speed)
			{
				ySpeed=speed*yDirection;
			}
			addEventListener(Event.ENTER_FRAME, update);
			this.addChild(bombBitmap);
		}
		
		public function update(e:Event): void
		{
			bombBitmap.x += xSpeed;
			bombBitmap.y += ySpeed;
		}
	}
}