package saz.external.youtube3
{
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	/**
	 * YouTube用ユーティリティクラス。
	 * @author saz
	 * 
	 */
	public class YoutubeUtil
	{
		
		public static const CHROMELESS_URL:String = "http://www.youtube.com/apiplayer?version=3";
		
		// ex. http://youtube.googleapis.com/v/0tr10QN2R_g?version=3&rel=0&autoplay=1&hd=1&fs=1&showinfo=0
		public static const EMBEDDED_BASE_URL:String = "http://youtube.googleapis.com/v/";
		
		
		/**
		 * クロムレスプレーヤのURLRequestを返す。
		 * 
		 * @return URLRequest。
		 * 
		 */
		public static function chromelessRequest():URLRequest
		{
			return new URLRequest(CHROMELESS_URL);
		}
		
		/**
		 * 埋め込みプレーヤーのURLRequestを返す。
		 * 
		 * @param videoId	再生する動画の YouTube 動画 ID。
		 * @param params	埋め込みプレーヤーに渡すパラメータ。（https://developers.google.com/youtube/player_parameters?hl=ja）
		 * @return URLRequest。
		 * 
		 * @see	https://developers.google.com/youtube/player_parameters?hl=ja
		 * 
		 */
		public static function embeddedRequest(videoId:String, params:URLVariables=null):URLRequest
		{
			// ex. http://youtube.googleapis.com/v/0tr10QN2R_g?version=3&rel=0&autoplay=1&hd=1&fs=1&showinfo=0
			params ||= new URLVariables();
			params.version = "3";
			
			var res:URLRequest = new URLRequest(EMBEDDED_BASE_URL + videoId);
			res.data = params;
			return res;
		}
	}
}