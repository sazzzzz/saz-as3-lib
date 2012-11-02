package saz.media
{
	import flash.media.*;
	
	import saz.util.ObjectUtil;

	/**
	 * Sound.play()前にSoundTransformのプロパティを預かる。…Sound.play()の引数にSoundTransformを指定できるからいらないじゃん！
	 * @deprecated	Sound.play()の引数にSoundTransformを指定できるからいらないじゃん！
	 * @author saz
	 */
	public class SoundTransformRegister
	{
		
		
		private var _sound:Sound;
		public function get sound():Sound
		{
			return _sound;
		}
		public function set sound(value:Sound):void
		{
			_sound = value;
			soundHoldings.sound = value;
		}
		
		
		public function get soundHoldings():SoundHoldings
		{
			if(!_soundHoldings) _soundHoldings = new SoundHoldings(sound);
			return _soundHoldings;
		}
		private var _soundHoldings:SoundHoldings;
		
		
		
		
		
		public function get soundChannel():SoundChannel
		{
			return soundHoldings.soundChannel;
		}
		
		public function get soundTransform():SoundTransform
		{
			return soundHoldings.soundTransform;
		}
		
		
		private var _sndTransProps:Object = {};
		
		

		/**
		 * コンストラクタ.
		 * @param targetSound	対象Sound.
		 */
		public function SoundTransformRegister(targetSound:Sound)
		{
			sound = targetSound;
		}
		
		
		/**
		 * SoundTransform用プロパティを予約する。サウンド再生には必ずplayメソッドを使うこと！
		 * @param name	プロパティ名。
		 * @param value	設定する値。
		 */
		public function regist(name:String, value:Object):void
		{
			_sndTransProps[name] = value;
			// 可能ならすぐに設定
			if(soundChannel) soundTransform[name] = value;
		}
		
		/**
		 * SoundTransform用プロパティをまとめて予約する。サウンド再生には必ずplayメソッドを使うこと！
		 * @param data
		 */
		public function registProperties(data:Object):void
		{
			ObjectUtil.setProperties(_sndTransProps, data);
			// 可能ならすぐに設定
			if(soundChannel) ObjectUtil.setProperties(soundTransform, data);
		}
		
		
		/**
		 * 強制的にプロパティを設定。（通常はplay()した時に設定される）
		 */
		public function update():void
		{
			var st:SoundTransform = soundTransform;
			ObjectUtil.setProperties(st, _sndTransProps);
			soundChannel.soundTransform = st;
		}
		
		
		/**
		 * 予約したプロパティを消去。
		 */
		public function clear():void
		{
			_sndTransProps = {};
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
			soundHoldings.play(startTime, loops, sndTransform);
			update();
			return soundChannel;
		}
		
		public function stop():void
		{
			if(soundChannel) soundChannel.stop();
		}
	}
}