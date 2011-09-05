package sample.display {
	import saz.display.Preloader;
	
	/**
	 * ...
	 * @author saz
	 */
	public class MyPreloader extends Preloader {
		
		
		public function MyPreloader() {
			super();
			
			// ロードするURL
			contentUrl = "_display_Document.swf";
			// 自動ロードしないよう設定
			//autoLoad = false;
		}
		
		
		override protected function atReady():void {
			trace("MyPreloader.atReady(", arguments);
			var br:Rect = new Rect();
			br.y = -50;
			var fr:Rect = new Rect();
			fr.x = 200;
			fr.y = -50;
			background.addChild(br);
			foreground.addChild(fr);
			
			// ロード開始
			//loadContent();
		}
		
		/**
		 * Event.OPEN
		 */
		override protected function atLoadOpen():void {
			trace("MyPreloader.atLoadOpen(", arguments);
		}
		
		/**
		 * Event.COMPLETE
		 */
		override protected function atLoadComplete():void {
			trace("MyPreloader.atLoadComplete(", arguments);
		}
		
		/**
		 * ProgressEvent.PROGRESS
		 */
		override protected function atLoadProgress():void {
			//trace("MyPreloader.atLoadProgress(", arguments);
			trace(bytesLoaded, bytesTotal);
		}
		
	}

}