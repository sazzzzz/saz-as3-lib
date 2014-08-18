package saz.display.preloader
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class PreloaderController
	{
		public var document:IPreloadable;
		public var contentUrl:String;

		private var _loader:Loader;
		public function get loader():Loader
		{
			return _loader;
		}
		
		private var _loaded:Boolean = false;
		public function get loaded():Boolean
		{
			return _loaded;
		}

		
		public function PreloaderController(target:IPreloadable, url:String, autoStart:Boolean=true)
		{
			document = target;
			contentUrl = url;
			
			if (autoStart) start();
		}
		
		public function start():void
		{
			_startLoad();
		}
		
		
		private function _initLoader():void
		{
			if (_loader != null) return;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, _loader_open);
			//_loader.contentLoaderInfo.addEventListener(Event.INIT, _loader_init);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _loader_complete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _loader_progress);
			//_loader.contentLoaderInfo.addEventListener(Event.UNLOAD, _loader_unload);
			
			//_loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, _loader_httpStatus);
			//_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _loader_ioError);
		}
		
		private function _startLoad():void
		{
			_initLoader();
			_loader.load(new URLRequest(contentUrl));
		}
		
		
		protected function _loader_open(event:Event):void
		{
			_loaded = false;
			document.atLoadOpen(_loader);
		}
		
		protected function _loader_complete(event:Event):void
		{
			_loaded = true;
			document.atLoadComplete(_loader);
		}
		
		protected function _loader_progress(event:ProgressEvent):void
		{
			document.atLoadProgress(_loader, _loader.contentLoaderInfo.bytesLoaded, _loader.contentLoaderInfo.bytesTotal);
		}
		
	}
}