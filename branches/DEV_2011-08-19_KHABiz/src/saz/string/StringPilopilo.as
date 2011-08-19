package saz.string {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * 文字がピロピロ出てくるアニメーションを実行する. 対象はTextFieldじゃなくてもよく、Stringインスタンスであればできる. 
	 * @author saz
	 */
	public class StringPilopilo extends EventDispatcher {
		
		public var targetObj:Object;
		public var propName:String;
		public var text:String;
		
		private var $position:Number = 0;
		private var $speed:Number = 1;
		private var $isRunning:Boolean = false;
		
		private var $dispatcher:IEventDispatcher;
		private var $eventType:String;
		
		
		public function StringPilopilo(targetObj:Object = null, propName:String = "text") {
			super();
			
			if(targetObj) this.targetObj = targetObj;
			if(propName) this.propName = propName;
		}
		
		public function start(text:String):void {
			if ($isRunning) return;
			this.text = text;
			$position = 0;
			$start();
		}
		
		public function resume():void {
			if ($isRunning) return;
			$start();
		}
		
		private function $start():void {
			$isRunning = true;
			$dispatcher.addEventListener($eventType, $loop);
		}
		
		public function stop():void {
			if (!$isRunning) return;
			$isRunning = false;
			$dispatcher.removeEventListener($eventType, $loop);
			
			//targetObj[propName] += "<";	//終了テスト
		}
		
		public function setListen(dispatcher:IEventDispatcher, eventType:String):void {
			if ($isRunning) {
				$dispatcher.removeEventListener($eventType, $loop);
				dispatcher.addEventListener(eventType, $loop);
			}
			$dispatcher = dispatcher;
			$eventType = eventType;
		}
		
		public function pilo():void {
			targetObj[propName] += text.substr(Math.round($position), Math.round($speed));
			$position += $speed;
			//終了判定
			if (text.length < Math.round($position)) stop();
		}
		
		
		
		
		private function $loop(e:Event):void {
			pilo();
		}
		
		
		
		
		
		
		
		
		
		
		public function get position():Number {
			return $position;
		}
		
		public function set position(value:Number):void {
			$position = value;
		}
		
		public function get speed():Number {
			return $speed;
		}
		
		public function set speed(value:Number):void {
			$speed = value;
		}
		
		public function get isRunning():Boolean {
			return $isRunning;
		}
		
	}

}