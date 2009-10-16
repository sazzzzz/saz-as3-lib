package saz.display {
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author saz
	 */
	public class TimelineBtnClip extends BtnClip {
		
		private var $timeline:MovieClip;
		
		
		function TimelineBtnClip(inputObject:InteractiveObject, timelineObject:MovieClip) {
			super(inputObject);
			
			this.$timeline = timelineObject;
			this.$initTimelineEvents(inputObject, timelineObject);
		}
		
		/**
		 * タイムラインコントロール用イベントを初期化
		 * @param	inputObject
		 * @param	timelineObject
		 */
		private function $initTimelineEvents(inputObject:InteractiveObject,timelineObject:MovieClip):void{
			/*inputObject.addEventListener(MouseEvent.CLICK , this.$onClick);
			inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onDoubleClick);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onMouseDown);
			inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onMouseMove);
			inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onMouseOut);
			inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onMouseOver);
			inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onMouseUp);
			inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onMouseWheel);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onRollOut);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onRollOver);*/
			inputObject.addEventListener(MouseEvent.CLICK , this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.DOUBLE_CLICK, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.MOUSE_DOWN, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_MOVE, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_OUT, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_OVER, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_UP, this.$onTimelineListener);
			//inputObject.addEventListener(MouseEvent.MOUSE_WHEEL, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.ROLL_OUT, this.$onTimelineListener);
			inputObject.addEventListener(MouseEvent.ROLL_OVER, this.$onTimelineListener);
		}
		
		private function $onTimelineListener(e:MouseEvent):void{
			this.$timeline.gotoAndPlay(e.type);		//イベント名＝ラベル
		}
		
	}
	
}