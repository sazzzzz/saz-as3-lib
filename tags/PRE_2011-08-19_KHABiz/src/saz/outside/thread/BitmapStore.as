package saz.outside.thread {
	import flash.display.*;
	import flash.errors.IOError;
	import flash.events.*;
	import flash.net.URLRequest;
	import saz.collections.Map;
	import org.libspark.thread.Thread;
	import org.libspark.thread.threads.net.URLLoaderThread;
	import org.libspark.thread.threads.display.LoaderThread;
	import org.libspark.thread.utils.SerialExecutor;	
	/**
	 * 画像をロードして貯める。BitmapDataとして取り出せる。
	 * @author saz
	 */
	//public class BitmapStore extends EventDispatcher {
	public class BitmapStore extends Thread implements IEventDispatcher {
		
		private var $ed:EventDispatcher;
		
		private var $entries:/*Object*/Array;
		private var $indexes:Map;
		private var $bmps:Map;
		private var $loaders:SerialExecutor;
		
		/**
		 * TODO	Threadの使い方が間違ってる気が。
		 */
		function BitmapStore() {
			super();
			$initEventDispatcher();
		}
		
		override protected function run():void {
			if (null == $bmps) {
				$bmps = new Map();
			}
			$loaders = new SerialExecutor();
			$entries.forEach(function(item:*, index:int, arr:Array):void {
				$loaders.addThread(new LoaderThread(new URLRequest(item.url)));
			});
			$loaders.start();
			$loaders.join();
			next($loadComplete);
			error(IOError, $loadError);
		}
		
		override protected function finalize():void {
			/*$bmps.each(function(key:String, value:*, index:int):void {
				value.dispose();
			});*/
		}
		
		public function addItem(url:String, id:String):void {
			if (null == $entries) {
				$entries = new Array();
			}
			if (null == $indexes) {
				$indexes = new Map();
			}
			var entry:Object = { id:id, url:url };
			$entries.push(entry);
			$indexes.put(id, $entries.length - 1 );
		}
		
		public function getBmp(key:String):BitmapData {
			return BitmapData($bmps.gets(key));
		}
		
		
		private function $loadComplete():void{
			for (var i:int = 0,len:int=$loaders.numThreads; i < len; i++) {
				var loader:LoaderThread = LoaderThread($loaders.getThreadAt(i));
				var dsp:Bitmap = Bitmap(loader.loader.content);
				var bmp:BitmapData = dsp.bitmapData;
				$bmps.put($entries[i].id, bmp);
				
				//StageReference.stage.addChild(loader.loader.content);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function $loadError(e:Error, t:Thread):void {
			trace("読み込みエラー");
			next(null);
		}
		
		
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			$ed.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function dispatchEvent(event:Event):Boolean {
			return $ed.dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean {
			return $ed.hasEventListener(type);
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			$ed.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean {
			return $ed.willTrigger(type);
		}
		
		private function $initEventDispatcher():void {
			$ed = new EventDispatcher();
		}
		
	}
	
}