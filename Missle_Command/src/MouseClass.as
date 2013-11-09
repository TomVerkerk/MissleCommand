package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.ContextMenuBuiltInItems;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class MouseClass extends Sprite
	{
		[Embed(source = "../lib/aim2.png")]
		public var aim:Class;
		public var aimBitmap:Bitmap = new aim;
		
		public function MouseClass() 
		{
			addEventListener(Event.ENTER_FRAME, Update);
			addChild(aimBitmap);
		}
		
		public function Update(e:Event):void {
			var DiffX:Number = mouseX;
			var Diffy:Number = mouseY;
			
			aimBitmap.x = DiffX - aimBitmap.width/2;
			aimBitmap.y = Diffy - aimBitmap.height/2;
			
		}
		
	}

}