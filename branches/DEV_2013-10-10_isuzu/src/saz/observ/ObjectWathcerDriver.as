package saz.observ
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * 指定したイベントの発生時に、ObjectWatcher.check()を実行する。
	 * ENTER_FRAMEとかで定期的に実行するためのもの。
	 * @author saz
	 * 
	 */
	public class ObjectWathcerDriver
	{
		
		public var target:IObjectWatcher;
		
		public var dispatcher:IEventDispatcher;
		public var eventType:String;
		
		
		/**
		 * コンストラクタ。
		 * @param target	対象ObjectWatcher。
		 * 
		 */
		public function ObjectWathcerDriver(target:IObjectWatcher)
		{
			this.target = target;
		}
		
		public function setEvent(dispatcher:IEventDispatcher, eventType:String):void
		{
			this.dispatcher = dispatcher;
			this.eventType = eventType;
		}
		
		public function start():void
		{
			target.ready();
			dispatcher.addEventListener(eventType, _dispatcher_handler);
		}
		
		public function stop():void
		{
			dispatcher.removeEventListener(eventType, _dispatcher_handler);
		}
		
		
		protected function _dispatcher_handler(event:Event):void
		{
			target.check();
		}
		
	}
}