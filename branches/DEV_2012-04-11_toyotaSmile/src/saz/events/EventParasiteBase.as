package saz.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * イベントに寄生する？. 
	 * @author saz
	 * 
	 */
	public class EventParasiteBase extends EventDispatcher
	{
		private var _target:IEventDispatcher;
		
		public function EventParasiteBase(target:IEventDispatcher)
		{
			super();
			
			_target = target;
		}
		
		protected function attachEvent(eventType:String, listener:Function):void{
			_target.addEventListener(eventType, listener);
		}
		
		protected function detachEvent(eventType:String, listener:Function):void{
			_target.removeEventListener(eventType, listener);
		}
		
	}
}