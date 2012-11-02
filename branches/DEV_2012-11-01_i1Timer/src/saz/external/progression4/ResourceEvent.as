package saz.external.progression4 {
	import flash.events.*;
	import jp.progression.data.Resource;
	
	/**
	 * ResourceManager用イベント。
	 * ccjc.commonから持ってきた。
	 * @author saz
	 */
	public class ResourceEvent extends Event {
		
		public static const COMPLETE:String = "complete";
		
		public var id:String;
		
		/**
		 * @param	type	イベントタイプ
		 * @param	url	id=url
		 */
		function ResourceEvent(type:String, url:String) {
		//function ResourceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, key:String, oldValue:*, newValue:*) {
			super(type, false, false);
			
			this.id = url;
		}
		
		public override function clone():Event {
			return new ResourceEvent(type, id);
		}
		
		public override function toString():String {
			return formatToString("ResourceEvent", "type", "id"); 
		}
		
	}
	
}