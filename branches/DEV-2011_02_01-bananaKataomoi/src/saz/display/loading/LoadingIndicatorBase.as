package saz.display.loading {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * プリローダーアニメーション用ベースクラス.
	 * ADDED_TO_STAGEで描画開始. REMOVED_FROM_STAGEで停止. 
	 * @author saz
	 */
	public class LoadingIndicatorBase extends Sprite {
		
		
		/**
		 * 生成する子インスタンスの数. ADDED_TO_STAGE後に変更しても反映されない. 
		 */
		public var num:int = 12;
		
		
		protected var $dispatcher:IEventDispatcher;
		protected var $eventType:String;
		
		protected var $isReady:Boolean = false;
		protected var $isShown:Boolean = false;
		protected var $items:Array;
		
		private var $extraObj:Object;
		
		public function LoadingIndicatorBase() {
			super();
			
			$init();
		}
		
		
		
		//--------------------------------------
		// オーバーライド用
		//--------------------------------------
		
		
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
		 * ADDED_TO_STAGE直後に一度だけ呼ばれる. 主にインスタンス生成を行う. 
		 * @param	extra	各atCreateItemに渡されるリレーオブジェクト. プロパティを追加して各atCreateItem内で使用する. 
		 */
		protected function atReady(extra:Object):void {
			visible = false;
		}
		
		/**
		 * ADDED_TO_STAGE直後に呼ばれる. 主に表示アニメーションを行う. showComplete()を実行すること！
		 */
		protected function atShow():void {
			// your code
			visible = true;
			
			// 必須
			showComplete();
		}
		
		/**
		 * showComplete()から呼ばれる. 主に表示アニメーション完了処理を行う. 
		 */
		protected function atShowComplete():void { }
		
		/**
		 * REMOVED_FROM_STAGE後に呼ばれる. 主に消えるアニメーションを行う. hideComplete()を実行すること！
		 */
		protected function atHide():void {
			// your code
			visible = false;
			
			// 必須
			hideComplete();
		}
		
		/**
		 * hideComplete()から呼ばれる. 主に消えるアニメーション完了処理を行う. 
		 */
		protected function atHideComplete():void { }
		
		
		/**
		 * コンストラクタから呼ばれる.
		 */
		protected function atInit():void { }
		
		/**
		 * デストラクト時に呼ばれる. 
		 */
		protected function atDestroy():void { }
		
		
		
		
		//--------------------------------------
		// internal
		//--------------------------------------
		
		public function show():void {
			if ($isShown) return;
			$isShown = true;
			
			if (!$isReady) $ready();
			atShow();
			
			if (!$dispatcher && !$eventType) {
				$dispatcher = stage;
				$eventType = Event.ENTER_FRAME;
			}
			$dispatcher.addEventListener($eventType, $loop);
		}
		
		public function showComplete():void {
			atShowComplete();
		}
		
		public function hide():void {
			if (!$isShown) return;
			$isShown = false;
			
			atHide();
		}
		
		public function hideComplete():void {
			atHideComplete();
			$dispatcher.removeEventListener($eventType, $loop);
		}
		
		
		/**
		 * 描画更新するきっかけとなるイベントを変更する. 
		 * @param	dispatcher	デフォルトはstage. 
		 * @param	eventType	デフォルトはEvent.ENTER_FRAME. 
		 */
		public function setListen(dispatcher:IEventDispatcher, eventType:String):void {
			// 実行中ならイベント登録しなおす
			if ($isShown) {
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
			//removeEventListener(Event.ADDED_TO_STAGE, $this_addedStage);
			//removeEventListener(Event.REMOVED_FROM_STAGE, $this_removedStage);
			$dispatcher.removeEventListener($eventType, $loop);
			removeChildren();
			atDestroy();
		}
		
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------
		
		//イラネ
		protected function addChildren():void {
			$items.forEach(function(item:DisplayObject, index:int, arr:Array):void {
				addChild(item);
			});
		}
		
		protected function removeChildren():void {
			$items.forEach(function(item:DisplayObject, index:int, arr:Array):void {
				removeChild(item);
			});
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * コンストラクタから呼ばれる.
		 */
		private function $init():void {
			//addEventListener(Event.ADDED_TO_STAGE, $this_addedStage);
			//addEventListener(Event.REMOVED_FROM_STAGE, $this_removedStage);
			atInit();
		}
		
		/**
		 * start前の準備. DisplayObjectインスタンス生成. 
		 */
		private function $ready():void {
			if ($isReady) return;
			$isReady = true;
			$items = new Array(num);
			
			var extraObj:Object = { };
			atReady(extraObj);
			for (var i:int = 0, n:int = num, item:DisplayObject; i < n; i++) {
				item = atCreateItem(i, n, extraObj);
				addChild(item);
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
		
		/*private function $this_addedStage(e:Event):void {
			show();
		}
		
		private function $this_removedStage(e:Event):void {
			hide();
		}*/
		
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
			return $isShown;
		}
		
		
	}

}