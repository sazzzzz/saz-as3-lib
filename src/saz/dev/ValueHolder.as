package saz.dev {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import saz.events.WatchEvent;
	import saz.util.ObjectUtil;
	
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
	
	
	// OpenRTMでは、インターフェースに値取得・設定メソッドを含めないという実装
	// http://www.openrtm.org/OpenRTM-aist/documents/current/java/classreference_ja/jp/go/aist/rtm/RTC/util/ByteHolder.html
	// http://www.openrtm.org/OpenRTM-aist/documents/current/java/classreference_ja/jp/go/aist/rtm/RTC/util/IntegerHolder.html
	// http://www.openrtm.org/OpenRTM-aist/documents/current/java/classreference_ja/jp/go/aist/rtm/RTC/util/ValueHolder.html
	
	
	/**
	 * 値保持クラス. クラス名はSqueakから. 
	 * @author saz
	 * @see	http://d.hatena.ne.jp/sumim/20110513
	 * @see	http://www.ua-labo.com/entries/pid000032.html
	 * @see	http://nicoden.zxq.net/index.php?Flex%2FPureMVC%2F%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB#q626d7d7
	 */
	public class ValueHolder extends EventDispatcher implements IValue, IEventDispatcher {
		
		
		
		/* INTERFACE saz.dev.IValue */
		
		/**
		 * 名前. イベント発行時にWatchEvent.keyとして使われる. 
		 */
		public function get name():String {
			return _name;
		}
		//public var name:String = "ValueHolder";
		private var _name:String = "ValueHolder";
		
		
		
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
		private var _value:*;
		
		
		
		
		/**
		 * コンストラクタ. 
		 * @param	val	初期値. 
		 * @param	name	名前. イベント発行時にWatchEvent.keyとして使われる. 
		 */
		public function ValueHolder(val:*, valueName:String = "") {
			super();
			
			if (val != undefined) value = val;
			if (valueName != "") _name = valueName;
		}
		
		
		
		/* flash.events.EventDispatcher */
		
		override public function toString():String {
			//return "[ValueHolder: " + value + "]";
			return ObjectUtil.formatToString(this, "ValueHolder", "value", "name");
		}
		
		
	}
}