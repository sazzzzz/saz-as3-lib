package saz.display.dialog {
	import flash.events.Event;
	
	/**
	 * ダイアログイベント。
	 * @author saz
	 */
	public class DialogEvent extends Event {
		
		/**
		 * 閉じられた。
		 */
		static public const CLOSE:String = "close";
		
		public var result:String;
		
		public function DialogEvent(type:String, result:String) { 
			super(type, false, false);
			
			this.result = result;
		} 
		
		public override function clone():Event { 
			return new DialogEvent(type, result);
		} 
		
		public override function toString():String { 
			return formatToString("DialogEvent", "type", "result", "eventPhase"); 
		}
		
	}
	
}