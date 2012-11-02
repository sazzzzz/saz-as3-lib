package saz.display
{
	import flash.display.FrameLabel;
	import flash.events.Event;
	
	/**
	 * LabelEventRegister用イベント。
	 * @author saz
	 */
	public class LabelEvent extends Event
	{
		
		/**
		 * ラベルイベント。
		 * @default 
		 */
		public static const LABEL:String = "label";
		
		
		/**
		 * FrameLabelインスタンス。
		 * @return 
		 */
		public function get frameLabel():FrameLabel
		{
			return _frameLabel;
		}
		private var _frameLabel:FrameLabel;
		
		
		/**
		 * コンストラクタ。
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * @param label
		 */
		public function LabelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, label:FrameLabel=null)
		{
			super(type, bubbles, cancelable);
			_frameLabel = label || null;
		}
	}
}