package saz.display {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import saz.events.DynamicEvent;
	
	/**
	 * ...
	 * @author saz
	 */
	public class InvisibleButton extends EventDispatcher {
		
		//private static const STOP:String = "stop";
		
		private var $state:String = MouseEvent.ROLL_OUT;
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
			$setState(($rect.contains($container.mouseX, $container.mouseY)) ? MouseEvent.ROLL_OVER : MouseEvent.ROLL_OUT);
		}
		
		private function $setState(state:String):void {
			if ($state == state) return;
			$state = state;
			dispatchEvent(new MouseEvent(state));
		}
		
		
		public function start():void {
			if (!$rect) throw new Error("範囲が指定されていません。setRect()またはsetRectangle()で、判定範囲を指定してください。");
			$isRunning = true;
			$dispatcher.addEventListener($eventType, $loop);
		}
		
		public function stop():void {
			//$state = STOP;
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