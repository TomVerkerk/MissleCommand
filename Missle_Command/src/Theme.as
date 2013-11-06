package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Tom Verkerk
	 */
	public class Theme 
	{
		[Embed(source="../lib/missle_command.mp3")]
		public static var theme:Class;
		public static var themeSong:SoundChannel;
		private var volume:SoundTransform = new SoundTransform(0.1, 0);
		
		public function Theme() 
		{
			themeSong = (new theme() as Sound).play(0, int.MAX_VALUE, volume);
		}
		
	}

}