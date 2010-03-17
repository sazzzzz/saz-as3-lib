package saz.collections {
	import caurina.transitions.Tweener;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import saz.events.WatchEvent;
	
	/**
	 * トィーン中に、ターゲットのプロパティが更新されるごとに、送出されます。
	 * @eventType saz.events.WatchEvent.UPDATE
	 */
	[Event(name = "update", type = "saz.events.WatchEvent")]
	
	/**
	 * トィーンが完了したとき。isTween=falseの時も発行されます。
	 * @eventType saz.events.WatchEvent.COMPLETE
	 */
	[Event(name = "complete", type = "saz.events.WatchEvent")]
	
	
	/**
	 * WatchMapの特定のプロパティをトィーンする。
	 * @author saz
	 */
	public class TweenedMapValue extends EventDispatcher {
		
		public var value:Number;
		private var $oldVal:Number;
		private var $prevVal:Number;
		
		/**
		 * トゥイーンするかどうか。falseにしても、進行中のトゥイーンは止まらないよ。
		 */
		public var isTween:Boolean = true;
		public var time:Number = 0;
		public var transition:String = "easeOutExpo";
		
		private var $watchMap:WatchMap;
		private var $key:String;
		
		function TweenedMapValue() {
			
		}
		
		private function $onChange(e:WatchEvent):void {
			$oldVal = e.oldValue;
			if (isTween) {
				$prevVal = e.oldValue;
				value = e.oldValue;
				Tweener.addTween(this, { value:e.newValue, time:time, transition:transition, onUpdate:$onUpdate, onComplete:$onComplete } );
			}else {
				// トィーンなし
				$prevVal = e.newValue;
				value = e.newValue;
				//dispatchEvent(new WatchEvent(WatchEvent.COMPLETE, $key, e.oldValue, e.newValue));
				$onComplete();
			}
		}
		
		private function $onUpdate():void{
			dispatchEvent(new WatchEvent(WatchEvent.UPDATE, $key, $prevVal, value));
			$prevVal = value;
		}
		
		private function $onComplete():void{
			dispatchEvent(new WatchEvent(WatchEvent.COMPLETE, $key, $oldVal, value));
		}
		
		public function Start():void {
			value = $watchMap.gets($key);
			$watchMap.addEventListener($key, $onChange);
		}
		
		public function Stop():void {
			$watchMap.removeEventListener($key, $onChange);
		}
		
		/**
		 * 対象を指定する。ただし数値のみ。
		 * @param	watchMap
		 * @param	key
		 */
		public function SetTarget(watchMap:WatchMap, key:String):void {
			$watchMap = watchMap;
			$key = key;
		}
		
	}
	
}