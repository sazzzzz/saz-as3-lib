package saz.media {
	import flash.media.*;
	import flash.net.URLRequest;
	
	/**
	 * Soundヘルパ。主にSoundTransformへの定常的なアクセスを提供する。
	 * @author saz
	 */
	public class SoundHelper {
		
		private var $sound:Sound;
		private var $soundChannel:SoundChannel;
		private var $soundTransform:SoundTransform;
		
		//private var $pan:Number;
		//private var $volume:Number;
		
		public function SoundHelper(sound:Sound) {
			$sound = sound;
		}
		
		
		public function play(startTime:Number = 0.0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			if (null != sndTransform) soundTransform = sndTransform;
			$soundChannel = $sound.play(startTime, loops, soundTransform);
			return $soundChannel;
		}
		
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
		
		public function get sound():Sound { return $sound; }
		
		//public function set sound(value:Sound):void {
			//$sound = value;
		//}
		
		public function get soundChannel():SoundChannel { return $soundChannel; }
		
		//public function set soundChannel(value:SoundChannel):void {
			//$soundChannel = value;
		//}
		
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
		
		public function set soundTransform(value:SoundTransform):void {
			if (null == $soundChannel) {
				//再生前
				$soundTransform = value;
			}else {
				//再生した後
				$soundChannel.soundTransform = value;
			}
		}
		
		public function get pan():Number {
			return soundTransform.pan;
		}
		
		public function set pan(value:Number):void {
			var trans:SoundTransform = soundTransform;
			trans.pan = value;
			soundTransform = trans;
		}
		
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