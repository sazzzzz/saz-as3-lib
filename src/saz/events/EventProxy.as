package saz.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import saz.collections.enumerator.Enumerable;
	import saz.util.ArrayUtil;
	
	/**
	 * 指定EventDisplatcherのイベントを、代理して発行する。
	 * 対象オブジェクトが存在前にEventProxyインスタンスを生成しておいて、addEventListenerを受け付ける。対象オブジェクトを後から指定すると、イベントを中継してくれる。
	 * @author saz
	 * 
	 */
	public class EventProxy extends EventDispatcher
	{
		


		/**
		 * オリジナルのイベント発行元。
		 * @return 
		 * 
		 */
		public function get target():IEventDispatcher
		{
			return _target;
		}
		public function set target(value:IEventDispatcher):void
		{
			trace("♪", name, "EventProxy.target(", value);
			
			if (_target == value) return;
			
			// 旧ターゲットのリスナを削除
			if (_target != null) removeAllEventListeners(_target);
			// リスナ登録
			if (value != null) addAllEventListeners(value);
			
			
			_target = value;
		}
		private var _target:IEventDispatcher;
		
		

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


		public var name:String = "";
		
		
		private function get enum():Enumerable
		{
			if (_enum == null) _enum = new Enumerable(entries);
			return _enum;
		}
		private var _enum:Enumerable;


		private var entries:Array = [];
		
		
		// FIXME:	デバッグ用
		public function dump():void
		{
			var types:Array = [];
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				types.push(item.eventType);
			});
			trace(types);
		}
		
		
		/**
		 * コンストラクタ。
		 * 
		 * @example The following code shows this function usage:
		 * <listing version="3.0">
		 * 
		 * var bcp:BrightcovePlayer = new BrightcovePlayer();
		 * var player:BrightcovePlayerWrapper = new BrightcovePlayerWrapper(bcp);
		 * 
		 * var content:ContentModule;
		 * var experience:ExperienceModule;
		 * 
		 * player.addEventListener(ExperienceEvent.TEMPLATE_LOADED, function(event)
		 * {
		 * 	content = player.getModule(APIModules.CONTENT) as ContentModule;
		 * 	experience = player.getModule(APIModules.EXPERIENCE) as ExperienceModule;
		 * 	
		 * 	// オリジナルのイベント発行元を後から指定できる。
		 * 	expEventProxy.target = experience;
		 * 	cntEventProxy.target = content;
		 * });
		 * 
		 * 
		 * var expEventProxy:EventProxy = new EventProxy();
		 * expEventProxy.listen(ExperienceEvent.TEMPLATE_READY);
		 * // 先にイベントリスナを受ける
		 * expEventProxy.addEventListener(ExperienceEvent.TEMPLATE_READY, function(event)
		 * {
		 * 	// メディアDTOの取得。
		 * 	content.getMediaAsynch(563297626002);
		 * });
		 * 
		 * 
		 * 	var cntEventProxy:EventProxy = new EventProxy();
		 * cntEventProxy.listen(ContentEvent.MEDIA_LOAD);
		 * cntEventProxy.addEventListener(ContentEvent.MEDIA_LOAD, function(event)
		 * {
		 *  // ビデオロード。
		 * 	video.loadVideo(563297626002);
		 * });
		 * 
		 * </listing>
		 */
		public function EventProxy()
		{
			super();
		}
		
		
		
		
		
		
		/**
		 * 指定したイベントタイプが登録済みかどうか。
		 * @param eventType
		 * @return 
		 * 
		 */
		public function contains(eventType:String):Boolean
		{
			return getEntryByType(eventType) != null;
		}
		
		/**
		 * イベントタイプを登録。
		 * @param eventType
		 * 
		 */
		public function listen(eventType:String):void
		{
			addEntry(eventType);
			
			if (target != null) target.addEventListener(eventType, target_handler, false, 0, false);
		}
		
		/**
		 * イベントタイプをまとめて登録。
		 * @param eventTypes
		 * 
		 */
		public function listenEvents(eventTypes:Array):void
		{
			trace("♪", name, "EventProxy.listenEvents(", eventTypes);
			
			eventTypes.forEach(function(item:String, index:int, arr:Array):void
			{
				listen(item);
			});
		}
		
		
		/**
		 * イベントタイプを解放。
		 * @param eventType
		 * 
		 */
		public function unlisten(eventType:String):void
		{
			trace("♪", name, "EventProxy.unlisten(", eventType);
			
			if (target != null) target.removeEventListener(eventType, target_handler);
			
			removeEntry(eventType);
		}
		
		/**
		 * イベントタイプをまとめて解放。
		 * @param eventTypes
		 * 
		 */
		public function unlistenEvents(eventTypes:Array):void
		{
			trace("♪", name, "EventProxy.unlistenEvents(", eventTypes);
			
			eventTypes.forEach(function(item:String, index:int, arr:Array):void
			{
				unlisten(item);
			});
		}
		
		/**
		 * すべてのイベントタイプを解放。
		 * 
		 */
		public function unlistenAll():void
		{
			trace("♪", name, "EventProxy.unlistenAll(");
			
			removeAllEventListeners(target);
			removeAllEntries();
		}
		
		
		//--------------------------------------
		// private 
		//--------------------------------------
		
		
		
		private function addAllEventListeners(dispatcher:IEventDispatcher):void
		{
			trace("♪", name, "EventProxy.addAllEventListeners(", dispatcher);
			
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				dispatcher.addEventListener(item.eventType, target_handler, false, 0, false);
			});
		}
		
		private function removeAllEventListeners(dispatcher:IEventDispatcher):void
		{
			trace("♪", name, "EventProxy.removeAllEventListeners(", dispatcher);
			
			entries.forEach(function(item:Object, index:int, arr:Array):void
			{
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
			// やっぱりevent.targetとevent.currentTargetは、このインスタンスになるんで、保存しておく。
			
			_eventTarget = event.target;
			_eventCurrentTarget = event.currentTarget;
			
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