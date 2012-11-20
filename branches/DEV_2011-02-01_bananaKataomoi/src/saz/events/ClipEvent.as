package saz.events {
	import flash.events.Event;
	
	/**
	 * ClipNumber用イベント。
	 * @author saz
	 */
	public class ClipEvent extends Event {
		
		public static const CHANGE:String = "change";
		public static const SMALL:String = "small";
		public static const LARGE:String = "large";
		public static const OVER:String = "over";
		
		//public var key:String;
		public var oldValue:*;
		public var newValue:*;
		public var overValue:*;
		
		
		//public function ClipEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
		public function ClipEvent(type:String, oldValue:*, newValue:*, overValue:*) { 
			super(type);
			
			this.oldValue = oldValue;
			this.newValue = newValue;
			this.overValue = overValue;
		} 
		
		public override function clone():Event { 
			return new WatchEvent(type, oldValue, newValue, overValue);
		} 
		
		public override function toString():String { 
			return formatToString("ClipEvent", "type", "oldValue", "newValue", "overValue"); 
		}
		
	}
	
}