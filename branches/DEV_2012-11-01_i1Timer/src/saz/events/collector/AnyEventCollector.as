package saz.events.collector {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import saz.collections.enumerator.*;
	
	/**
	 * 登録された複数イベントをどれか受け取ったら、COMPLETEイベント発行.
	 * @author saz
	 */
	public class AnyEventCollector extends EventCollectorBase {
		
		private var $resultsEnum:Enumerable;
		
		public function AnyEventCollector() {
			super();
		}
		
		override public function toString():String {
			return "[AnyEventCollector]";
		}
		
		
		override protected function $destroyHook():void {
			$resultsEnum = null;
		}
		
		override protected function $resultHook():Boolean {
			return $resultsEnum.any();
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