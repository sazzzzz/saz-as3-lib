package saz.events {
	import flash.events.Event;
	
	import saz.util.ObjectUtil;
	
	/**
	 * 実行時に任意のプロパティを設定できるイベント。
	 * Flexのまね。
	 * @author saz
	 * @see	http://level0.kayac.com/2010/07/dispatchevent_dynamicevent.php
	 * @see	http://www.adobe.com/livedocs/flex/3_jp/langref/mx/events/DynamicEvent.html
	 */
	dynamic public class DynamicEvent extends Event {
		
		public function DynamicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, initObject:Object = null) { 
			super(type, bubbles, cancelable);
			
			if (initObject) ObjectUtil.setProperties(this, initObject);
		} 
		
		public override function clone():Event { 
			var res:Event = new DynamicEvent(type, bubbles, cancelable);
			ObjectUtil.setProperties(res, this);
			return res;
		} 
		
		public override function toString():String { 
			return formatToString("DynamicEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}