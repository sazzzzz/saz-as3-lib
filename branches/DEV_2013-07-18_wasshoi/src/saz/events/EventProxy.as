package saz.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import saz.collections.enumerator.Enumerable;
	import saz.util.ArrayUtil;
	
	/**
	 * イベントの発行を代理する。
	 * 対象オブジェクトが存在前にEventProxyインスタンスを生成しておいて、addEventListenerを受け付ける。対象オブジェクトを後から指定すると、イベントを中継してくれる。
	 * @author saz
	 * 
	 */
	public class EventProxy extends EventDispatcher
	{
		


		public function get target():EventDispatcher
		{
			return _target;
		}
		public function set target(value:EventDispatcher):void
		{
			if (_target == value) return;
			
			// 旧ターゲットのリスナを削除
			if (_target != null) removeAllEventListeners(_target);
			// リスナ登録
			if (value != null) addAllEventListeners(value);
			
			
			_target = value;
		}
		private var _target:EventDispatcher;
		
		

		/**
		 * event.target保存用。
		 * @return 
		 * 
		 */
		public function get eventTarget():Object
		{
			return _eventTarget;
		}
		private var _eventTarget:Object;

		/**
		 * event.currentTarget保存用。
		 * @return 
		 * 
		 */
		public function get eventCurrentTarget():Object
		{
			return _eventCurrentTarget;
		}
		private var _eventCurrentTarget:Object;


		
		
		
		private function get enum():Enumerable
		{
			if (_enum == null) _enum = new Enumerable(entries);
			return _enum;
		}
		private var _enum:Enumerable;


		private var entries:Array = [];
		
		
		
		
		public function EventProxy(dispatcher:EventDispatcher=null)
		{
			super();
			
			if (dispatcher) target = dispatcher;
		}
		
		
		
		
		
		
		public function contains(eventType:String):Boolean
		{
			return getEntryByType(eventType) != null;
		}
		
		public function listen(eventType:String):void
		{
			addEntry(eventType);
			
			if (target != null) target.addEventListener(eventType, target_handler);
		}
		
		public function listenEvents(eventTypes:Array):void
		{
			eventTypes.forEach(function(item:String, index:int, arr:Array):void
			{
				listen(item);
			});
		}
		
		
		public function unlisten(eventType:String):void
		{
			if (target != null) target.removeEventListener(eventType, target_handler);
			
			removeEntry(eventType);
		}
		
		public function unlistenEvents(eventTypes:Array):void
		{
			eventTypes.forEach(function(item:String, index:int, arr:Array):void
			{
				unlisten(item);
			});
		}
		
		public function unlistenAll():void
		{
			removeAllEventListeners(target);
			removeAllEntries();
		}
		
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		
		
		private function addAllEventListeners(dispatcher:EventDispatcher):void
		{
			trace("EventProxy.addAllEventListeners(", dispatcher);
			
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				trace(item.eventType);
				dispatcher.addEventListener(item.eventType, target_handler);
			});
		}
		
		private function removeAllEventListeners(dispatcher:EventDispatcher):void
		{
			trace("EventProxy.removeAllEventListeners(", dispatcher);
			
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				trace(item.eventType);
				dispatcher.removeEventListener(item.eventType, target_handler);
			});
		}
		
		
		private function addEntry(eventType:String):void
		{
			entries.push(createEntry(eventType));
		}
		
		private function removeEntry(eventType:String):void
		{
			var idx:int;
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				if (item.eventType == eventType) idx = index;
			});
			ArrayUtil.remove(entries, idx);
		}
		
		private function removeAllEntries():void
		{
			entries.length = 0;
		}
		
		
		private function getEntryByType(eventType:String):Object
		{
			return enum.detect(function(item:Object, index:int):Boolean
			{
				return item.eventType == eventType;
			});
		}
		
		
		
		private function createEntry(eventType:String):Object
		{
			return {
				eventType:eventType
			};
		}
		
		
		
		
		private function dispatch(event:Event):void
		{
			_eventTarget = event.target;
			_eventCurrentTarget = event.currentTarget;
			
			// やっぱりevent.targetとevent.currentTargetは、このインスタンスになる。
			dispatchEvent(event);
		}
		
		
		
		//--------------------------------------
		// listeners
		//--------------------------------------
		
		
		protected function target_handler(event:Event):void
		{
			dispatch(event);
		}
		
		
	}
}