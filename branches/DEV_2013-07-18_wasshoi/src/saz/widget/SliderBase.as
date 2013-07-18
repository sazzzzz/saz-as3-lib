package saz.widget
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import saz.events.DynamicEvent;
	import saz.events.WatchEvent;
	
	public class SliderBase extends Sprite implements IRange
	{
		
		//--------------------------------------
		// IRange
		//--------------------------------------
		
		public function get value():Number
		{
			return _cnt.value;
		}
		public function set value(val:Number):void
		{
			var nv:Number = _clipValue(val);
			_pendingValue = nv;
			if (_isDragging) return;
			_cnt.value = nv;
			setThumPosition(nv / (maximum - minimum) * size + _initPos);
		}
		
		public function get minimum():Number
		{
			return _cnt.minimum;
		}
		public function set minimum(val:Number):void
		{
			_cnt.minimum = val;
		}
		
		public function get maximum():Number
		{
			return _cnt.maximum;
		}
		public function set maximum(val:Number):void
		{
			_cnt.maximum = val;
		}
		
		
		public function get snapInterval():Number
		{
			return _cnt.snapInterval;
		}
		public function set snapInterval(val:Number):void
		{
			_cnt.snapInterval = val;
		}
		
		
		//--------------------------------------
		// 独自
		//--------------------------------------
		
		public var size:Number = 100;
		public var liveDragging:Boolean = false;
		
		protected var thum:InteractiveObject;
		
		private var _cnt:SliderController;
		
		private var _initPos:Number = 0;
		private var _startMousePos:Number = 0;
		private var _posDiff:Number = 0;
		private var _pendingValue:Number = 0;
		
		private var _isDragging:Boolean = false;
		
		
		
		public function SliderBase(thumObj:InteractiveObject)
		{
			super();
			
			_init(thumObj);
		}
		
		//--------------------------------------
		// for subclass
		//--------------------------------------
		
		protected function getThumPosition():Number
		{
			return 0;
		}
		
		protected function setThumPosition(value:Number):void
		{
		}
		
		protected function getMousePosition():Number
		{
			return 0;
		}
		
		
		//--------------------------------------
		// 
		//--------------------------------------
		
		private function _clipValue(val:Number):Number
		{
			return Math.max(minimum, Math.min(val, maximum));
		}
		
		private function _valueForController(val:Number):Number
		{
			return ((val - _initPos) / size) * (_cnt.maximum - _cnt.minimum) + _cnt.minimum;
		}
		
		private function _init(thumObj:InteractiveObject):void
		{
			thum = thumObj;
			_initPos = getThumPosition();
			thum.addEventListener(MouseEvent.MOUSE_DOWN, thum_mouseDown);
			
			_cnt = new SliderController();
		}
		
		private function _dispatch():void
		{
			var ov:Number = _cnt.value;
			var nv:Number = _valueForController(getThumPosition());
			_cnt.value = nv;
			dispatchEvent(new WatchEvent(WatchEvent.CHANGE, "value", ov, nv));
		}
		
		//--------------------------------------
		// listener
		//--------------------------------------
		
		private function thum_mouseDown(event:MouseEvent):void
		{
			_isDragging = true;
			_startMousePos = getMousePosition();
			_posDiff = getThumPosition() - _startMousePos;
			
			thum.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.addEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
		}
		
		private function thum_mouseUp(event:MouseEvent):void
		{
			
			_isDragging = false;
			thum.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
			
			_dispatch();
		}
		
		private function dragLoop(event:Event):void
		{
			setThumPosition(Math.max(_initPos, Math.min(_startMousePos + getMousePosition() - _startMousePos + _posDiff, _initPos + size)));
			if (liveDragging) _dispatch();
		}
		
	}
}