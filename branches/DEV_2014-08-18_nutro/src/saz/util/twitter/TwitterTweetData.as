package saz.util.twitter {
	
	/**
	 * twitterツイートデータ保持クラス
	 * @author saz
	 */
	public class TwitterTweetData {
		
		/**
		 * 投稿日時。
		 */
		public var created_at:Date;
		public var id:String;
		/**
		 * ツイート内容。HTML。
		 */
		public var text:String;
		/**
		 * 投稿元アプリケーション。HTML。
		 */
		public var source:String;
		public var truncated:Boolean;
		public var in_reply_to_status_id:String;
		public var in_reply_to_user_id:String;
		public var favorited:Boolean;
		public var in_reply_to_screen_name:String;
		public var retweeted_status:TwitterTweetData;
		public var user:TwitterUserData;
		public var geo:*;	// ?不明
		
		function TwitterTweetData() {
		}
		
		/**
		 * api出力のXMLをパース。
		 * @param	xml	api出力のXML。
		 */
		/*public function parseXML(xml:XML):void {
			
		}*/
		
		/**
		 * api出力のJSONをパース。
		 * @param	json	api出力のJSON。
		 */
		/*public function parseJSON(json:String):void {
			
		}*/
		
		/**
		 * ツイート個別ページのURLを返す。
		 * @return	"http://twitter.com/tsuda/status/14780129332"
		 */
		public function getTweetPageUrl():String {
			//return "http://twitter.com/" + user.screen_name + "/status/" + id;
			return TwitterUtil.getTweetPageUrlByData(this);
		}
		
		/**
		 * 現在のtext（ツイート内容）に、<a>タグを付与して返す。
		 * @return
		 */
		public function genTweetLinks():String {
			return TwitterUtil.genTweetLinks(text);
		}
		
	}
	
}