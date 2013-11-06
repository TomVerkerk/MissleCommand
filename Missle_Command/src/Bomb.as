package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class Bomb 
	{
		[Embed(source = "../lib/boom.mp3")]
		public static var boom:Class;
		public static var boomSound:SoundChannel;
		private var volume:SoundTransform = new SoundTransform(1, 0);
		
		public function Bomb() 
		{
			boomSound = (new boom() as Sound).play(0, 0, volume);
		}
		
	}

}