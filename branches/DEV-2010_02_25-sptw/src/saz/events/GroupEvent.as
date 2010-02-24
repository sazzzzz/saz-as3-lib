package saz.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author saz
	 */
	public class GroupEvent extends Event {
	//public class GroupEvent {
		public static var CHANGED:String = "changed";
		
		public var oldValue:*;
		public var newValue:*;
		
		function GroupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
	
}