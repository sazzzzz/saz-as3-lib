package saz.display {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * プリローダ用ドキュメントクラス.
	 * @see	sample.display.MyPreloader
	 * @author saz
	 */
	public class Preloader extends Document{
		
		/**
		 * ロードするURL.
		 */
		public var contentUrl:String;
		
		/**
		 * 自動でロード開始するかどうか.
		 */
		public var autoLoad:Boolean = true;
		
		
		protected var $loader:Loader;
		protected var $isProgress:Boolean = false;
		
		protected var $background:Sprite;
		protected var $foreground:Sprite;
		
		
		//--------------------------------------
		// for override
		//--------------------------------------
		
		/*override protected function atReady():void {
		}*/
		
		/**
		 * Event.OPEN
		 */
		protected function atLoadOpen():void {}
		
		/**
		 * Event.COMPLETE
		 */
		protected function atLoadComplete():void {}
		
		/**
		 * ProgressEvent.PROGRESS
		 */
		protected function atLoadProgress():void {}
		
		
		
		//--------------------------------------
		// hook
		//--------------------------------------
		
		override protected function $constructorHook():void {
		}
		
		override protected function $readyHook():void {
			addChild(background);
			addChild(foreground);
			
			if (!$loader) $loader = new Loader();
			$attachEvents(contentLoaderInfo);
			
			if(autoLoad) $loader.load(new URLRequest(contentUrl));
		}
		
		protected function $completeHook():void {
			//addChild(content);
			addChildAt(content, getChildIndex($foreground));
			
			$detachEvents(contentLoaderInfo);
		}
		
		
		
		
		//--------------------------------------
		// main
		//--------------------------------------
		
		
		/**
		 * プロパティcontentUrlに指定されたURLを読み込む.
		 */
		public function loadContent():void {
			if (!$loader) $loader = new Loader();
			$attachEvents(contentLoaderInfo);
			
			$loader.load(new URLRequest(contentUrl));
		}
		
		
		
		
		
		private function $startProgress():void {
			addEventListener(Event.ENTER_FRAME, $progressLoop);
		}
		
		private function $stopProgress():void {
			removeEventListener(Event.ENTER_FRAME, $progressLoop);
		}
		
		// progressイベントは、1フレーム1回
		private function $progressLoop(e:Event):void {
			if (!$isProgress) return;
			$isProgress = false;
			$dispatchLoadProgress();
		}
		
		
		/* event 発行 */
		
		private function $dispatchLoadOpen():void {
			atLoadOpen();
		}
		
		private function $dispatchLoadComplete():void {
			atLoadComplete();
		}
		
		private function $dispatchLoadProgress():void {
			//atLoadProgress(LoaderInfo(e.target).bytesLoaded, LoaderInfo(e.target).bytesTotal);
			atLoadProgress();
		}
		
		private function $attachEvents(dispatcher:IEventDispatcher):void {
			$loader.contentLoaderInfo.addEventListener(Event.OPEN, $loader_open);
			//$loader.contentLoaderInfo.addEventListener(Event.INIT, $loader_init);
			$loader.contentLoaderInfo.addEventListener(Event.COMPLETE, $loader_complete);
			$loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, $loader_progress);
			//$loader.contentLoaderInfo.addEventListener(Event.UNLOAD, $loader_unload);
			
			//$loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, $loader_httpStatus);
			//$loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, $loader_ioError);
		}
		
		private function $detachEvents(dispatcher:IEventDispatcher):void {
			$loader.contentLoaderInfo.removeEventListener(Event.OPEN, $loader_open);
			//$loader.contentLoaderInfo.removeEventListener(Event.INIT, $loader_init);
			$loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, $loader_complete);
			$loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, $loader_progress);
			//$loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, $loader_unload);
			
			//$loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, $loader_httpStatus);
			//$loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, $loader_ioError);
		}
		
		
		
		//--------------------------------------
		// listener
		//--------------------------------------
		
		private function $loader_open(e:Event):void {
			$dispatchLoadOpen();
			$startProgress();
		}
		
		private function $loader_complete(e:Event):void {
			$stopProgress();
			$completeHook();
			$dispatchLoadComplete();
		}
		
		private function $loader_progress(e:ProgressEvent):void {
			$isProgress = true;
		}
		
		
		
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		public function get loader():Loader { return $loader; }
		public function get content():Sprite { return $loader ? Sprite($loader.content) : null; }
		public function get contentLoaderInfo():LoaderInfo { return $loader ? $loader.contentLoaderInfo : null; }
		public function get bytesLoaded():uint { return $loader ? $loader.contentLoaderInfo.bytesLoaded : null; }
		public function get bytesTotal():uint { return $loader ? $loader.contentLoaderInfo.bytesTotal : null; }
		
		
		public function get background():Sprite {
			if(!$background) $background = new Sprite();
			return $background;
		}
		
		public function get foreground():Sprite {
			if(!$foreground) $foreground = new Sprite();
			return $foreground;
		}
		
		
		
	}

}