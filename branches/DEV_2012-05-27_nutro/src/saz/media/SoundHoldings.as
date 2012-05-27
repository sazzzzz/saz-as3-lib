package saz.media
{
	import flash.media.*;
	
	/**
	 * Sound関連インスタンスへの参照まとめ。
	 * @author saz
	 */
	public class SoundHoldings
	{
		
		/**
		 * Sound。
		 * @return 
		 */
		public function get sound():Sound
		{
			return _sound;
		}
		public function set sound(value:Sound):void
		{
			_sound = value;
		}
		private var _sound:Sound;
		
		/**
		 * SoundChannel。
		 * @return 
		 */
		public function get soundChannel():SoundChannel
		{
			return _soundChannel;
		}
		private var _soundChannel:SoundChannel;
		
		/**
		 * SoundTransform。
		 * @return 
		 */
		public function get soundTransform():SoundTransform
		{
			return soundChannel ? soundChannel.soundTransform : null;
		}
		private var _soundTransform:SoundTransform;
		
		
		/**
		 * コンストラクタ.
		 * @param targetSound	対象Sound.
		 */
		public function SoundHoldings(targetSound:Sound)
		{
			sound = targetSound;
		}
		
		
		/**
		 * サウンドを再生する SoundChannel オブジェクトを新しく作成します。サウンド再生には必ずこのメソッドを使うこと！
		 * @param startTime
		 * @param loops
		 * @param sndTransform
		 * @return 
		 */
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			_soundChannel = sound.play(startTime, loops, sndTransform);
			return soundChannel;
		}
		
		public function stop():void
		{
			if(soundChannel) soundChannel.stop();
		}
		
	}
}