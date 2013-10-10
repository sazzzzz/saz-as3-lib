package saz.media
{
	import flash.media.*;
	
	import saz.media.*;
	
	public class MultipleSoundFacade implements ISoundFacade
	{
		
		public function get sound():Sound
		{
			return _cur.sound;
		}
		
		public function set sound(value:Sound):void
		{
			throw new Error("soundの指定はサポートされません。");
		}
		
		public function get soundChannel():SoundChannel
		{
			return _cur.soundChannel;
		}
		
		public function get soundTransform():SoundTransform
		{
			return _cur.soundTransform;
		}
		
		public function get volume():Number
		{
			return _cur.volume;
		}
		
		public function set volume(value:Number):void
		{
			_each(function(item:SoundFacade, index:int, arr:Array):void
			{
				item.volume = value;
			});
		}
		
		public function get pan():Number
		{
			return _cur.pan;
		}
		
		public function set pan(value:Number):void
		{
			_each(function(item:SoundFacade, index:int, arr:Array):void
			{
				item.pan = value;
			});
		}
		
		public function get holdings():SoundHoldings
		{
			return _cur.holdings;
		}
		
		public function get resumer():SoundResumer
		{
			return _cur.resumer;
		}
		
		
		
		
		
		public function MultipleSoundFacade()
		{
			setDetectCallback(_defaultDetector);
		}
		
		
		
		//--------------------------------------
		// 固有機能
		//--------------------------------------
		
		private var _facs:Array = [];
		private var _cur:SoundFacade;
		private var _detector:Function;

		public function addFacade(facade:SoundFacade):int
		{
			return _facs.push(facade);
		}
		
		public function setDetectCallback(callback:Function):void
		{
			_detector = callback;
		}
		
		
		protected function _detectFacade():void
		{
			_cur = _detector(_facs);
		}
		
		protected function _each(iterator:Function):void
		{
			_facs.forEach(iterator);
		}
		
		// デフォルト。ランダムで決定。
		protected function _defaultDetector(facades:Array):SoundFacade
		{
			return facades[Math.floor(Math.random() * facades.length)];
		}
		
		
		//--------------------------------------
		// 
		//--------------------------------------
		
		
		
		
		public function play(startTime:Number=0, loops:int=0, sndTransform:SoundTransform=null):SoundChannel
		{
			_detectFacade();
			return _cur.play(startTime, loops, sndTransform);
		}
		
		public function resumablePlay(startTime:Number=0, loops:int=0, sndTransform:SoundTransform=null):SoundChannel
		{
			_detectFacade();
			return _cur.resumablePlay(startTime, loops, sndTransform);
		}
		
		public function stop():void
		{
			_cur.stop();
		}
		
		public function pause():void
		{
			_cur.pause();
		}
		
		public function resume():void
		{
			_cur.resume();
		}
	}
}