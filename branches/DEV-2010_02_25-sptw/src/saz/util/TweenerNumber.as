package saz.util {
	import caurina.transitions.Tweener;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import saz.events.WatchEvent;
	
	/**
	 * トィーン中に、ターゲットのプロパティが更新されるごとに、送出されます。変化がなかったらイベントは発行しない。
	 * @eventType saz.events.WatchEvent.UPDATE
	 */
	[Event(name = "update", type = "saz.events.WatchEvent")]
	
	/**
	 * トィーンが完了したとき。isTween=falseの時も発行されます。
	 * @eventType saz.events.WatchEvent.COMPLETE
	 */
	[Event(name = "complete", type = "saz.events.WatchEvent")]
	
	
	/**
	 * Tweenerで補完するNumber。EventDispatcherつき。
	 * @author saz
	 */
	public class TweenerNumber extends EventDispatcher {
		
		public var $value:Number = 0;
		
		private var $oldVal:Number;
		private var $prevVal:Number;
		
		public var time:Number = 0;
		public var transition:String = "easeOutExpo";
		
		function TweenerNumber() {
			super();
		}
		
		/**
		 * すぐに変更
		 * @param	value
		 */
		public function change(value:Number):void {
			$oldVal = $value;
			$value = value;
			$onComplete();
		}
		
		/**
		 * トィーンつきで変更
		 * @param	value
		 */
		public function tweenChange(value:Number):void {
			trace("TweenerNumber.tweenChange(" + arguments);
			$oldVal = $value;
			$prevVal = $value;
			Tweener.removeTweens(this);
			Tweener.addTween(this, { $value:value, time:time, transition:transition, onUpdate:$onUpdate, onComplete:$onComplete } );
		}
		
		private function $onUpdate():void {
			//変化がなかったらイベントは発行しない。
			if ($prevVal == value) return;
			dispatchEvent(new WatchEvent(WatchEvent.UPDATE, "value", $prevVal, value));
			$prevVal = value;
		}
		
		private function $onComplete():void{
			dispatchEvent(new WatchEvent(WatchEvent.COMPLETE, "value", $oldVal, value));
			$oldVal = $value;
		}
		
		public function get value():Number { return $value; }
		
		public function set value(value:Number):void {
			$value = value;
		}
		
		
	}
	
}