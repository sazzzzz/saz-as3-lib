package saz.external.youtube3
{
	import flash.events.Event;
	
	public class YoutubeEvent extends Event
	{
		
		/**
		 * このイベントは、プレーヤーの読み込み、初期化が終了し、API 呼び出しを受け取ることができるようになったときに起動します。
		 */
		public static const READY:String = "onReady";
		
		/**
		 * このイベントは、プレーヤーの状態が変わると起動します。
		 * 値には、未開始（-1）、終了（0）、再生中（1）、一時停止中（2）、バッファリング中（3）、頭出し済み（5）があります。
		 * SWF を初めて読み込んだときは、未開始（-1）イベントがブロードキャストされます。動画の頭出しをして再生の準備が整ったら、頭出し済みイベント（5）がブロードキャストされます。
		 */
		public static const STATE_CHANGE:String = "onStateChange";
		
		/**
		 * このイベントは、動画の再生画質が変わると起動します。
		 * たとえば、setPlaybackQuality(suggestedQuality) 関数を呼び出した場合、再生画質が実際に変わるとこのイベントが起動します。
		 * コードを記述する際は、setPlaybackQuality(suggestedQuality) 関数を呼び出したら画質が自動的に変わるものと想定せず、このイベントに応答するようにする必要があります。
		 * 同様に、setPlaybackQuality や、推奨再生画質を設定できる関数を明示的に呼び出せば再生画質は変わるものと想定しないようにする必要もあります。
		 * 
		 * このイベントがブロードキャストする値は、新しい再生画質を示します。値には、「small」、「medium」、「large」、「hd720」があります。
		 */
		public static const PLAYBACK_QUALITY_CHANGE:String = "onPlaybackQualityChange";
		
		/**
		 * このイベントは、プレーヤーでエラーが起きると起動します。
		 * エラーコードには、100、101、150 があります。
		 * 100 エラー コードは、リクエストされた動画が見つからないときにブロードキャストされます。これは、動画が何らかの理由で削除されている場合や、非公開に設定されている場合に発生します。
		 * 101 エラー コードは、リクエストされた動画が埋め込みプレーヤーでの再生を許可していないときにブロードキャストされます。
		 * エラー コード 150 は 101 と同じで、101 のコード違いです。
		 */
		public static const ERROR:String = "onError";
		
		public function YoutubeEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}