package saz.dev {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import saz.events.WatchEvent;
	
	/**
	 * 値に書き込みがあった. 
	 * @eventType	saz.events.WatchEvent.UPDATE
	 */
	[Event(name = "update", type = "saz.events.WatchEvent")];
	
	/**
	 * 値に変更があった. 
	 * @eventType	saz.events.WatchEvent.CHANGE
	 */
	[Event(name = "change", type = "saz.events.WatchEvent")];
	
	/**
	 * 値保持クラス.
	 * @author saz
	 * @see	http://www.ua-labo.com/entries/pid000032.html
	 * @see	http://nicoden.zxq.net/index.php?Flex%2FPureMVC%2F%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB#q626d7d7
	 * @see	http://d.hatena.ne.jp/sumim/20110513
	 */
	public class ValueHolder extends EventDispatcher {
		
		private var _value:*;
		
		/**
		 * 名前. イベント発行時にWatchEvent.keyとして使われる. 
		 */
		public var name:String = "ValueHolder";
		
		/**
		 * コンストラクタ. 
		 * @param	val	初期値. 
		 * @param	name	名前. イベント発行時にWatchEvent.keyとして使われる. 
		 */
		public function ValueHolder(val:*, valueName:String = "") {
			super();
			
			if (val != undefined) value = val;
			if (valueName != "") name = valueName;
		}
		
		/**
		 * 値を取得する. 
		 */
		public function get value():* {
			return _value;
		}
		
		/**
		 * 値を設定する. 
		 * WatchEvent.UPDATEイベントは常に発行. WatchEvent.CHANGEは、値に変化があれば発行. 
		 */
		public function set value(val:*):void {
			var old:*= _value;
			_value = val;
			
			dispatchEvent(new WatchEvent(WatchEvent.UPDATE, name, old, val));
			if (old != val) {
				dispatchEvent(new WatchEvent(WatchEvent.CHANGE, name, old, val));
			}
		}
		
		
		override public function toString():String {
			return "[ValueHolder: " + value + "]";
		}
		
		
	}
}