package saz.number {
	import flash.events.EventDispatcher;
	import saz.events.ClipEvent;
	
	/**
	 * 制限つきNumber。
	 * @author saz
	 */
	public class ClipNumber extends EventDispatcher {
		
		private var $value:Number;
		private var $min:Number;
		private var $max:Number;
		
		private var $old:Number;
		
		/**
		 * コンストラクタ。
		 * @param	value	初期値。
		 * @param	min	最小値。
		 * @param	max	最大値。
		 * @example <listing version="3.0" >
		 * import saz.number.*;
		 * import saz.events.*;
		 * 
		 * var cn1:ClipNumber = new ClipNumber(5,0,10);
		 * cn1.addEventListener(ClipEvent.SMALL, onSmall);
		 * cn1.addEventListener(ClipEvent.LARGE, onLarge);
		 * cn1.addEventListener(ClipEvent.OVER, onOver);
		 * cn1.addEventListener(ClipEvent.CHANGE, onChange);
		 * 
		 * function onSmall (e:ClipEvent) {
		 * 	trace("onSmall");
		 * 	trace(e);
		 * }
		 * function onLarge (e:ClipEvent) {
		 * 	trace("onLarge");
		 * 	trace(e);
		 * }
		 * function onOver (e:ClipEvent) {
		 * 	trace("onOver");
		 * 	trace(e);
		 * }
		 * function onChange (e:ClipEvent) {
		 * 	trace("onChange");
		 * 	trace(e);
		 * }
		 * </listing>
		 */
		public function ClipNumber(value:Number, min:Number, max:Number) {
			$value = value;
			$min = min;
			$max = max;
		}
		
		public function get isMin():Boolean {
			return $value == $min;
		}
		
		public function get isMax():Boolean {
			return $value == $max;
		}
		
		// 制限値にクリップ。
		private function $clip():void {
			var over:Number = value;
			if ($value < $min) {
				$value = $min;
				dispatchEvent(new ClipEvent(ClipEvent.SMALL, $old, $value, over));
				dispatchEvent(new ClipEvent(ClipEvent.OVER, $old, $value, over));
			}else if ($max < $value) {
				$value = $max;
				dispatchEvent(new ClipEvent(ClipEvent.LARGE, $old, $value, over));
				dispatchEvent(new ClipEvent(ClipEvent.OVER, $old, $value, over));
			}
			dispatchEvent(new ClipEvent(ClipEvent.CHANGE, $old, $value, over));
		}
		
		/**
		 * 現在の値。
		 */
		public function get value():Number { return $value; }
		
		public function set value(value:Number):void {
			$old = $value;
			$value = value;
			$clip();
		}
		
		/**
		 * 最小値。
		 */
		public function get min():Number { return $min; }
		
		public function set min(value:Number):void {
			$min = value;
		}
		
		/**
		 * 最大値。
		 */
		public function get max():Number { return $max; }
		
		public function set max(value:Number):void {
			$max = value;
		}
		
	}

}