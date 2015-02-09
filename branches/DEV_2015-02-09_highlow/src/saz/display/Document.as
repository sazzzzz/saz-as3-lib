package saz.display {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	/**
	 * ドキュメントベースクラス.
	 * @author saz
	 */
	//public class Document extends Sprite{
	public class Document extends MovieClip{
		
		private var $isReady:Boolean = false;
		public function get isReady():Boolean { return $isReady; }
		
		private var $isAddedToStage:Boolean = false;
		private var $isInit:Boolean = false;
		private var $isComplete:Boolean = false;
		private var $isStage:Boolean = false;
		
		
		
		public function Document() {
			super();
			
			addEventListener(Event.ENTER_FRAME, $enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, $addedToStage);
			loaderInfo.addEventListener(Event.INIT, $loaderInfo_init);
			loaderInfo.addEventListener(Event.COMPLETE, $loaderInfo_complete);
			
			$constructorHook();
		}
		
		
		
		//--------------------------------------
		// for override
		//--------------------------------------
		
		/**
		 * コンストラクタ、addEventListenerの後に実行. 
		 */
		protected function $constructorHook():void {}
		
		/**
		 * atReady()の直後に実行. 
		 */
		protected function $readyHook():void {}
		
		/**
		 * SWF ファイルの読み込みが完了し、stage 及び loaderInfo にアクセス可能になった場合に送出されます。
		 * サブクラスでオーバーライドする用。
		 */
		protected function atReady():void {}
		
		
		
		//--------------------------------------
		// main
		//--------------------------------------
		
		private function $addedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, $addedToStage);
			$isAddedToStage = true;
			$checkReady();
		}
		
		private function $loaderInfo_init(e:Event):void {
			loaderInfo.removeEventListener(Event.INIT, $loaderInfo_init);
			$isInit = true;
			$checkReady();
		}
		
		private function $loaderInfo_complete(e:Event):void {
			loaderInfo.removeEventListener(Event.COMPLETE, $loaderInfo_complete);
			$isComplete = true;
			$checkReady();
		}
		
		private function $enterFrame(e:Event):void {
			if (!stage || !loaderInfo) return;
			
			removeEventListener(Event.ENTER_FRAME, $enterFrame);
			$isStage = true;
			$checkReady();
		}
		
		
		/**
		 * isReadyを更新し、準備ができてればatReady()をよびだす.
		 */
		private function $checkReady():void {
			if ($isReady || !$isAddedToStage || !$isInit || !$isComplete || !$isStage) return;
			
			$isReady = true;
			atReady();
			$readyHook();
		}
		
		
		
		
		
	}

}