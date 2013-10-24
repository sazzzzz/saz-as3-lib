package saz.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	

	/**
	 * MovieClipヘルパ。
	 * フレーム再生時にdispatchEvent()を実行。
	 * 
	 * @author saz
	 * 
	 */
	public class MovieClipHelper extends EventDispatcher
	{


		public function get target():MovieClip
		{
			return _target;
		}
		private var _target:MovieClip;

		public var stopAtCreate:Boolean = true;
		
		private var frameEvent:FrameEvent;
		
		public function MovieClipHelper(movieClip:MovieClip, stop:Boolean=true)
		{
			super();
			
			_target = movieClip;
			stopAtCreate = stop;
			
			initialize();
		}
		
		
		
		private function initialize():void
		{
			if (stopAtCreate) target.stop();
			
			frameEvent = new FrameEvent(target);
		}
		
		
		public function addEvent(frame:Object, type:String=""):void
		{
			frameEvent.addEvent(frame, type);
		}

		
		/**
		 * デストラクタ。
		 * 
		 */
		public function destroy():void
		{
			_target = null;
			
			frameEvent.destroy();
			frameEvent = null;
		}
	}
}