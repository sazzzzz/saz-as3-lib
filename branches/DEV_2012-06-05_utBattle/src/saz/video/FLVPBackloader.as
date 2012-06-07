package saz.video
{
	import fl.video.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import saz.events.DynamicEvent;
	
	public class FLVPBackloader extends EventDispatcher
	{
		public static const EVENT_LOADED:String = "loaded";
		
		private var _flvp:FLVPlayback;
		public function get flvp():FLVPlayback
		{
			return _flvp;
		}
		public function set flvp(value:FLVPlayback):void
		{
			if(_flvp == value)return;
			_flvp = value;
			_init();
		}
		
		private var _urls:Array = [];
		private var _vpman:FLVPVideoPlayerManager;
		
		public function FLVPBackloader(flvPlayback:FLVPlayback = null)
		{
			super();
			
			if(flvPlayback) flvp = flvPlayback;
		}
		
		
		private function _init():void
		{
			_urls.length = 0;
			if(!_vpman) _vpman = new FLVPVideoPlayerManager();
			_vpman.flvp = _flvp;
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
		
		protected function _videoPlayer_progress(event:VideoProgressEvent):void
		{
			//trace("FLVPBackloader._videoPlayer_progress(event)");
			//trace(event);
			// VideoProgressEvent.vpはあてにならない。いつも0みたい。
			if(VideoPlayer(event.target).bytesLoaded == VideoPlayer(event.target).bytesTotal){
				// ロード完了
				dispatchEvent(new DynamicEvent(EVENT_LOADED, false, false, {vp: getIndex(VideoPlayer(event.target).source)}));
			}
		}
		
		
		public function start(url:String):int
		{
			trace("FLVPBackloader.start("+url);
			
			// すでにロード中なら、該当インデックスを返す
			//if(getIndex(url) > -1) return getIndex(url);
			
			// videoPlayerを確保
			var idx:int = _vpman.acquire();
			trace("使用VideoPlayer",idx);
			_setUrl(url, idx);
			_saveActiveIndex(idx, function():void{
				flvp.autoPlay = false;
				flvp.source = url;
			});
			flvp.getVideoPlayer(idx).addEventListener(VideoProgressEvent.PROGRESS, _videoPlayer_progress);
			return idx;
		}
		
		public function stopAt(index:int):Boolean
		{
			trace("FLVPBackloader.stopAt("+index);
			
			// videoPlayerを開放
			_vpman.release(index);
			
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
		
		public function stop(url:String):Boolean
		{
			return stopAt(getIndex(url));
		}
		
		public function stopOthersAt(index:int):void
		{
			for(var i:int = 0, n:int = _urls.length; i < n; i++)
			{
				if(i != index) stopAt(i);
			}
		}
		
		public function stopOthers(url:String):void
		{
			stopOthersAt(getIndex(url));
		}
		
		
		
		public function getIndex(url:String):int
		{
			return _urls.indexOf(url);
		}
		
		
		
		
		override public function toString():String
		{
			return _vpman.toString();
		}
		
	}
}