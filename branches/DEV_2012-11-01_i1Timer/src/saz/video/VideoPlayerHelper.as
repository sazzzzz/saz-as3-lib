package saz.video
{
	import fl.video.*;
	
	import flash.events.*;
	
	import saz.events.DynamicEvent;
	
	public class VideoPlayerHelper extends EventDispatcher
	{
		// ロード完了イベント
		public static const EVENT_LOADED:String = "loaded";
		
		
		
		
		private var _videoPlayer:VideoPlayer;
		public function get videoPlayer():VideoPlayer
		{
			return _videoPlayer;
		}
		public function set videoPlayer(value:VideoPlayer):void
		{
			if(_videoPlayer) _finVP(_videoPlayer);
			_initVP(value);
			_videoPlayer = value;
		}
		
		
		
		/**
		 * VideoPlayer用ヘルパ。（今のところ）ロード完了イベントを発行するだけ。
		 * @param vdoPlayer
		 */
		public function VideoPlayerHelper(vdoPlayer:VideoPlayer = null)
		{
			super();
			
			if(vdoPlayer) videoPlayer = vdoPlayer;
		}
		
		
		
		protected function _vp_progress(event:VideoProgressEvent):void
		{
			if(VideoPlayer(event.target).bytesLoaded == VideoPlayer(event.target).bytesTotal){
				// ロード完了
				dispatchEvent(new DynamicEvent(EVENT_LOADED));
			}
		}
		
		
		
		private function _initVP(vp:VideoPlayer):void
		{
			vp.addEventListener(VideoProgressEvent.PROGRESS, _vp_progress);
		}
		
		private function _finVP(vp:VideoPlayer):void
		{
			vp.removeEventListener(VideoProgressEvent.PROGRESS, _vp_progress);
		}
	}
}