package saz.display.btnclip {
	import flash.display.*;
	import flash.events.*;
	
	/**
	 * ボタン。as2から移植。
	 * @author saz
	 * @deprecated	as2から移植したけど不要かな…。
	 */
	public class TimelineBtnClip extends BtnClip {
		
		protected var $timeline:MovieClip;
		
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
		private function $initTimelineEvents(inputObject:InteractiveObject, timelineObject:MovieClip):void {
			//timelineObject.mouseEnabled = false;
			//timelineObject.mouseChildren = false;
			//inputObject.mouseEnabled = true;
			
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
		}
		
		private function $onTimelineListener(e:MouseEvent):void{
			this.$timeline.gotoAndPlay(e.type);		//イベント名＝ラベル
		}
		
		public function get timelineObject():MovieClip { return $timeline; }
		
	}
	
}