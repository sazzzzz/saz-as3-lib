package saz.display {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	/**
	 * ドキュメントベースクラス.
	 * @author saz
	 */
	public class DocumentBase extends Sprite{
		
		private var $isReady:Boolean = false;
		public function get isReady():Boolean { return $isReady; }
		
		private var $isAddedToStage:Boolean = false;
		private var $isInit:Boolean = false;
		private var $isComplete:Boolean = false;
		private var $isStage:Boolean = false;
		
		
		
		public function DocumentBase() {
			super();
			
			addEventListener(Event.ENTER_FRAME, $enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, $addedToStage);
			loaderInfo.addEventListener(Event.INIT, $loaderInfo_init);
			loaderInfo.addEventListener(Event.COMPLETE, $loaderInfo_complete);
		}
		
		
		
		private function $addedToStage(e:Event):void {
			//trace("DocumentBase.$addedToStage(", arguments);
			removeEventListener(Event.ADDED_TO_STAGE, $addedToStage);
			$isAddedToStage = true;
			$checkReady();
		}
		
		private function $loaderInfo_init(e:Event):void {
			//trace("DocumentBase.$loaderInfo_init(", arguments);
			loaderInfo.removeEventListener(Event.INIT, $loaderInfo_init);
			$isInit = true;
			$checkReady();
		}
		
		private function $loaderInfo_complete(e:Event):void {
			//trace("DocumentBase.$loaderInfo_complete(", arguments);
			loaderInfo.removeEventListener(Event.COMPLETE, $loaderInfo_complete);
			$isComplete = true;
			$checkReady();
		}
		
		private function $enterFrame(e:Event):void {
			//trace("DocumentBase.$enterFrame(", arguments);
			//trace(stage, loaderInfo);
			if (!stage || !loaderInfo) return;
			
			removeEventListener(Event.ENTER_FRAME, $enterFrame);
			$isStage = true;
			$checkReady();
		}
		
		
		
		/**
		 * isReadyを更新し、準備ができてればatReady()をよびだす.
		 */
		private function $checkReady():void {
			//trace($isReady, $isAddedToStage, $isInit, $isComplete);
			if ($isReady || !$isAddedToStage || !$isInit || !$isComplete || !$isStage) return;
			
			$isReady = true;
			atReady();
		}
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 */
		protected function atReady():void {
			//trace("DocumentBase.atReady(", arguments);
			//trace(loaderInfo.bytesLoaded, loaderInfo.bytesTotal);
		}
		
		
	}

}