package saz.events.collector {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	//import saz.collections.enumerator.*;
	
	/**
	 * EventCollectorベースクラス.
	 * @author saz
	 */
	public class EventCollectorBase extends AbstractEventCollector {
		
		protected var $autoStop:Boolean = true;
		protected var $isComplete:Boolean = false;
		protected var $isRunning:Boolean = false;
		
		protected var $dsps:Array;
		protected var $types:Array;
		protected var $lisners:Array;
		protected var $results:Array;
		//protected var $resultsEnum:Enumerable;
		
		public function EventCollectorBase() {
			super();
		}
		
		
		
		//--------------------------------------
		// override用
		//--------------------------------------
		
		protected function $destroyHook():void { }
		protected function $resultHook():Boolean { return false; }
		
		protected function $listenHook():void { }
		protected function $unlistenHook():void { }
		
		protected function $addListenHook(ispatcher:IEventDispatcher, eventType:String):void { }
		protected function $removeListenHook(ispatcher:IEventDispatcher, eventType:String):void { }
		protected function $removeListenAllHook():void { }
		
		
		
		public function dump():String {
			var res:String = "";
			res = res + $dsps + "\r";
			res = res + $types + "\r";
			return res;
		}
		
		/*override public function toString():String {
			return "[EventCollectorBase]";
		}*/
		
		override public function destroy():void {
			removeListenAll();
			$dsps.length = 0;
			$types.length = 0;
			$lisners.length = 0;
			$results.length = 0;
			
			//$resultsEnum = null;
			$destroyHook();
		}
		
		
		
		
		//開始
		override public function listen():void {
			if (!$lisners) $initListens();
			
			$listenHook();
			
			$lisners.length = 0;
			$results.length = 0;
			
			var dsp:IEventDispatcher, type:String, func:Function;
			for (var i:int = 0, n:int = $dsps.length; i < n; i++) {
				dsp = $dsps[i];
				type = $types[i];
				func = $createListener($results, i);
				dsp.addEventListener(type, func);
				$lisners.push(func);
				$results.push(false);
			}
			$isComplete = false;
			$isRunning = true;
		}
		
		//やめる
		override public function unlisten():void {
			if (!$lisners) $initListens();
			
			$unlistenHook();
			
			var dsp:IEventDispatcher, type:String, func:Function;
			for (var i:int = 0, n:int = $dsps.length; i < n; i++) {
				dsp = $dsps[i];
				type = $types[i];
				func = $lisners[i];
				dsp.removeEventListener(type, func);
			}
			$lisners.length = 0;
			$results.length = 0;
			
			$isRunning = false;
		}
		
		/**
		 * リッスンするイベントを追加. listen中に追加してもダメ.
		 * @param	dispatcher
		 * @param	type
		 */
		override public function addListen(dispatcher:IEventDispatcher, eventType:String):void {
			if (!$dsps) $initLists();
			
			$addListenHook(dispatcher, eventType);
			
			$dsps.push(dispatcher);
			$types.push(eventType);
			
			/*var func:Function = $createListener($results, $dsps.length);
			dispatcher.addEventListener(eventType, func);
			$lisners.push(func);
			$results.push(false);
			
			$isComplete = false;*/
		}
		
		override public function removeListen(dispatcher:IEventDispatcher, eventType:String):void {
			if (!$dsps) $initLists();
			
			$removeListenHook(dispatcher, eventType);
			
			var dsp:IEventDispatcher, type:String;
			for (var i:int = 0, n:int = $dsps.length; i < n; i++) {
				dsp = $dsps[i];
				type = $types[i];
				if (dsp == dispatcher && type == eventType) {
					$dsps.splice(i, 1);
					$types.splice(i, 1);
				}
			}
		}
		
		override public function removeListenAll():void {
			if (!$dsps) $initLists();
			
			$removeListenAllHook();
			
			for (var i:int = 0, n:int = $dsps.length; i < n; i++) {
				$dsps.splice(i, 1);
				$types.splice(i, 1);
			}
		}
		
		
		private function $initLists():void {
			$dsps = new Array();
			$types = new Array();
		}
		
		private function $initListens():void {
			$lisners = new Array();
			$results = new Array();
			
			//$resultsEnum = new ArrayEnumerator($results).enumerable();
		}
		
		private function $createListener(arr:Array, index:int):Function {
			return function():void {
				trace(this.toString(), arr, index);
				arr[index] = true;
				$checkResult();
			};
		}
		
		private function $checkResult():void {
			if ($isComplete) return;
			if (result) {
				$isComplete = true;
				if ($autoStop) unlisten();
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		
		/**
		 * 自動停止するかどうか. これがtrueの場合、COMPLETEイベント発生時に自動的にunlisten()する. 
		 */
		override public function get autoStop():Boolean { return $autoStop; }
		
		override public function set autoStop(value:Boolean):void {
			$autoStop = value;
		}
		
		/**
		 * listen()後、COMPLETEイベント発生済みかどうか.
		 */
		override public function get isComplete():Boolean { return $isComplete; }
		
		/**
		 * listen()中かどうか.
		 */
		override public function get isRunning():Boolean { return $isRunning; }
		
		/**
		 * 結果.
		 */
		override public function get result():Boolean {
			//return $resultsEnum.all();
			return $resultHook();
		}
		
	}

}