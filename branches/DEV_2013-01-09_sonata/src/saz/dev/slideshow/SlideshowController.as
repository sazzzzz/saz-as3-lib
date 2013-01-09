package saz.dev.slideshow {
	import caurina.transitions.Tweener;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author saz
	 */
	public class SlideshowController extends EventDispatcher {
		
		public var target:BitmapData;
		public var time:Number = 1.0;
		public var interval:Number = 5.0;
		public var transition:String = "linear";
		
		// 未実装
		//public var startTime:Number = 0.0;
		//public var loop:Boolean = true;
		//private var _updateEventSrc:IEventDispatcher;
		//private var _updateEventType:String;
		
		
		public var atFade:Function = SlideshowFader.crossFade;
		public var atStart:Function = function():void{};
		public var atStop:Function = function():void{};
		
		public function get index():int {
			return _index;
		}
		private var _index:int = 0;
		
		private var _bmps:Array = [];
		
		private var _tweenTarget:Object = { };
		private var _timer:Timer;
		
		public function SlideshowController(targetBitmapData:BitmapData) {
			super();
			
			target = targetBitmapData;
		}
		
		
		
		private function _draw(index:int):void {
			atFade(target, 0.0, getItemAt(index), getItemAt(index));
		}
		
		private function _makeFader(outIndex:int, inIndex:int):void {
			_index = inIndex;
			
			var dstBmp:BitmapData = target;
			var outBmp:BitmapData = getItemAt(outIndex);
			//var outBmp:BitmapData = dstBmp.clone();
			var inBmp:BitmapData = getItemAt(inIndex);
			var self:SlideshowController = this;
			
			_tweenTarget.value = 0.0;
			dispatchEvent(new SlideshowEvent(SlideshowEvent.FADE_START));
			
			Tweener.addTween(_tweenTarget, {
				time:time, value:1.0, transition:transition,
				onUpdate:function():void {
					self.atFade(dstBmp, _tweenTarget.value, outBmp, inBmp);
				},
				onComplete:function():void {
					self.dispatchEvent(new SlideshowEvent(SlideshowEvent.FADE_COMPLETE));
				}
			} );
		}
		
		public function get count():int {
			return _bmps.length;
		}
		
		
		
		
		public function getItemAt(index:int):BitmapData {
			return _bmps[index];
		}
		
		public function addItem(bmp:BitmapData):void {
			_bmps.push(bmp);
		}
		
		public function clearItem():void {
			_bmps.length = 0;
		}
		
		
		private function _timer_timer(e:TimerEvent):void {
			next();
		}
		
		
		public function start():void {
			_draw(_index);
			_timer = new Timer(interval * 1000);
			_timer.addEventListener(TimerEvent.TIMER, _timer_timer);
			_timer.start();
		}
		
		public function stop():void {
			if (_timer)_timer.stop();
		}
		
		public function next():void {
			_makeFader(_index, (_index + 1) % count);
		}
		
		public function prev():void {
			_makeFader(_index, (_index - 1 + count) % count);
		}
		
		public function gotoAt(index:int):void {
			//_makeFader(_index, index);
			_draw(_index);
		}
		
		
	}

}