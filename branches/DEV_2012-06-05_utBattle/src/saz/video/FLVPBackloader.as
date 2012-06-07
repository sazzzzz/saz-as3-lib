package saz.video
{
	import fl.video.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import saz.events.DynamicEvent;
	
	/**
	 * 
	 * @author saz
	 */
	public class FLVPBackloader extends EventDispatcher
	{
		/**
		 * 
		 * @default 
		 */
		public static const EVENT_LOADED:String = "loaded";
		
		private var _flvp:FLVPlayback;
		/**
		 * 
		 * @return 
		 */
		public function get flvp():FLVPlayback
		{
			return _flvp;
		}
		/**
		 * 
		 * @param value
		 */
		public function set flvp(value:FLVPlayback):void
		{
			if(_flvp == value)return;
			_flvp = value;
			_init();
		}
		
		private var _vpman:FLVPVideoPlayerManager;
		public function get videoPlayerManager():FLVPVideoPlayerManager
		{
			if(!_vpman) _vpman = new FLVPVideoPlayerManager(_flvp);
			return _vpman;
		}

		
//		private var _helper:VideoPlayerHelper;
//
//		public function get helper():VideoPlayerHelper
//		{
//			if(!_helper)_helper = new VideoPlayerHelper();
//			return _helper;
//		}
		
		
		private var _urls:Array = [];
		private var _helpers:Array = [];
		
		/**
		 * 
		 * @param flvPlayback
		 */
		public function FLVPBackloader(flvPlayback:FLVPlayback = null)
		{
			super();
			
			if(flvPlayback) flvp = flvPlayback;
		}
		
		
		private function _init():void
		{
			_urls.length = 0;
			videoPlayerManager.flvp = _flvp;
		}
		
		
		private function _saveActiveIndex(index:int, func:Function):void
		{
			var cur:int = flvp.activeVideoPlayerIndex;
			flvp.activeVideoPlayerIndex = index;
			func();
			flvp.activeVideoPlayerIndex = cur;
		}
		
		private function _setUrl(url:String, index:int):void
		{
			_urls[index] = url;
		}
		
		private function _getHepler(index:int):VideoPlayerHelper
		{
			if(!_helpers[index]){
				_saveActiveIndex(index, function():void{
					var vph:VideoPlayerHelper = new VideoPlayerHelper(flvp.getVideoPlayer(index));
					vph.addEventListener(VideoPlayerHelper.EVENT_LOADED, _videoPlayer_loaded);
					_helpers[index] = vph;
				});
			}
			return _helpers[index]
		}
		
		protected function _videoPlayer_loaded(event:Event):void
		{
			dispatchEvent(
				new DynamicEvent(
					EVENT_LOADED, false, false, {vp: getIndex(VideoPlayerHelper(event.target).videoPlayer.source)}
				)
			);
		}
		
		/**
		 * 
		 * @param event
		 */
		/*protected function _videoPlayer_progress(event:VideoProgressEvent):void
		{
			// VideoProgressEvent.vpはあてにならない。いつも0みたい。
			if(VideoPlayer(event.target).bytesLoaded == VideoPlayer(event.target).bytesTotal){
				// ロード完了
				dispatchEvent(new DynamicEvent(EVENT_LOADED, false, false, {vp: getIndex(VideoPlayer(event.target).source)}));
			}
		}*/
		
		
		/**
		 * ロード開始。
		 * @param url
		 * @return 
		 */
		public function start(url:String):int
		{
			trace("FLVPBackloader.start("+url);
			
			// すでにロード中なら、該当インデックスを返す
			//if(getIndex(url) > -1) return getIndex(url);
			
			// videoPlayerを確保
			var idx:int = videoPlayerManager.acquire();
			trace("使用VideoPlayer",idx);
			_setUrl(url, idx);
			_saveActiveIndex(idx, function():void{
				flvp.autoPlay = false;
				flvp.source = url;
			});
			//flvp.getVideoPlayer(idx).addEventListener(VideoProgressEvent.PROGRESS, _videoPlayer_progress);
			_getHepler(idx);
			return idx;
		}
		
		/**
		 * ロード停止。
		 * @param index
		 * @return 
		 */
		public function stopAt(index:int):Boolean
		{
			trace("FLVPBackloader.stopAt("+index);
			
			// videoPlayerを開放
			videoPlayerManager.release(index);
			
			var res:Boolean;
			_saveActiveIndex(index, function():void{
				if(flvp.source == "" || flvp.source == null){
					res = false;
				}else{
					res = true;
					try{
						// 初期値は""
						flvp.source = " ";
					}catch(e:VideoError){
						// なにもしない
					}catch(e:Error){
						// なにもしない
					}finally{
						// なにもしない
					}
				}
			});
			return res;
		}
		
		/**
		 * ロード停止。
		 * @param url
		 * @return 
		 */
		public function stop(url:String):Boolean
		{
			return stopAt(getIndex(url));
		}
		
		
		
		/**
		 * 他のをロード停止。
		 * @param index
		 */
		public function stopOthersAt(index:int):void
		{
			for(var i:int = 0, n:int = _urls.length; i < n; i++)
			{
				if(i != index) stopAt(i);
			}
		}
		
		/**
		 * 他のをロード停止。
		 * @param url
		 */
		public function stopOthers(url:String):void
		{
			stopOthersAt(getIndex(url));
		}
		
		
		
		/**
		 * URLからインデックスを返す。見つからない場合は-1を返す。
		 * @param url
		 * @return 
		 */
		public function getIndex(url:String):int
		{
			return _urls.indexOf(url);
		}
		
		
		
		
		override public function toString():String
		{
			return videoPlayerManager.toString();
		}
		
	}
}