package saz.widget
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	public class SliderController extends EventDispatcher implements IRange
	{
		
		public function get value():Number
		{
			return _value;
		}
		public function set value(val:Number):void
		{
			_value = clipValue(val);
			setValue(_value);
		}
		private var _value:Number = 0;
		
		
		public function get minimum():Number
		{
			return _min;
		}
		public function set minimum(val:Number):void
		{
			_min = val;
		}
		private var _min:Number = 0;
		
		public function get maximum():Number
		{
			return _max;
		}
		public function set maximum(val:Number):void
		{
			_max = val;
		}
		private var _max:Number = 100;
		
		
		public var snapInterval:Number = 0.1;
		
		/**
		 * 未実装。
		 */
		public var stepSize:Number = 1;
		
		/**
		 * 未実装。
		 */
		public var pendingValue:Number = 0;
		
		/**
		 * 未実装。
		 */
		public var liveDragging:Boolean = false;
		
		
		public var onChange:Function;
		
		
		public function SliderController()
		{
			super();
			
			onChange = function(val:Number):void{};
		}
		
		/**
		 * valueのクリップ
		 * @param val
		 * @return 
		 * 
		 */
		public function clipValue(val:Number):Number
		{
			if (val < _min) return _min;
			if (_max < val) return _max;
			if (snapInterval == 0) return val;
			return Math.round(val / snapInterval) * snapInterval;
		}
		
		public function calcForValue(val:Number, min:Number, max:Number):Number
		{
			return ((val - min) / (max - min)) * (maximum - minimum) + minimum;
		}
		
		
		/**
		 * 未実装。
		 * @param increase
		 * 
		 */
		public function changeValueByStep(increase:Boolean = true):void
		{
			
		}
		
		//--------------------------------------
		// for subclasses
		//--------------------------------------
		
		protected function setValue(val:Number):void
		{
			onChange(val);
		}
		
	}
}