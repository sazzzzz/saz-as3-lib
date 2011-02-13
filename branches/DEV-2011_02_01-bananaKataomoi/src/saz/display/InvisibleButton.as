package saz.display {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;
	import saz.events.DynamicEvent;
	
	/**
	 * ...
	 * @author saz
	 */
	public class InvisibleButton extends EventDispatcher {
		
		public static const STATE_STOP:String = "stop";
		public static const INSIDE:String = "inside";
		public static const OUTSIDE:String = "outside";
		
		private var $state:String = STATE_STOP;
		private var $isRunning:Boolean = false;
		
		private var $container:DisplayObject;
		private var $dispatcher:IEventDispatcher;
		private var $eventType:String = Event.ENTER_FRAME;
		private var $rect:Rectangle;
		
		public function InvisibleButton(container:DisplayObject) {
			super();
			
			$container = container;
			$dispatcher = container;
		}
		
		private function $loop(e:Event):void {
			$setState(($rect.contains($container.mouseX, $container.mouseY)) ? INSIDE : OUTSIDE);
		}
		
		private function $setState(state:String):void {
			if ($state == state) return;
			$state = state;
			dispatchEvent(new DynamicEvent(state));
		}
		
		
		public function start():void {
			if (!$rect) throw new Error("範囲が指定されていません。setRect()またはsetRectangle()で、判定範囲を指定してください。");
			$isRunning = true;
			$dispatcher.addEventListener($eventType, $loop);
		}
		
		public function stop():void {
			$state = STATE_STOP;
			$isRunning = false;
			$dispatcher.removeEventListener($eventType, $loop);
		}
		
		public function setRect(x:Number, y:Number, width:Number, height:Number):void {
			setRectangle(new Rectangle(x, y, width, height));
		}
		
		public function setRectangle(rect:Rectangle):void {
			$rect = rect;
		}
		
		public function listen(dispatcher:IEventDispatcher, eventType:String):void {
			if (isRunning) {
				//実行中
				stop();
				$dispatcher = dispatcher;
				$eventType = eventType;
				start();
			}else {
				$dispatcher = dispatcher;
				$eventType = eventType;
			}
		}
		
		
		public function get state():String {
			return $state;
		}
		
		public function get isRunning():Boolean {
			return $isRunning;
		}
		
	}

}