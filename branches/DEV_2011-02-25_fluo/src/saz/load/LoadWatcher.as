package saz.load {
	import flash.display.*;
	import flash.events.*;
	import saz.StageReference;
	
	// FIXME	イベント仕様とか間違ってる。flash.events.Eventを使用すべきだ。
	/**
	 * DisplayObject.loaderInfoを監視してイベント発行
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * // LoadWatcher インスタンスを生成。自分自身のロードを監視。
	 * var watch:LoadWatcher = new LoadWatcher(this);
	 * watch.addEventListener(LoadWatcher.EVENT_COMPLETE, $onLoadComplete);
	 * watch.start();
	 * </listing>
	 */
	public class LoadWatcher extends EventDispatcher {
		
		public static var EVENT_PROGRESS:String = "onProgress";
		public static var EVENT_COMPLETE:String = "onComplete";
		
		
		private var $target:Sprite;
		
		/**
		 * コンストラクタ。
		 * @param	target	監視対象となるDisplayObject。
		 */
		function LoadWatcher(target:DisplayObject) {
			super();
			
			this.$target = target;
		}
		
		/**
		 * 開始。
		 */
		public function start():void {
			//sta.addEventListener(
			var st:Stage = StageReference.stage;
			st.addEventListener(Event.ENTER_FRAME, this.$onLoadLoop);
		}
		
		/**
		 * 終了。
		 */
		public function stop():void {
			var st:Stage = StageReference.stage;
			st.removeEventListener(Event.ENTER_FRAME, this.$onLoadLoop);
		}
		
		
		private function $onLoadLoop(e:Event):void {
			//trace("LoadWatcher.$onLoadLoop(" + arguments);
			var ratio:Number = this.$target.loaderInfo.bytesLoaded / this.$target.loaderInfo.bytesTotal;
			if (ratio >= 1) {
				//comp
				this.stop();
				this.dispatchEvent(new Event(EVENT_COMPLETE));
			}else {
				//cont
				this.dispatchEvent(new Event(EVENT_PROGRESS));
			}
		}
		
	}
	
}