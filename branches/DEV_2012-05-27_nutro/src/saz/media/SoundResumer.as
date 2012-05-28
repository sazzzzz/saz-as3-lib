package saz.media
{
	import flash.events.Event;
	import flash.media.*;
	
	public class SoundResumer
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
		}
		private var _sound:Object;
		
		
		/**
		 * SoundChannel。
		 * @return 
		 */
		public function get soundChannel():SoundChannel
		{
			return _channel;
		}
		private var _channel:SoundChannel;
		
		
		/**
		 * のこりループ回数。
		 * @return 
		 */
		public function get loops():int
		{
			return _loops;
		}
		private var _loops:int = 0;
		


//		private var _soundTransform:SoundTransform;
		private var _pausePosition:Number;
		
		
		
		/**
		 * コンストラクタ。
		 * @param targetSound	対象Sound。
		 */
		public function SoundResumer(targetSound:Object)
		{
			sound = targetSound;
		}
		
		protected function _soundChannel_complete(event:Event):void
		{
			if(_loops>1 || _loops==-1){
				if(_loops!=-1) _loops--;
				_channel.removeEventListener(Event.SOUND_COMPLETE, _soundChannel_complete);
				_channel = sound.play(0, 0, _channel.soundTransform);
				_channel.addEventListener(Event.SOUND_COMPLETE, _soundChannel_complete);
			}
		}
		
		/**
		 * サウンドを再生する SoundChannel オブジェクトを新しく作成します。サウンド再生には必ずこのメソッドを使うこと！
		 * @param startTime	再生を開始する初期位置 (ミリ秒単位) です。
		 * @param loops	サウンドチャネルの再生が停止するまで startTime 値に戻ってサウンドの再生を繰り返す回数を定義します。[拡張]-1を指定した場合無限ループ。
		 * @param sndTransform	サウンドチャンネルに割り当てられた初期 SoundTransform オブジェクトです。
		 * @return 
		 */
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			_loops = loops;
			_channel = sound.play(startTime, 0, sndTransform);
			_channel.addEventListener(Event.SOUND_COMPLETE, _soundChannel_complete);
			return _channel;
		}
		
		/**
		 * サウンド停止。
		 */
		public function stop():void
		{
			_pausePosition = 0;
			_channel.stop();
		}
		
		/**
		 * 一時停止。
		 */
		public function pause():void
		{
			// positionはわりといい加減ぽい
			// FP10で書きだすと改善されてるらしい？
			// http://melancholy.raindrop.jp/wordpress/?p=736
			_pausePosition = _channel.position;
			_channel.stop();
		}
		
		/**
		 * pause()後に再開。ループ回数、SoundTransformは引き継ぐ。
		 */
		public function resume():void
		{
			// play引数のstartTimeはミリ秒単位
			// Sound.lengthはミリ秒単位
			// SoundChannle.positionは？
			play(_pausePosition, _loops, _channel.soundTransform);
			
			// Sound.length プロパティは、サウンドファイル全体の最終的なサイズではなく、ロードされたサウンドデータのサイズを示します。
			// 
			// ロード中に長さを予測
			// var estimatedLength:int =  Math.ceil(snd.length / (snd.bytesLoaded / snd.bytesTotal)); 
			// var playbackPercent:uint = 100 * (channel.position / estimatedLength);
			// http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7d1e.html
		}
		
	}
}