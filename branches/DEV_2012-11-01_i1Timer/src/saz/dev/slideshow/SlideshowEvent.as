package saz.dev.slideshow {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author saz
	 */
	public class SlideshowEvent extends Event {
		
		static public const FADE_START:String = "fadeStart";
		static public const FADE_COMPLETE:String = "fadeComplete";
		//static public const FADE_PROGRESS:String = "fadeProgress";
		
		public function SlideshowEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new SlideshowEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("SlideshowEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}