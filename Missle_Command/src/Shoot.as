package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class Shoot 
	{
		[Embed(source = "../lib/shoot.mp3")]
		public static var shoot:Class;
		public static var shootSound:SoundChannel;
		private var volume:SoundTransform = new SoundTransform(1, 0);
		
		public function Shoot() 
		{
			shootSound = (new shoot() as Sound).play(0, 0, volume);
		}
		
	}

}