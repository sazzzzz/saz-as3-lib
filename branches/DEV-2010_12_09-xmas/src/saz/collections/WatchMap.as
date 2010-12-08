package saz.collections {
	import flash.events.*;
	import saz.events.WatchEvent;
	
	/**
	 * いずれかのプロパティに変化があった場合に、送出されます。
	 * @eventType saz.events.WatchEvent.CHANGE
	 */
	[Event(name = "change", type = "saz.events.WatchEvent")]
	
	/**
	 * 変更されたらイベント発行するMap
	 * @author saz
	 */
	public class WatchMap extends Map implements IEventDispatcher {
		
		//keyはクラスプロパティで持つ
		/*public static const KEY_A:String = "a";*/
		
		private var $ed:EventDispatcher;
		
		function WatchMap() {
			super();
			$initEventDispatcher();
		}
		
		override public function put(key:String, value:*):void {
			var oldValue:*= super.gets(key);
			//値が同じなら何もしない
			if (oldValue == value) return;
			
			super.put(key, value);
			//dispatchEvent(new Event(Event.CHANGE, oldValue, value));
			dispatchEvent(new WatchEvent(WatchEvent.CHANGE, key, oldValue, value));
			dispatchEvent(new WatchEvent(key, key, oldValue, value));
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