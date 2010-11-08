package saz.media {
	import flash.events.Event;
	
	/**
	 * SoundBeatイベント.
	 * @author saz
	 */
	public class SoundHelperEvent extends Event {
		
		/**
		 * 再生開始したときに送出されます.
		 */
		static public const PLAY:String = "play";
		/**
		 * 再生停止したときに送出されます.
		 */
		static public const STOP:String = "stop";
		
		/**
		 * ビートに変化があったときに送出されます.
		 */
		static public const BEAT:String = "beat";
		/**
		 * ループしたときに送出されます.
		 */
		static public const LOOP:String = "loop";
		
		/**
		 * ビート。
		 */
		public var beat:int;
		
		/**
		 * ループ回数。
		 */
		public var loop:int;
		
		public function SoundHelperEvent(type:String, beat:int, loop:int = 0) {
			super(type);
			
			this.beat = beat;
			this.loop = loop;
		}
		
	}

}