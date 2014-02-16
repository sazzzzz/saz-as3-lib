package saz.events {
	import flash.events.*;
	
	/**
	 * watchイベント.
	 * @author saz
	 */
	public class WatchEvent extends Event {
		
		/**
		 * 値が変更される直前. 
		 */
		public static const WATCH:String = "watch";
		
		/**
		 * 値に変化があった. 
		 */
		public static const CHANGE:String = "change";
		
		/**
		 * 値が変更された. 
		 */
		public static const UPDATE:String = "update";
		
		/**
		 * 完了. 
		 */
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