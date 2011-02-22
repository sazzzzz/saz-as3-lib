package saz.display.loading {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * プリローダーアニメーション描画用ベースクラス.
	 * @author saz
	 */
	public class LoadingDrawerBase {
		
		/**
		 * 描画対象とするDisplayObjectContainer. 
		 */
		public var container:DisplayObjectContainer;
		
		/**
		 * 生成する子インスタンスの数. start()後に変更しても反映されない. 
		 */
		public var num:int = 12;
		
		
		protected var $dispatcher:IEventDispatcher;
		protected var $eventType:String;
		
		protected var $isReady:Boolean = false;
		protected var $isRunning:Boolean = false;
		protected var $items:Array;
		
		private var $extraObj:Object;
		
		public function LoadingDrawerBase(displayContainer:DisplayObjectContainer) {
			super();
			
			$init(displayContainer);
		}
		
		
		
		//--------------------------------------
		// オーバーライド用
		//--------------------------------------
		
		
		/**
		 * start()直後に一度だけ呼ばれる. 主にインスタンス生成を行う. 
		 * @param	extra	各atCreateItemに渡されるリレーオブジェクト. プロパティを追加して各atCreateItem内で使用する. 
		 */
		protected function atReady(extra:Object):void { }
		
		/**
		 * 表示するDisplayObjectの生成メソッドを定義する. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atCreateItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		protected function atCreateItem(index:int, num:int, extra:Object):DisplayObject { return null; }
		
		
		/**
		 * 表示更新時に呼ばれる. この直後にatDrawItemが実行される. 
		 * @param	extra	各atDrawItemに渡されるリレーオブジェクト. プロパティを追加して各atDrawItem内で使用する. 
		 */
		protected function atDraw(extra:Object):void { }
		
		/**
		 * 各アイテムの描画更新メソッド. atDraw直後に呼ばれる. 
		 * @param	item	表示アイテム. 
		 * @param	index	表示アイテムインデックス. 
		 * @param	num		表示アイテムの総数. 
		 * @param	extra	リレーオブジェクト. 各atDrawItem間で共有されるので、値を変更すると次のアイテムに渡される. 
		 */
		protected function atDrawItem(item:DisplayObject, index:int, num:int, extra:Object):void { }
		
		
		
		/**
		 * start()直後に呼ばれる. 主に表示アニメーションを行う. 
		 */
		//protected function atStart():void { }
		
		
		/**
		 * stop()後に呼ばれる. 主に消えるアニメーションを行う. 
		 */
		//protected function atStop():void { }
		
		
		
		/**
		 * コンストラクタから呼ばれる.
		 */
		//protected function atInit():void { }
		
		/**
		 * デストラクト時に呼ばれる. 
		 */
		protected function atDestroy():void { }
		
		
		
		
		//--------------------------------------
		// internal
		//--------------------------------------
		
		/**
		 * 描画開始
		 */
		public function start():void {
			if ($isRunning) return;
			$isRunning = true;
			
			if (!$isReady) $ready();
			//atStart();
			
			if (!$dispatcher && !$eventType) {
				$dispatcher = container;
				$eventType = Event.ENTER_FRAME;
			}
			$dispatcher.addEventListener($eventType, $loop);
		}
		
		/**
		 * 描画停止
		 */
		public function stop():void {
			if (!$isRunning) return;
			$isRunning = false;
			
			$dispatcher.removeEventListener($eventType, $loop);
			//atStop();
		}
		
		
		/**
		 * 描画更新するきっかけとなるイベントを変更する. 
		 * @param	dispatcher	デフォルトはstage. 
		 * @param	eventType	デフォルトはEvent.ENTER_FRAME. 
		 */
		public function setListen(dispatcher:IEventDispatcher, eventType:String):void {
			// 実行中ならイベント登録しなおす
			if ($isRunning) {
				$dispatcher.removeEventListener($eventType, $loop);
				dispatcher.addEventListener(eventType, $loop);
			}
			$dispatcher = dispatcher;
			$eventType = eventType;
		}
		
		/**
		 * デストラクタ. 
		 */
		public function destroy():void {
			$dispatcher.removeEventListener($eventType, $loop);
			removeChildren();
			$items.forEach(function(item:DisplayObject, index:int, arr:Array):void {
				item=null;
			});
			$items.length = 0;
			atDestroy();
		}
		
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------
		
		//イラネ
		protected function addChildren():void {
			$items.forEach(function(item:DisplayObject, index:int, arr:Array):void {
				container.addChild(item);
			});
		}
		
		protected function removeChildren():void {
			$items.forEach(function(item:DisplayObject, index:int, arr:Array):void {
				container.removeChild(item);
			});
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * コンストラクタから呼ばれる.
		 */
		private function $init(displayContainer:DisplayObjectContainer):void {
			container = displayContainer;
			//atInit();
		}
		
		/**
		 * start前の準備. DisplayObjectインスタンス生成. 
		 */
		private function $ready():void {
			if ($isReady) return;
			$isReady = true;
			if(!$items) $items = new Array(num);
			
			var extraObj:Object = { };
			atReady(extraObj);
			for (var i:int = 0, n:int = num, item:DisplayObject; i < n; i++) {
				item = atCreateItem(i, n, extraObj);
				container.addChild(item);
				$items[i] = item;
			}
		}
		
		
		private function $draw():void {
			if (!$extraObj) {
				$extraObj = { };
			}else {
				// 値クリア
				for (var name:String in $extraObj) {
					delete $extraObj[name];		// for..in で、 delete じゃないとダメみたい。
				}
			}
			
			atDraw($extraObj);
			for (var i:int = 0, n:int = num, item:DisplayObject; i < n; i++) {
				atDrawItem($items[i], i, n, $extraObj);
			}
		}
		
		//--------------------------------------
		// event handler
		//--------------------------------------
		
		private function $loop(e:Event):void {
			$draw();
		}
		
		//--------------------------------------
		// getter / setter
		//--------------------------------------
		
		/**
		 * 表示中かどうか
		 */
		public function get isShown():Boolean {
			return $isRunning;
		}
		
		
	}

}