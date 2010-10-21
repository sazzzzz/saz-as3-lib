package saz.media {
	import flash.display.DisplayObject;
	import flash.events.*;
	import saz.media.SoundHelperEvent;
	import saz.number.AverageNumber;
	/**
	 * Soundのビートおよびループイベントを発生.
	 * @author saz
	 */
	public class SoundBeat extends EventDispatcher {
		
		/**
		 * 1ループあたりのビート数。
		 */
		public var beatsPerLoop:int = 16;
		
		//private var $isRunning:Boolean = false;
		private var $soundHelper:SoundHelper;
		private var $dispatcher:DisplayObject;
		
		private var $beat:int = -1;
		private var $loop:int = 0;
		
		private var $length:Number = 0.0;
		private var $prevPosition:Number = 0.0;
		// ミリ秒/フレームの平均値を求める.
		private var $posDiffAverage:AverageNumber;
		
		public function SoundBeat(sndHelper:SoundHelper, dispatcher:DisplayObject) {
			soundHelper = sndHelper;
			$dispatcher = dispatcher;
			
			if (!$posDiffAverage)$posDiffAverage = new AverageNumber();
			
			//すでに再生中なら処理開始
			if (soundHelper.isPlaying) $start();
		}
		
		
		
		public function destroy():void {
			$soundHelper.removeEventListener(SoundHelperEvent.PLAY, $soundHelper_play);
			$soundHelper.removeEventListener(SoundHelperEvent.STOP, $soundHelper_stop);
			$soundHelper = null;
			$dispatcher.removeEventListener(Event.ENTER_FRAME, $enterFrame);
			$dispatcher = null;
		}
		
		
		
		
		private function $start():void {
			//$isRunning = true;
			$initSoundProps();
			$dispatcher.addEventListener(Event.ENTER_FRAME, $enterFrame);
		}
		
		private function $stop():void {
			//$isRunning = false;
			$dispatcher.removeEventListener(Event.ENTER_FRAME, $enterFrame);
		}
		
		private function $initSoundProps():void {
			$beat = -1;
			$loop = 0;
			$prevPosition = 0.0;
		}
		
		private function $enterFrame(e:Event):void {
			//trace("SoundBeat.$enterFrame(", arguments);
			
			if (!$soundHelper.soundChannel) return;
			var pos:Number = $soundHelper.soundChannel.position;
			// soundChannel.positionに変化がなければ何もしない？
			if (pos == $prevPosition) return;
			
			// Soundが最初から再生された。
			if (pos < $prevPosition) $initSoundProps();
			
			// ミリ秒/フレームの平均値
			$posDiffAverage.add(pos - $prevPosition);
			var nextPosition:Number = pos + $posDiffAverage.value;
			
			// ビート（1フレーム先に知りたいので、$posDiffAverage.valueを足して計算）
			var nextBeat:int = Math.floor(nextPosition % $length / $length * beatsPerLoop);
			// ループ回数（1フレーム先に知りたいので、$posDiffAverage.valueを足して計算）
			var nextLoop:int = Math.floor(nextPosition / $length);
			
			if (nextLoop != $loop) {
				$loop = nextLoop;
				dispatchEvent(new SoundHelperEvent(SoundHelperEvent.LOOP, nextBeat, nextLoop));
			}
			
			if (nextBeat != $beat) {
				$beat = nextBeat;
				dispatchEvent(new SoundHelperEvent(SoundHelperEvent.BEAT, nextBeat, nextLoop));
			}
			
			$prevPosition = pos;
		}
		
		//--------------------------------------
		// LISTENER
		//--------------------------------------
		
		private function $soundHelper_play(e:SoundHelperEvent):void {
			trace("SoundBeat.$soundHelper_play(", arguments);
			$start();
		}
		
		private function $soundHelper_stop(e:SoundHelperEvent):void{
			$stop();
		}
		
		/**
		 * 処理開始.
		 */
		/*public function start():void {
			if (isRunning) return;
			
			$start();
		}*/
		
		/**
		 * 処理停止.
		 */
		/*public function stop():void {
			if (!isRunning) return;
			
			$isRunning = false;
			$dispatcher.removeEventListener(Event.ENTER_FRAME, $enterFrame);
		}*/
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		/**
		 * 処理中かどうか.
		 */
		//public function get isRunning():Boolean { return $isRunning; }
		
		public function get soundHelper():SoundHelper { return $soundHelper; }
		
		public function set soundHelper(value:SoundHelper):void {
			$soundHelper = value;
			$length = value.sound.length;
			$soundHelper.addEventListener(SoundHelperEvent.PLAY, $soundHelper_play);
			$soundHelper.addEventListener(SoundHelperEvent.STOP, $soundHelper_stop);
		}
		
		/**
		 * ループ回数.0～.
		 */
		public function get loop():int { return $loop; }
		
		/**
		 * ビート.0～.
		 */
		public function get beat():int { return $beat; }
	}

}