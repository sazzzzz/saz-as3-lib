package saz.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * イベントを委譲（？）する。
	 * @author saz
	 * 
	 * fromに設定したオブジェクトにイベントが発生すると、toに設定したオブジェクトがイベントを発行するように設定。
	 */
	public class EventDelegator
	{
		
		public var from:IEventDispatcher;
		public var to:IEventDispatcher;
		
		private var _handlers:Object = {};
		
		/**
		 * コンストラクタ。
		 * @param fromDispatcher	委譲元。
		 * @param toDispatcher	委譲先。
		 * 
		 */
		public function EventDelegator(fromDispatcher:IEventDispatcher, toDispatcher:IEventDispatcher)
		{
			from = fromDispatcher;
			to = toDispatcher;
		}
		
		/**
		 * イベントを追加。多重登録不可。
		 * @param type	イベントタイプ。
		 * 
		 */
		public function addEvent(type:String):void
		{
			if (getHandlder(type) != null) return;
			
			var handler:Function = function(e:Event):void
			{
				to.dispatchEvent(e);
			};
			registHandler(type, handler);
			from.addEventListener(type, handler);
		}
		
		/**
		 * イベントをまとめて追加。
		 * @param typeList
		 * 
		 */
//		public function addEvents(types:Array):void
		public function addEvents(...types:Array):void
		{
			var type:String;
			for (var i:int = 0; i < types.length; i++) 
			{
				type = types[i];
				addEvent(type);
			}
		}
		
		/**
		 * イベントを削除。
		 * @param type	イベントタイプ。
		 * 
		 */
		public function removeEvent(type:String):void
		{
			if (getHandlder(type) == null) return;
			
			var handler:Function = getHandlder(type);
			from.removeEventListener(type, handler);
			removeHandler(type);
		}
		
		/**
		 * イベントを全て削除。
		 * 
		 */
		public function removeEventAll():void
		{
			for (var p:String in _handlers)
			{
				removeEvent(p);
			}
		}
		
		
		protected function getHandlder(type:String):Function
		{
			return _handlers[type];
		}
		
		protected function registHandler(type:String, func:Function):void
		{
			_handlers[type] = func;
		}
		
		protected function removeHandler(type:String):void
		{
			delete _handlers[type];
		}
	}
}