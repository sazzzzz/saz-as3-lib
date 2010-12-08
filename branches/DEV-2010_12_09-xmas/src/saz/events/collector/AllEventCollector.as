package saz.events.collector {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import saz.collections.enumerator.*;
	
	/**
	 * 登録された複数イベントを全部受け取ったら、COMPLETEイベント発行.
	 * complete後どうするか？ autoStop:Boolean 1.動作停止　2.resultsをクリアして最初から
	 * @author saz
	 * @example <listing version="3.0" >
	 * import saz.events.collector.*;
	 * var timer = new Timer(2.0*1000,0);
	 * timer.start();
	 * 
	 * var all = new AllEventCollector();
	 * all.addListen(timer,TimerEvent.TIMER);
	 * all.addListen(this,Event.ENTER_FRAME);
	 * 
	 * all.addEventListener(Event.COMPLETE,all_complete);
	 * all.listen();
	 * 
	 * function all_complete (e) {
	 * 	trace("all_complete");
	 * }
	 * </listing>
	 */
	public class AllEventCollector extends EventCollectorBase {
		
		private var $resultsEnum:Enumerable;
		
		public function AllEventCollector() {
			super();
		}
		
		override public function toString():String {
			return "[AllEventCollector]";
		}
		
		
		override protected function $destroyHook():void {
			$resultsEnum = null;
		}
		
		override protected function $resultHook():Boolean {
			return $resultsEnum.all();
		}
		
		override protected function $listenHook():void {
			$resultsEnum = new ArrayEnumerator($results).enumerable();
		}
		
		override protected function $unlistenHook():void { }
		
		override protected function $addListenHook(ispatcher:IEventDispatcher, eventType:String):void { }
		override protected function $removeListenHook(ispatcher:IEventDispatcher, eventType:String):void { }
		override protected function $removeListenAllHook():void { }
		
	}

}