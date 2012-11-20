package saz.events {
	import flash.events.*;
	
	// Eventテンプレート。
	// http://source-laboratory.net/blog/2010/01/as3event-1.html
	// http://www.adobeauthorizations.com/livedocs/flex/2_jp/langref/flash/events/Event.html#formatToString()
	
	/**
	 * 
	 * @author saz
	 */
	public class MyEvent extends Event {
		
		public static const EVENTTYPE:String = "eventType";
		
		public var prop:*;
		
		function MyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, prop:*) {
			super(type, bubbles, cancelable);
			
			this.prop = prop;
		}
		
		public override function clone():Event {
			return new MyEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("MyEvent", "type", "bubbles", "cancelable", "eventPhase", "prop"); 
		}
		
	}
	
}