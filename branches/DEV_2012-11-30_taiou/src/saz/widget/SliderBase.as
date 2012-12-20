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
			pendingValue = val;
			if (isDragging) return;
			_cnt.value = val;
			setThumPosition(val / (maximum - minimum) * size + initPos);
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
		
		protected var thum:InteractiveObject;
		
		private var _cnt:SliderController;
		
		private var initPos:Number = 0;
		private var startMousePos:Number = 0;
		private var posDiff:Number = 0;
		private var pendingValue:Number = 0;
		
		private var isDragging:Boolean = false;
		
		
		
		public function SliderBase(thumObj:InteractiveObject)
		{
			super();
			
			init(thumObj);
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
		
		
		private function init(thumObj:InteractiveObject):void
		{
			thum = thumObj;
			initPos = getThumPosition();
			thum.addEventListener(MouseEvent.MOUSE_DOWN, thum_mouseDown);
			
			_cnt = new SliderController();
		}
		
		private function thum_mouseDown(event:MouseEvent):void
		{
			isDragging = true;
			startMousePos = getMousePosition();
			posDiff = getThumPosition() - startMousePos;
			
			thum.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.addEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
		}
		
		private function thum_mouseUp(event:MouseEvent):void
		{
			var old:Number = _cnt.value;
			
			isDragging = false;
			thum.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
			
			var nv:Number = valueForController(getThumPosition());
			_cnt.value = nv;
			dispatchEvent(new WatchEvent(WatchEvent.CHANGE, "value", old, nv));
		}
		
		private function dragLoop(event:Event):void
		{
			setThumPosition(Math.max(initPos, Math.min(startMousePos + getMousePosition() - startMousePos + posDiff, initPos + size)));
		}
		
		private function valueForController(val:Number):Number
		{
			return ((val - initPos) / size) * (_cnt.maximum - _cnt.minimum) + _cnt.minimum;
		}
		
	}
}