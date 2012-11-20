package saz.events {
	import flash.events.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class WatchEvent extends Event {
		
		public static const CHANGE:String = "change";
		public static const UPDATE:String = "update";
		public static const COMPLETE:String = "complete";
		
		public var key:String;
		public var oldValue:*;
		public var newValue:*;
		
		/**
		 * @see	http://blog.bonkura.jp/2008/10/as30-19.html
		 * @param	type	イベントタイプ
		 * @param	key	対象キー
		 * @param	oldValue	変更前の値
		 * @param	newValue	変更後の値
		 */
		function WatchEvent(type:String, key:String, oldValue:*, newValue:*) {
		//function WatchEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, key:String, oldValue:*, newValue:*) {
			super(type, bubbles, cancelable);
			
			this.key = key;
			this.oldValue = oldValue;
			this.newValue = newValue;
		}
		
		public override function clone():Event {
			return new WatchEvent(type, key, oldValue, newValue);
		}
		
		public override function toString():String {
			return formatToString("WatchEvent", "type", "bubbles", "cancelable", "eventPhase", "key", "oldValue", "newValue"); 
		}
		
	}
	
}