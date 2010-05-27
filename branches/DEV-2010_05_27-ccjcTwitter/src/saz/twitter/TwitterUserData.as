package saz.twitter {
	
	/**
	 * twitterユーザーデータ保持クラス
	 * @author saz
	 */
	public class TwitterUserData {
		
		/**
		 * id。
		 */
		public var id:String;
		/**
		 * 表示名。
		 */
		public var name:String;
		/**
		 * ユーザー名。
		 */
		public var screen_name:String;
		/**
		 * 場所。
		 */
		public var location:String;
		/**
		 * バイオ？
		 */
		public var description:String;
		/**
		 * アイコン画像のURL。
		 */
		public var profile_image_url:String;
		public var url:String;
		public var protected:Boolean;
		public var followers_count:int;
		public var profile_background_color:int;
		public var profile_text_color:int;
		public var profile_link_color:int;
		public var profile_sidebar_fill_color:int;
		public var profile_sidebar_border_color:int;
		public var friends_count:int;
		public var created_at:Date;
		public var favourites_count:int;
		public var utc_offset:int;
		public var time_zone:String;
		public var profile_background_image_url:String;
		public var profile_background_tile:Boolean;
		public var statuses_count:int;
		public var notifications:Boolean;
		public var geo_enabled:Boolean;
		public var verified:Boolean;
		public var following:Boolean;
		
		function TwitterUserData() {
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
		 * プロフィールページのURL。
		 * @return	"http://twitter.com/tsuda"
		 */
		public function getProfilePageUrl():String {
			return "http://twitter.com/" + screen_name;
		}
		
	}
	
}