package saz.events.collector {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * EventCollector抽象クラス.
	 * @author saz
	 */
	public class AbstractEventCollector extends EventDispatcher{
		
		public function AbstractEventCollector() {
			super();
		}
		
		/**
		 * デストラクタ.
		 */
		public function destroy():void {}
		
		/**
		 * 動作開始.
		 */
		public function listen():void { }
		
		/**
		 * 動作停止.
		 */
		public function unlisten():void { }
		
		
		/**
		 * イベントを追加.
		 * @param	dispatcher
		 * @param	type
		 */
		public function addListen(dispatcher:IEventDispatcher, type:String):void {}
		
		/**
		 * イベントを削除.
		 * @param	dispatcher
		 * @param	type
		 */
		public function removeListen(dispatcher:IEventDispatcher, type:String):void {}
		
		/**
		 * イベントを全部削除.
		 */
		public function removeListenAll():void {}
		
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		
		/**
		 * 自動停止するかどうか. これがtrueの場合、COMPLETEイベント発生時に自動的にunlisten()する. 
		 */
		public function get autoStop():Boolean { return false; }
		
		public function set autoStop(value:Boolean):void { }
		
		/**
		 * listen()後、COMPLETEイベント発生済みかどうか.
		 */
		public function get isComplete():Boolean { return false; }
		
		/**
		 * listen()中かどうか.
		 */
		public function get isRunning():Boolean { return false; }
		
		/**
		 * 結果.
		 */
		public function get result():Boolean { return false; }
		
	}

}