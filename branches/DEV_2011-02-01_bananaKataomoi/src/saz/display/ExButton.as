package saz.display {
	import flash.display.*;
	import flash.events.MouseEvent;
	
	/**
	 * 簡易ボタン。
	 * @author saz
	 */
	public class ExButton extends Sprite {
		
		private var $onRollOver:Function;
		private var $onRollOut:Function;
		private var $onClick:Function;
		private var $onDoubleClick:Function;
		private var $onMouseDown:Function;
		private var $onMouseUp:Function;
		private var $onMouseMove:Function;
		
		
		public function ExButton() {
			super();
			
			$initHaldlers();
			mouseEnabled = true;
			buttonMode = true;
		}
		
		private function $initHaldlers():void {
			atRollOver = function(e:MouseEvent):void { $atRollOver(e); }
			atRollOut = function(e:MouseEvent):void { $atRollOut(e); }
			atClick = function(e:MouseEvent):void { $atClick(e); }
			atDoubleClick = function(e:MouseEvent):void { $atDoubleClick(e); }
			atMouseDown = function(e:MouseEvent):void { $atMouseDown(e); }
			atMouseUp = function(e:MouseEvent):void { $atMouseUp(e); }
			atMouseMove = function(e:MouseEvent):void { $atMouseMove(e); }
		}
		
		protected function $atRollOver(e:MouseEvent):void { }
		protected function $atRollOut(e:MouseEvent):void { }
		protected function $atClick(e:MouseEvent):void { }
		protected function $atDoubleClick(e:MouseEvent):void { }
		protected function $atMouseDown(e:MouseEvent):void { }
		protected function $atMouseUp(e:MouseEvent):void { }
		protected function $atMouseMove(e:MouseEvent):void { }
		
		
		
		// イベントハンドラ設定処理
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
		
		
		
		
		public function get atRollOver():Function { return $onRollOver; }
		
		public function set atRollOver(func:Function):void {
			$setEventHandler(func, MouseEvent.ROLL_OVER, "$onRollOver", $onRollOver);
		}
		
		public function get atRollOut():Function { return $onRollOut; }
		
		public function set atRollOut(func:Function):void {
			$setEventHandler(func, MouseEvent.ROLL_OUT, "$onRollOut", $onRollOut);
		}
		
		public function get atClick():Function { return $onClick; }
		
		public function set atClick(func:Function):void {
			$setEventHandler(func, MouseEvent.CLICK, "$onClick", $onClick);
		}
		
		public function get atDoubleClick():Function { return $onDoubleClick; }
		
		public function set atDoubleClick(func:Function):void {
			$setEventHandler(func, MouseEvent.DOUBLE_CLICK, "$onDoubleClick", $onDoubleClick);
			doubleClickEnabled = hasEventListener(MouseEvent.DOUBLE_CLICK);
		}
		
		
		public function get atMouseDown():Function { return $onMouseDown; }
		
		public function set atMouseDown(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_DOWN, "$onMouseDown", $onMouseDown);
		}
		
		public function get atMouseUp():Function { return $onMouseUp; }
		
		public function set atMouseUp(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_UP, "$onMouseUp", $onMouseUp);
		}
		
		public function get atMouseMove():Function { return $onMouseMove; }
		
		public function set atMouseMove(func:Function):void {
			$setEventHandler(func, MouseEvent.MOUSE_MOVE, "$onMouseMove", $onMouseMove);
		}
		
		
		
		
		
	}

}