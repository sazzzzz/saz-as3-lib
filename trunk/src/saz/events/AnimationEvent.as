package saz.events {
	import flash.events.Event;
	
	/**
	 * アニメーションイベント。<s>StringAnimator用。</s>未使用みたい.
	 * @author saz
	 */
	public class AnimationEvent extends Event {
		
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new AnimationEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("AnimationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}