package saz.media
{
	import flash.events.EventDispatcher;
	import flash.media.*;
	
	/**
	 * Sound関連インスタンスへの参照まとめ。SoundTransformの保持と、play,stopを1つのクラスで。
	 * @author saz
	 */
	public class SoundHoldings extends EventDispatcher
	{
		
		/**
		 * Sound。（あるいはplayメソッドを持つオブジェクト）
		 * @return 
		 */
		public function get sound():Object
		{
			return _sound;
		}
		public function set sound(value:Object):void
		{
			_sound = value;
			_channel = null;
			// SoundTransformは使いまわす
		}
		private var _sound:Object;
		
		/**
		 * SoundChannel。
		 * @return 
		 */
		public function get soundChannel():SoundChannel
		{
			// TODO	Sound.play()前に、soundChannelにaddEventListenerしたい。->自身がプロクシになればいい。
			return _channel;
		}
		private var _channel:SoundChannel;
		
		/**
		 * SoundTransform。SoundTransformのプロパティを変更したら、pushSoundTransform()を実行しないと値は反映されない。
		 * @return 
		 */
		public function get soundTransform():SoundTransform
		{
			if(!_transform) _transform = new SoundTransform();
			return _transform;
		}
		public function set soundTransform(value:SoundTransform):void
		{
			_transform = value;
			pushSoundTransform();
		}
		private var _transform:SoundTransform;
		
		
		/**
		 * コンストラクタ.
		 * @param targetSound	対象Sound.
		 */
		public function SoundHoldings(targetSound:Object)
		{
			super();
			
			sound = targetSound;
		}
		
		/**
		 * soundChannelからSoundTransformをコピー。
		 */
		public function pullSoundTransform():void
		{
			if(soundChannel) _transform = soundChannel.soundTransform;
		}
		
		/**
		 * プロパティsoundTransformをsoundChannelに設定。
		 */
		public function pushSoundTransform():void
		{
			if(soundChannel) soundChannel.soundTransform = _transform;
		}
		
		
		/**
		 * サウンドを再生する SoundChannel オブジェクトを新しく作成します。サウンド再生には必ずこのメソッドを使うこと！
		 * @param startTime
		 * @param loops
		 * @param sndTransform	指定しなかった場合、内部で保持しているSoundTransformを使用します。
		 * @return 
		 */
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			//再生中なら停止
			if(soundChannel) stop();
			
			if(!sndTransform) sndTransform = soundTransform;
			_channel = sound.play(startTime, loops, sndTransform);
			return _channel;
		}
		
		/**
		 * サウンド停止。
		 */
		public function stop():void
		{
			if(soundChannel) soundChannel.stop();
		}
		
	}
}