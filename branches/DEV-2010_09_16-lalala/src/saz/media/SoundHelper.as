package saz.media {
	import flash.media.*;
	import flash.net.URLRequest;
	
	/**
	 * Soundヘルパ。主にSoundTransformへの定常的なアクセスを提供する。
	 * ヘルパというよりProxyだったな…。
	 * @author saz
	 */
	public class SoundHelper {
		
		private var $sound:Sound;
		private var $soundChannel:SoundChannel;
		private var $soundTransform:SoundTransform;
		
		/**
		 * コンストラクタ。
		 * @param	sound	Soundインスタンス。
		 */
		public function SoundHelper(sound:Sound) {
			$sound = sound;
		}
		
		/**
		 * 再生開始。引数はSound.play()と同じ。
		 * @param	startTime
		 * @param	loops
		 * @param	sndTransform
		 * @return
		 */
		public function play(startTime:Number = 0.0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			if (null != sndTransform) soundTransform = sndTransform;
			$soundChannel = $sound.play(startTime, loops, soundTransform);
			return $soundChannel;
		}
		
		/**
		 * 再生停止。
		 */
		public function stop():void {
			if (null != $soundChannel) $soundChannel.stop();
		}
		
		
		// テストしてない
		/*public function load(stream:URLRequest, context:SoundLoaderContext = null):void {
			$sound.load(stream, context);
		}
		
		public function close():void {
			$sound.close();
		}*/
		
		
		
		//--------------------------------------
		// getter/setter
		//--------------------------------------
		
		/**
		 * Soundインスタンス。
		 */
		public function get sound():Sound { return $sound; }
		
		//public function set sound(value:Sound):void {
			//$sound = value;
		//}
		
		/**
		 * SoundChannelインスタンス。play()前はnullを返す。
		 */
		public function get soundChannel():SoundChannel { return $soundChannel; }
		
		//public function set soundChannel(value:SoundChannel):void {
			//$soundChannel = value;
		//}
		
		/**
		 * SoundTransformインスタンス。
		 */
		public function get soundTransform():SoundTransform {
			if (null == $soundChannel) {
				//再生前
				if (null == $soundTransform) $soundTransform = new SoundTransform();
				return $soundTransform;
			}else {
				//再生した後
				if (null != $soundTransform) $soundTransform = null;
				return $soundChannel.soundTransform;
			}
		}
		
		/**
		 * SoundTransformインスタンスを設定。
		 */
		public function set soundTransform(value:SoundTransform):void {
			if (null == $soundChannel) {
				//再生前
				$soundTransform = value;
			}else {
				//再生した後
				$soundChannel.soundTransform = value;
			}
		}
		
		/**
		 * パン。
		 */
		public function get pan():Number {
			return soundTransform.pan;
		}
		
		public function set pan(value:Number):void {
			var trans:SoundTransform = soundTransform;
			trans.pan = value;
			soundTransform = trans;
		}
		
		/**
		 * ボリューム。
		 */
		public function get volume():Number {
			return soundTransform.volume;
		}
		
		public function set volume(value:Number):void {
			var trans:SoundTransform = soundTransform;
			trans.volume = value;
			soundTransform = trans;
		}
		
	}

}