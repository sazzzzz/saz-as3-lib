package saz.display {
	import flash.display.*;
	import flash.events.MouseEvent;
	
	/**
	 * 簡易ボタン。
	 * @author saz
	 */
	public class ExButton extends Sprite {
		
		private var $atRollOver:Function;
		private var $atRollOut:Function;
		private var $atClick:Function;
		private var $atDoubleClick:Function;
		private var $atMouseDown:Function;
		private var $atMouseMove:Function;
		private var $atMouseUp:Function;
		
		public function ExButton() {
			super();
		}
		
		private function $setEventHandler(func:Function, type:String, handlerName:String, curHandler:Function):void {
			if (func == curHandler) return;
			
			//今のをremove
			if (null != curHandler) {
				removeEventListener(type, curHandler);
			}
			if (null != func) {
				addEventListener(type, func, false, 0, true);
				this[handlerName] = func;
			}
		}
		
		public function get atRollOver():Function { return $atRollOver; }
		
		public function set atRollOver(func:Function):void {
			$setEventHandler(func, MouseEvent.ROLL_OVER, "$atRollOver", $atRollOver);
		}
		
		public function get atRollOut():Function { return $atRollOut; }
		
		public function set atRollOut(func:Function):void {
			$setEventHandler(func, MouseEvent.ROLL_OUT, "$atRollOut", $atRollOut);
		}
		
		public function get atClick():Function { return $atClick; }
		
		public function set atClick(func:Function):void {
			$setEventHandler(func, MouseEvent.CLICK, "$atClick", $atClick);
		}
		
		public function get atDoubleClick():Function { return $atDoubleClick; }
		
		public function set atDoubleClick(func:Function):void {
			$setEventHandler(func, MouseEvent.DOUBLE_CLICK, "$atDoubleClick", $atDoubleClick);
			doubleClickEnabled = hasEventListener(MouseEvent.DOUBLE_CLICK);
			/*if (null != func) {
				doubleClickEnabled = true;
				addEventListener(MouseEvent.DOUBLE_CLICK, func);
			}else {
				if (hasEventListener(MouseEvent.DOUBLE_CLICK)) doubleClickEnabled = false;
				removeEventListener(MouseEvent.DOUBLE_CLICK, $atDoubleClick);
			}
			$atDoubleClick = func;*/
		}
		
		
		public function get atMouseDown():Function { return $atMouseDown; }
		
		public function set atMouseDown(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_DOWN, "$atMouseDown", $atMouseDown);
		}
		
		public function get atMouseUp():Function { return $atMouseUp; }
		
		public function set atMouseUp(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_UP, "$atMouseUp", $atMouseUp);
		}
		
		public function get atMouseMove():Function { return $atMouseMove; }
		
		public function set atMouseMove(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_MOVE, "$atMouseMove", $atMouseMove);
		}
		
	}

}