package saz.events {
	import flash.display.DisplayObject;
	import flash.events.*;
	
	/**
	 * 一定フレームごとにイベント発生
	 * @author saz
	 */
	//public class IntervalFrame extends EventDispatcher {
	public class IntervalFrame implements IEventDispatcher {
		
		private var $trigger:DisplayObject;
		private var $interval:int;
		private var $count:int;
		private var $ed:EventDispatcher;
		
		/**
		 * コンストラクタ
		 * @param	triggerObj	Event.ENTER_FRAMEを送出するDisplayObject
		 * @param	interval	イベントを発生させる間隔。0=毎フレーム、1=1フレームおき。
		 * @example <listing version="3.0" >
		 * var intervalFrame = new IntervalFrame(StageReference.stage, 1);
		 * intervalFrame.addEventListener(TimerEvent.TIMER, $onUpdate);
		 * function $onUpdate(e:TimerEvent):void {
		 * 	// do something
		 * }
		 * </listing>
		 */
		function IntervalFrame(triggerObj:DisplayObject, interval:int = 1) {
			$trigger = triggerObj;
			$interval = interval;
			
			$ed = new EventDispatcher();
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			$ed.addEventListener(type, listener, useCapture, priority, useWeakReference);
			$start();
		}
		public function dispatchEvent(event:Event):Boolean {
			return $ed.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean {
			return $ed.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			$ed.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return $ed.willTrigger(type);
		}
		
		
		private function $start():void {
			$restart();
			$trigger.addEventListener(Event.ENTER_FRAME, $loop);
		}
		
		private function $restart():void {
			$count = $interval + 1;
		}
		private function $loop(e:Event):void{
			$count--;
			if (0 == $count) {
				//dispatchEvent(new Event(Event.ENTER_FRAME));
				dispatchEvent(new Event(TimerEvent.TIMER));
				$restart();
			}
		}
		
		private function $stop():void {
			//イベントが使われてなければ停止
			if (!hasEventListener(Event.ENTER_FRAME)) {
				$trigger.removeEventListener(Event.ENTER_FRAME, $loop);
			}
		}
		
	}
	
}