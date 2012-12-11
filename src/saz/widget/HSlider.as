package saz.widget
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HSlider extends Sprite implements IRange
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
			_cnt.value = val;
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
		
		private var _cnt:SliderController;

		private var thum:InteractiveObject;

		private var initPos:Number = 0;
		private var startMousePos:Number = 0;
		private var posDiff:Number = 0;
		
		
		
		
		public function HSlider(thumObj:InteractiveObject)
		{
			super();
			
			init(thumObj);
		}
		
		
		
		protected function init(thumObj:InteractiveObject):void
		{
			thum = thumObj;
			initPos = thum.x;
			thum.addEventListener(MouseEvent.MOUSE_DOWN, thum_mouseDown);
			
			_cnt = new SliderController();
		}
		
		protected function thum_mouseDown(event:MouseEvent):void
		{
			startMousePos = thum.parent.mouseX;
			posDiff = thum.x - startMousePos;
			
			thum.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.addEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.addEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
		}
		
		protected function thum_mouseUp(event:MouseEvent):void
		{
			thum.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			thum.stage.removeEventListener(MouseEvent.MOUSE_UP, thum_mouseUp);
			
			thum.stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragLoop);
			
			_cnt.value = valueForController(thum.x);
		}
		
		protected function dragLoop(event:Event):void
		{
//			thum.x = _cnt.clipValue(valueForController(startMousePos + thum.parent.mouseX - startMousePos + posDiff)) + initPos;
			thum.x = _cnt.clipValue(_cnt.calcForValue(startMousePos + thum.parent.mouseX - startMousePos + posDiff, initPos, initPos + size)) + initPos
		}
		
		protected function valueForController(val:Number):Number
		{
			return ((val - initPos) / size) * (_cnt.maximum - _cnt.minimum) + _cnt.minimum;
		}
		
	}
}