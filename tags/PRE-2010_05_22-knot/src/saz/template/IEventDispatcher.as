package {
	import flash.events.*;
	
	/**
	 * IEventDispatcherテンプレート
	 * @author saz
	 */
	public class MyClass implements IEventDispatcher {
		
		private var $ed:EventDispatcher;
		
		function MyClass() {
			$initEventDispatcher();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			$ed.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function dispatchEvent(event:Event):Boolean {
			return $ed.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean {
			return $ed.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			$ed.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return $ed.willTrigger(type);
		}
		
		private function $initEventDispatcher():void {
			$ed = new EventDispatcher();
		}
		
		
		
	}
	
}