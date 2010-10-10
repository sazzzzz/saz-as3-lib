package saz.media {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * 外部サウンドswfプロクシ.
	 * 外部swfをロードし、埋め込まれたSoundクラスを取り出し、Soundインスタンスを生成する.
	 * 外部swfには、サウンドファイルにリンケージ設定しておく.
	 * @author saz
	 */
	public class SoundSWFProxy extends EventDispatcher{
		
		// FIXME	メモリリークが起きる。タイミングによって（？）起きたり、起きなかったり。load()連打すると起き易いようだ。
		//			キャッシュが効いてるときに起きやすい？
		//			メモリ使用量はMAX:84MBぐらいで止まる。いちおうGCが効いている。
		
		/**
		 * Soundクラス名のリスト.
		 */
		public var soundClassNames:/*String*/Array;
		/**
		 * Soundクラスのリスト.
		 */
		public var soundClasses:/*Class*/Array;
		/**
		 * Soundインスタンスのリスト.
		 */
		public var sounds:/*Sound*/Array;
		
		/**
		 * Loaderインスタンス.
		 */
		public var loader:Loader;
		
		private var $isLoading:Boolean = false;
		
		
		/**
		 * SWFをロード完了し、初期化完了。
		 * 
		 * @eventType	flash.events.Event.INIT
		 */
		[Event(name = "init", type = "flash.events.Event")];
		
		
		/**
		 * コンストラクタ.
		 * @param	classNameList	Soundクラス名のリスト.
		 */
		public function SoundSWFProxy(classNameList:Array = null) {
			soundClassNames = (null != classNameList) ? classNameList : new Array();
			
			if (!soundClasses) soundClasses = new Array();
			if (!sounds) sounds = new Array();
			if (!loader) {
				loader = new Loader();
				//loader.contentLoaderInfo.addEventListener(Event.INIT, $loader_init);
			}
		}
		
		/**
		 * デストラクタ.
		 */
		public function destroy():void {
			$clearSounds();
			$clearSoundClasses();
		}
		
		/**
		 * swfファイルをロードする.
		 * @param	req
		 * @param	context
		 */
		public function load(req:URLRequest, context:LoaderContext = null):void {
			if ($isLoading) return;
			
			unload();
			destroy();
			
			$isLoading = true;
			loader.contentLoaderInfo.addEventListener(Event.INIT, $loader_init, false, 0, true);
			loader.load(req, context);
		}
		
		
		/**
		 * swfファイルをアンロードする.
		 */
		public function unload():void {
			loader.contentLoaderInfo.removeEventListener(Event.INIT, $loader_init);
			
			// Loader.close()の不具合について。
			// http://blog.img8.com/archives/2008/11/004211.html
			// http://blog.img8.com/archives/2008/11/004212.html
			// http://blog.img8.com/archives/2008/11/004213.html
			
			/*if ($isLoading && loader.contentLoaderInfo && loader.contentLoaderInfo.bytesLoaded < loader.contentLoaderInfo.bytesTotal) {
				loader.close();
			}*/
			try {
				loader.close();
			}catch (e:IOError) {
				trace("IOError",e);
			}catch (e:Error) {
				trace("Error",e);
			}
			
			$isLoading = false;
			loader.unload();
		}
		
		
		private function $loader_init(e:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.INIT, $loader_init);
			$isLoading = false;
			
			$updateSoundClasses();
			$updateSounds();
			
			dispatchEvent(new Event(Event.INIT));
		}
		
		
		
		private function $updateSoundClasses():void {
			soundClasses.length = 0;
			soundClassNames.forEach(function(item:String, index:int, arr:Array):void {
				soundClasses.push(loader.contentLoaderInfo.applicationDomain.getDefinition(item) as Class);
			});
		}
		
		private function $updateSounds():void {
			sounds.length = 0;
			soundClasses.forEach(function(item:Class, index:int, arr:Array):void {
				sounds.push(new item());
			});
		}
		
		
		private function $clearSoundClasses():void {
			/*soundClasses.forEach(function(item:Class, index:int, arr:Array):void {
				item = null;
			});*/
			for (var i:int = 0, len:int = soundClasses.length; i < len; i++) {
				soundClasses[i] = null;
			}
			soundClasses.length = 0;
		}
		
		private function $clearSounds():void {
			/*sounds.forEach(function(item:Sound, index:int, arr:Array):void {
				item = null;
			});*/
			for (var i:int = 0, len:int = sounds.length; i < len; i++) {
				sounds[i] = null;
			}
			sounds.length = 0;
		}
		
		/**
		 * ローディング中かどうか.
		 */
		public function get isLoading():Boolean { return $isLoading; }
		
	}

}