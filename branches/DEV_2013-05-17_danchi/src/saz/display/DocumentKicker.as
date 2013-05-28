package saz.display
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class DocumentKicker
	{
		
		private var _doc:DisplayObjectContainer;
		private var _callback:Function;
		
		private var _timer:Timer;
		
		/**
		 * 
		 * @param target
		 * @param callback
		 * 
		 * public function Document()
		 * {
		 * 	super();
		 * 	var kicker:DocumentKicker = new DocumentKicker(this, atRead);
		 */
		public function DocumentKicker(target:DisplayObjectContainer, callback:Function)
		{
			_doc = target;
			_callback = callback;
		}
		
		
		public function start():void
		{
			_delayedStart();
		}
		
		
		public function destroy():void
		{
			_timer.stop();
			_unlisten();
			
			_timer = null;
			_doc = null;
			_callback = null;
		}
		
		
		/**
		 * コンストラクタから直接Progressionを初期化するとエラーが発生することがあるので、ちょっと待つ。
		 * 
		 */
		private function _delayedStart():void
		{
			_timer ||= new Timer(1, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent):void
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);
				_timer.stop();
				_start();
			});
			_timer.start();
		}
		
		private function _start():void
		{
			if (!_docIsReady())
			{
				_listen();
			}else{
				_kick();
			}
		}
		
		
		private function _listen():void
		{
			_doc.addEventListener(Event.ADDED_TO_STAGE, _triggered);
			_doc.loaderInfo.addEventListener(Event.COMPLETE, _triggered);
		}
		
		private function _unlisten():void
		{
			_doc.removeEventListener(Event.ADDED_TO_STAGE, _triggered);
			_doc.loaderInfo.removeEventListener(Event.COMPLETE, _triggered);
		}
		
		protected function _triggered(event:Event):void
		{
			if (_docIsReady()) _kick();
		}
		
		
		
		
		
		
		private function _kick():void
		{
			_callback();
		}
		
		
		/**
		 * ドキュメントの準備ができたか。
		 * @return 
		 * 
		 */
		private function _docIsReady():Boolean
		{
			return _docIsAdded() && _docIsLoaded();
		}
		
		
		
		
		private function _docIsLoaded():Boolean
		{
			return _doc.loaderInfo.bytesLoaded == _doc.loaderInfo.bytesTotal;
		}
		
		private function _docIsAdded():Boolean
		{
			return _doc.parent != null;
		}
		
	}
}