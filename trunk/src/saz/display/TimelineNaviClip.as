package saz.display {
	import flash.display.*;
	import flash.events.*;
	import saz.events.NaviEvent;
	
	/**
	 * ...
	 * @author saz
	 */
	public class TimelineNaviClip extends NaviClip {
		
		protected var $timeline:MovieClip;
		//イベントON/OFFの制御用
		private var $timelineEnabled:Boolean;
		
		function TimelineNaviClip(inputObject:InteractiveObject, timelineObject:MovieClip) {
			super(inputObject);
			
			this.$timeline = timelineObject;
			this.$initTimelineEvents(inputObject);
			
			this.$timelineEnabled = true;
		}
		
		public function get timelineObject():MovieClip { return $timeline; }
		
		/**
		 * タイムラインコントロール用イベントを初期化
		 * @param	inputObject
		 * @param	timelineObject
		 */
		private function $initTimelineEvents(inputObject:InteractiveObject):void {
			inputObject.addEventListener(MouseEvent.CLICK , this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onTimelineListener);
			
			this.addEventListener(NaviEvent.SELECTED, this.$onSelected);
			this.addEventListener(NaviEvent.UNSELECTED, this.$onUnselected);
		}
		
		private function $removeTimelineEvents(inputObject:InteractiveObject):void {
			inputObject.removeEventListener(MouseEvent.CLICK , this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.DOUBLE_CLICK, this.$onTimelineListener);
			inputObject.removeEventListener(MouseEvent.ROLL_OVER, this.$onTimelineListener);
			inputObject.removeEventListener(MouseEvent.ROLL_OUT, this.$onTimelineListener);
			inputObject.removeEventListener(MouseEvent.MOUSE_DOWN, this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.MOUSE_UP, this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.MOUSE_OVER, this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.MOUSE_OUT, this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.MOUSE_MOVE, this.$onTimelineListener);
			//inputObject.removeEventListener(MouseEvent.MOUSE_WHEEL, this.$onTimelineListener);
			
			this.removeEventListener(NaviEvent.SELECTED, this.$onSelected);
			this.removeEventListener(NaviEvent.UNSELECTED, this.$onUnselected);
		}
		
		private function $onSelected(e:Event):void {
			//trace("TimelineNaviClip.$onSelected(" + arguments);
			this.$input.mouseEnabled = false;
			this.$timelineEnabled = false;
			//this.$removeTimelineEvents(this.$input);		//イベントが発生してしまう
			this.$timeline.gotoAndPlay(NaviEvent.SELECTED);
		}
		
		private function $onUnselected(e:Event):void {
			this.$input.mouseEnabled = true;
			this.$timelineEnabled = true;
			//this.$initTimelineEvents(this.$input);
			this.$timeline.gotoAndPlay(NaviEvent.UNSELECTED);
		}
		
		private function $onTimelineListener(e:MouseEvent):void {
			//trace("TimelineNaviClip.$onTimelineListener(" + arguments);
			//trace("TimelineNaviClip.$onTimelineListener(" + e.target);
			if (this.$timelineEnabled == false) return;
			this.$timeline.gotoAndPlay(e.type);		//イベント名＝ラベル
		}
		
	}
	
}