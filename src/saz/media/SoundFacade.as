package saz.media
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.*;
	
	import saz.display.StageReference;
	
	/**
	 * Sound関連クラスまとめFacade。よく使う機能を提供。
	 * @author saz
	 */
	public class SoundFacade extends EventDispatcher implements ISoundFacade
	{
		
		/**
		 * Sound。（あるいはplayメソッドを持つオブジェクト）
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
			return holdings.soundChannel;
		}
		
		/**
		 * SoundTransform。
		 * @return 
		 */
		public function get soundTransform():SoundTransform
		{
			return holdings.soundTransform;
		}
		

		
		/**
		 * ボリューム。
		 * @return 
		 */
		public function get volume():Number
		{
			return holdings.soundTransform.volume;
		}
		
		public function set volume(value:Number):void
		{
			// TODO changeイベントが欲しい…
			// TODO	pushをフレームに1回だけやるように改良とか。
			holdings.soundTransform.volume = value;
			setNeedPush();
		}
		
		
		/**
		 * パン。
		 * @return 
		 */
		public function get pan():Number
		{
			return holdings.soundTransform.pan;
		}
		
		public function set pan(value:Number):void
		{
			holdings.soundTransform.pan = value;
//			holdings.pushSoundTransform();
			setNeedPush();
		}
		
		
		
		/**
		 * SoundHoldings。
		 * @return 
		 */
		public function get holdings():SoundHoldings
		{
			if(!_holdings) _holdings = new SoundHoldings(sound);
			return _holdings;
		}
		private var _holdings:SoundHoldings;
		
		

		/**
		 * SoundResumer。
		 * @return 
		 */
		public function get resumer():SoundResumer
		{
			if(!_resumer) _resumer = new SoundResumer(holdings);
			return _resumer;
		}
		private var _resumer:SoundResumer;
		
		
		
		
		
		
		/**
		 * コンストラクタ。
		 * @param targetSound	対象Sound。
		 */
		public function SoundFacade(targetSound:Sound)
		{
			super();
			
			sound = targetSound;
		}
		
		
		
		public function setNeedPush():void
		{
			if(StageReference.stage){
				StageReference.stage.addEventListener(Event.ENTER_FRAME, _push);
			}else{
				holdings.pushSoundTransform();
			}
		}
		
		protected function _push(event:Event):void
		{
			holdings.pushSoundTransform();
			if(StageReference.stage) StageReference.stage.removeEventListener(Event.ENTER_FRAME, _push);
		}		
		
		
		/**
		 * @copy	SoundResumer#play
		 * （通常のplay）サウンドを再生する SoundChannel オブジェクトを新しく作成します。サウンド再生には必ずこのメソッドを使うこと！
		 */
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			//実装してません
			return resumer.play(startTime, loops, sndTransform);
		}
		
		/**
		 * @copy	SoundResumer#play
		 * 再開可能なplay
		 */
		public function resumablePlay(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel
		{
			return resumer.play(startTime, loops, sndTransform);
		}
		
		/**
		 * @copy	SoundResumer#stop
		 */
		public function stop():void
		{
			resumer.stop();
		}
		
		/**
		 * @copy	SoundResumer#pause
		 */
		public function pause():void
		{
			resumer.pause();
		}
		
		/**
		 * @copy	SoundResumer#resume
		 */
		public function resume():void
		{
			resumer.resume();
		}
		
		
		
		
		
		
		
		
		
	}
}