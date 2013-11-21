package saz.display
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	/**
	 * MovieClipのタイムラインで、dispatchEvent()を実行するように。
	 * 
	 * @author saz
	 * 
	 */
	public class FrameEvent extends EventDispatcher
	{
		
		
		/**
		 * 対象MovieClip。
		 * @return 
		 * 
		 */
		public function get target():MovieClip
		{
			return _target;
		}
		private var _target:MovieClip;
		
		private var frameAction:FrameAction;
		private var actions:Object;
		
		
		
		/**
		 * コンストラクタ。
		 * @param movieClip
		 * 
		 */
		public function FrameEvent(movieClip:MovieClip)
		{
			super();
			
			_target = movieClip;
			
			initialize();
		}
		
		
		
		private function initialize():void
		{
			frameAction = new FrameAction(target);
			actions = {};
		}
		
		private function createDispatch(name:String):Function
		{
			var self:FrameEvent = this;
			return function():void
			{
				self.dispatchEvent(new Event(name, true));
			};
		}
		
		
		/**
		 * 指定したフレームでイベントを発生するように。
		 * 該当フレームにあらかじめ設定されていた「フレームアクション」は消去されるみたい。FlashIDEで設定したものも消去されるみたい。
		 * 
		 * @param frame	フレームラベルまたはフレーム数。
		 * @param type	イベントタイプ。しょうりゃくした場合は、frameが使われる。
		 * 
		 */
		public function addEvent(frame:Object, type:String=""):void
		{
			var eventType:String = (type == "") ? frame.toString() : type;
			
			var fnc:Function = createDispatch(eventType);
			actions[frame] = fnc;
			frameAction.setAction(frame, fnc);
		}
		
		/**
		 * デストラクタ。
		 * 
		 */
		public function destroy():void
		{
			frameAction.removeAll();
			actions = null;
			frameAction = null;
			
			_target = null;
		}
	}
}