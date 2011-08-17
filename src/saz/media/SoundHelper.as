package saz.media {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.*;
	import flash.net.URLRequest;
	
	// TODO	isPlaying変更イベント、パン・ボリューム変更イベント。
	/**
	 * Soundヘルパ。主にSoundTransformへの定常的なアクセスを提供する。
	 * ヘルパというよりProxyだったな…。
	 * @author saz
	 */
	public class SoundHelper extends EventDispatcher {
		
		/**
		 * play()の第2引数の最大値。無限ループ用に。
		 */
		static public const LOOPS_MAX:int = int.MAX_VALUE;
		
		// 再生中かどうかのフラグ。
		private var $isPlaying:Boolean = false;
		private var $isLoop:Boolean = false;
		private var $sound:Sound;
		private var $soundChannel:SoundChannel;
		private var $soundTransform:SoundTransform;
		
		/**
		 * @copy	saz.media.SoundHelperEvent#PLAY
		 * 
		 * @eventType	saz.media.SoundHelperEvent.PLAY
		 */
		[Event(name = "play", type = "saz.media.SoundHelperEvent")];
		
		/**
		 * @copy	saz.media.SoundHelperEvent#STOP
		 * 
		 * @eventType	saz.media.SoundHelperEvent.STOP
		 */
		[Event(name = "stop", type = "saz.media.SoundHelperEvent")];
		
		
		
		/**
		 * コンストラクタ。
		 * @param	sound	（オプション）Soundインスタンス。
		 */
		public function SoundHelper(sound:Sound = null) {
			if(sound) $initSound(sound);
		}
		
		/**
		 * デストラクタ。
		 */
		public function destroy():void {
			stop();
			if($sound) $sound.removeEventListener(Event.COMPLETE, $sound_complete);
			$sound = null;
			$soundChannel = null;
			$soundTransform = null;
		}
		
		
		
		/**
		 * 再生開始。引数はSound.play()と同じ。
		 * @param	startTime
		 * @param	loops	無限ループしたい場合は、SoundHelper.LOOPS_MAXの使用を推奨。
		 * @param	sndTransform
		 * @return
		 */
		public function play(startTime:Number = 0.0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel {
			//if (!$sound || $isPlaying) return null;
			if (!$sound) return null;
			
			$isPlaying = true;
			$isLoop = (0 != loops);
			if (null != sndTransform) soundTransform = sndTransform;
			$soundChannel = $sound.play(startTime, loops, soundTransform);
			dispatchEvent(new SoundHelperEvent(SoundHelperEvent.PLAY, 0));
			//dispatchEvent(new SoundHelperEvent(SoundHelperEvent.PLAY, loops));
			return $soundChannel;
		}
		
		/**
		 * 再生停止。
		 */
		public function stop():void {
			//if (null != $soundChannel) $soundChannel.stop();
			if (!$sound || !$isPlaying) return;
			
			$isPlaying = false;
			$isLoop = false;
			$soundChannel.stop();
			dispatchEvent(new SoundHelperEvent(SoundHelperEvent.STOP, 0));
		}
		
		
		// テストしてない
		/*public function load(stream:URLRequest, context:SoundLoaderContext = null):void {
			$sound.load(stream, context);
		}
		
		public function close():void {
			$sound.close();
		}*/
		
		
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		private function $initSound(sound:Sound):void {
			$sound = sound;
			$sound.addEventListener(Event.COMPLETE, $sound_complete);
		}
		
		
		private function $sound_complete(e:Event):void{
			$isPlaying = false;
		}
		
		
		//--------------------------------------
		// getter/setter
		//--------------------------------------
		
		/**
		 * Soundインスタンス。
		 */
		public function get sound():Sound { return $sound; }
		
		public function set sound(value:Sound):void {
			destroy();
			$initSound(value);
		}
		
		
		/**
		 * SoundChannelインスタンス。play()前はnullを返す。
		 */
		public function get soundChannel():SoundChannel { return $soundChannel; }
		
		/**
		 * SoundTransformインスタンス。
		 */
		public function get soundTransform():SoundTransform {
			if (null == $soundChannel) {
				//再生前
				//trace("$soundChannel = null");
				if (null == $soundTransform) $soundTransform = new SoundTransform();
				return $soundTransform;
			}else {
				//再生した後
				//trace("$soundChannel nullじゃない");
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
				//trace("$soundChannel = null");
				$soundTransform = value;
			}else {
				//再生した後
				//trace("$soundChannel nullじゃない");
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
		
		/**
		 * 再生中かどうか。
		 */
		public function get isPlaying():Boolean { return $isPlaying; }
		/**
		 * ループ再生中かどうか。
		 */
		public function get isLoop():Boolean { return $isLoop; }
		
	}

}