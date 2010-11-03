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
	 * @deprecated	汎用性がないのでTweenerNumberに移行。廃止予定。　ていうか動いてない！！！廃止廃止！
	 * @author saz
	 * @example <listing version="3.0" >
	 * var wmap:WatchMap = new WatchMap();
	 * wmap.put("yamada", 0);
	 * 
	 * var tm0:TweenedMapValue = new TweenedMapValue();
	 * tm0.SetTarget(wmap,"yamada");
	 * tm0.time = 1;
	 * tm0.transition = "easeInOutExpo";
	 * tm0.Start();
	 * 
	 * wmap.put("yamada",10);
	 * </listing>
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
		
		public var Start:Function;
		public var Stop:Function;
		public var SetTarget:Function;
		
		private var $watchMap:WatchMap;
		private var $key:String;
		
		function TweenedMapValue() {
			Start = start;
			Stop = stop;
			SetTarget = setTarget;
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
		
		public function start():void {
			value = $watchMap.gets($key);
			$watchMap.addEventListener($key, $onChange);
		}
		
		public function stop():void {
			$watchMap.removeEventListener($key, $onChange);
		}
		
		/**
		 * 対象を指定する。ただし数値のみ。
		 * @param	watchMap
		 * @param	key
		 */
		public function setTarget(watchMap:WatchMap, key:String):void {
			$watchMap = watchMap;
			$key = key;
		}
		
	}
	
}