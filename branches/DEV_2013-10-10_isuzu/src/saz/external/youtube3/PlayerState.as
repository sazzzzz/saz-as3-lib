package saz.external.youtube3
{
	/**
	 * プレーヤーの状態を表す定数。
	 * 値には、未開始（-1）、終了（0）、再生中（1）、一時停止中（2）、バッファリング中（3）、頭出し済み（5）があります。
	 * 
	 * @author saz
	 * @see	https://developers.google.com/youtube/flash_api_reference?hl=ja#Playback_status
	 * 
	 */
	public class PlayerState
	{
		
		/**
		 * 未開始（-1）。SWF を初めて読み込んだときは、未開始（-1）イベントがブロードキャストされます。
		 */
		public static const UNSTARTED:Number = -1;
		
		/**
		 * 終了（0）。
		 */
		public static const ENDED:Number = 0;
		
		/**
		 * 再生中（1）。
		 */
		public static const PLAYING:Number = 1;
		
		/**
		 * 一時停止中（2）。
		 */
		public static const PAUSED:Number = 2;
		
		/**
		 * バッファリング中（3）。
		 */
		public static const BUFFERING:Number = 3;
		
		/**
		 * 頭出し済み（5）。動画の頭出しをして再生の準備が整ったら、頭出し済みイベント（5）がブロードキャストされます。
		 */
		public static const CUED:Number = 5;
		
	}
}