package saz.external.youtube3
{
	import flash.events.Event;
	
	public class YoutubeEvent extends Event
	{
		
		public static const READY:String = "onReady";
		public static const STATE_CHANGE:String = "onStateChange";
		public static const PLAYBACK_QUALITY_CHANGE:String = "onPlaybackQualityChange";
		public static const ERROR:String = "onError";
		
		public function YoutubeEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}