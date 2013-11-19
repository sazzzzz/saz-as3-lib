package saz.external.youtube3
{
	public class PlayerWrapper
	{
		
		public var player:Object;
		
		public function PlayerWrapper(youtubePlayer:Object=null)
		{
			player = youtubePlayer;
		}
		
		
		
		//--------------------------------------
		// 再生の制御とプレーヤーの設定
		//--------------------------------------
		
		
		/**
		 * 頭出し済み、または読み込み済みの動画を再生します。
		 * 
		 */
		public function playVideo():void
		{
			player.playVideo();
		}
		
		/**
		 * 再生中の動画を一時停止します。
		 * 
		 */
		public function pauseVideo():void
		{
			player.pauseVideo();
		}
		
		/**
		 * 現在の動画を停止します。この関数は動画の読み込みもキャンセルします。
		 * 
		 */
		public function stopVideo():void
		{
			player.stopVideo();
		}
		
		/**
		 * 動画の指定された時間（秒数）をシークします。seekTo() 関数は、指定された seconds より前の最も近いキーフレームを探します。そのため、リクエストされた時間の直前から再生が開始される場合もありますが、通常は最大で 2 秒程度です。
		 * @param seconds
		 * @param allowSeekAhead	allowSeekAhead パラメータは、現在読み込んでいる動画の長さを seconds の値が超えている場合にプレーヤーからサーバーに新しいリクエストを行うかどうかを指定します。
		 * 
		 */
		public function seekTo(seconds:Number, allowSeekAhead:Boolean):void
		{
			player.seekTo(seconds, allowSeekAhead);
		}
		
		
		/**
		 * プレーヤーのサイズをピクセル単位で設定します。MovieClip の width プロパティと height プロパティの代わりにこのメソッドを使うことをおすすめします。
		 * このメソッドは動画プレーヤーの縦横比を固定しないので、4:3 のアスペクト比が維持されるように注意する必要があります。
		 * 別の SWF に読み込まれたときのクロムレス SWF のデフォルト サイズは 320x240 ピクセルで、埋め込みプレーヤー SWF のデフォルト サイズは 480x385 ピクセルです。
		 * 
		 * @param width
		 * @param height
		 * 
		 */
		public function setSize(width:Number, height:Number):void
		{
			player.setSize(width, height);
		}
		
		
		
		
		
		
		
		
		//--------------------------------------
		// 再生ステータス
		//--------------------------------------
		
		
		
		/**
		 * プレーヤーの状態を返します。値には、未開始（-1）、終了（0）、再生中（1）、一時停止中（2）、バッファリング中（3）、頭出し済み（5）があります。
		 * @return 
		 */
		public function getPlayerState():Number
		{
			return player.getPlayerState();
		}
		
		/**
		 * 動画の再生を開始してからの経過時間を秒数で返します。
		 * @return 
		 */
		public function getCurrentTime():Number
		{
			return player.getCurrentTime();
		}

		
		
		/**
		 * 現在の動画の読み込み済みバイト数を返します。
		 * @return 
		 * 
		 * @deprecated	Deprecated as of July 18, 2012. Instead, use the getVideoLoadedFraction method to determine the percentage of the video that has buffered.
		 */
		public function getVideoBytesLoaded():Number
		{
			return player.getVideoBytesLoaded();
		}
		
		/**
		 * 読み込み済みまたは再生中の動画のサイズをバイト数で返します。
		 * @return 
		 * 
		 * @deprecated	Deprecated as of July 18, 2012. Instead, use the getVideoLoadedFraction method to determine the percentage of the video that has buffered.
		 */
		public function getVideoBytesTotal():Number
		{
			return player.getVideoBytesTotal();
		}
		
		
		/**
		 * 動画ファイルの読み込みを開始した位置をバイト数で返します。
		 * サンプル シナリオ: まだ読み込んでいない位置をユーザーがシークした場合や、まだ読み込んでいない動画セグメントの再生をプレーヤーがリクエストした場合に使用します。
		 * @return 
		 * 
		 * @deprecated	Deprecated as of October 31, 2012. Returns the number of bytes the video file started loading from. (This method now always returns a value of 0.) Example scenario: the user seeks ahead to a point that hasn't loaded yet, and the player makes a new request to play a segment of the video that hasn't loaded yet.
		 */
		public function getVideoStartBytes():Number
		{
			return player.getVideoStartBytes();
		}
		
		
		
		
		
		
		//--------------------------------------
		// 再生画質
		//--------------------------------------
		
		/**
		 * この関数は、現在の動画の推奨画質を設定し、現在の位置から新しい画質で動画をリロードします。再生画質を変更した場合、再生している動画の画質のみが変更されます。
		 * 
		 * @param suggestedQuality
		 * 
		 */
		public function setPlaybackQuality(suggestedQuality:String):void
		{
			player.setPlaybackQuality(suggestedQuality);
		}
		
		/**
		 * この関数は、現在の動画で有効な画質のセットを返します。この関数を使用すると、ユーザーが表示している画質よりも高い画質で動画を再生できるかどうかを判断し、プレーヤーにボタンなどの要素を表示してユーザーが画質を調整できるようにすることができます。
		 * 
		 * この関数は、高画質から低画質の順で、画質を示す文字列の配列を返します。配列要素の値には、hd720、large、medium、small があります。現在の動画がない場合、この関数は空の配列を返します。
		 * 
		 * クライアントで、最高または最低の画質や不明な画質形式に自動的に切り替えないようにしてください。YouTube は、お使いのプレーヤーに適さない画質レベルを追加する可能性があります。
		 * 同様に、ユーザー操作の妨げとなり得る画質オプションを削除する可能性もあります。有効な既知の画質形式のみに切り替えるようにすることで、クライアントは、新しい画質レベルの追加やプレーヤーに適さない画質レベルの削除による影響を受けなくなります。
		 * 
		 * @return 
		 * 
		 */
		public function getAvailableQualityLevels():Array
		{
			return player.getAvailableQualityLevels();
		}
	}
}