package saz.events {
	import flash.events.*;
	
	/**
	 * ループするイベント。暫定で作っちゃった
	 * @author saz
	 */
	public class LoopEvent extends Event {
		
		public static const LOOP:String = "loop";
		
		function LoopEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
	}
	
}