package saz.twitter {
	
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
		
		/**
		 * TwitterXMLサンプル
		 * Twitter API 仕様書 日本語訳 第四十九版 (2010年3月3日版)
		 * http://watcher.moe-nifty.com/memo/docs/twitterAPI.txt より
		 * ――――――――――――――――――――――――――――――――――――――――――――――――――
		 * <?xml version="1.0" encoding="UTF-8"?>
		 * <statuses type="array">
		 *   <status>
		 * 	 <created_at>Wed Nov 18 18:54:12 +0000 2009</created_at>
		 * 	 <id>5833943856</id>
		 * 	 <text>RT @peoplemag: New Moon director Chris Weitz says he's quitting movies after one more http://ow.ly/DrjQ</text>
		 * 	 <source>web</source>
		 * 	 <truncated>false</truncated>
		 * 	 <in_reply_to_status_id></in_reply_to_status_id>
		 * 	 <in_reply_to_user_id></in_reply_to_user_id>
		 * 	 <favorited>false</favorited>
		 * 	 <in_reply_to_screen_name></in_reply_to_screen_name>
		 * 	 <retweeted_status>
		 * 		<created_at>Wed Nov 18 18:36:34 +0000 2009</created_at>
		 * 		<id>5833513351</id>
		 * 		<text>New Moon director Chris Weitz says he's quitting movies after one more http://ow.ly/DrjQ</text>
		 * 		<source><a href="http://www.hootsuite.com" rel="nofollow">HootSuite</a></source>
		 * 		<truncated>false</truncated>
		 * 		<in_reply_to_status_id></in_reply_to_status_id>
		 * 		<in_reply_to_user_id></in_reply_to_user_id>
		 * 		<favorited>false</favorited>
		 * 		<in_reply_to_screen_name></in_reply_to_screen_name>
		 * 		<user>
		 * 		   <id>25589776</id>
		 * 		   <name>People magazine</name>
		 * 		   <screen_name>peoplemag</screen_name>
		 * 		   <location></location>
		 * 		   <description>PEOPLE.com is the No. 1 site for celebrity news!</description>
		 * 		   <profile_image_url>http://a3.twimg.com/profile_images/116213891/people_73x73_normal.jpg</profile_image_url>
		 * 		   <url>http://www.people.com</url>
		 * 		   <protected>false</protected>
		 * 		   <followers_count>1653473</followers_count>
		 * 		   <profile_background_color>08a9e7</profile_background_color>
		 * 		   <profile_text_color>000000</profile_text_color>
		 * 		   <profile_link_color>ee0077</profile_link_color>
		 * 		   <profile_sidebar_fill_color>ffee9a</profile_sidebar_fill_color>
		 * 		   <profile_sidebar_border_color>ffcc66</profile_sidebar_border_color>
		 * 		   <friends_count>406</friends_count>
		 * 		   <created_at>Fri Mar 20 22:30:24 +0000 2009</created_at>
		 * 		   <favourites_count>2</favourites_count>
		 * 		   <utc_offset>-18000</utc_offset>
		 * 		   <time_zone>Eastern Time (US & Canada)</time_zone>
		 * 		   <profile_background_image_url>http://a1.twimg.com/profile_background_images/6859800/bgpage.gif</profile_background_image_url>
		 * 		   <profile_background_tile>true</profile_background_tile>
		 * 		   <statuses_count>1740</statuses_count>
		 * 		   <notifications>false</notifications>
		 * 		   <geo_enabled>false</geo_enabled>
		 * 		   <verified>false</verified>
		 * 		   <following>false</following>
		 * 		</user>
		 * 		<geo/>
		 * 	 </retweeted_status>
		 * 	 <user>
		 * 		<id>44940026</id>
		 * 		<name>Anita Doller</name>
		 * 		<screen_name>testiverse</screen_name>
		 * 		<location></location>
		 * 		<description></description>
		 * 		<profile_image_url>http://a3.twimg.com/profile_images/251164577/testing_normal.JPG</profile_image_url>
		 * 		<url></url>
		 * 		<protected>false</protected>
		 * 		<followers_count>14</followers_count>
		 * 		<profile_background_color>9ae4e8</profile_background_color>
		 * 		<profile_text_color>000000</profile_text_color>
		 * 		<profile_link_color>0000ff</profile_link_color>
		 * 		<profile_sidebar_fill_color>e0ff92</profile_sidebar_fill_color>
		 * 		<profile_sidebar_border_color>87bc44</profile_sidebar_border_color>
		 * 		<friends_count>25</friends_count>
		 * 		<created_at>Fri Jun 05 17:07:09 +0000 2009</created_at>
		 * 		<favourites_count>1</favourites_count>
		 * 		<utc_offset>-28800</utc_offset>
		 * 		<time_zone>Pacific Time (US & Canada)</time_zone>
		 * 		<profile_background_image_url>http://s.twimg.com/a/1258507899/images/themes/theme1/bg.png</profile_background_image_url>
		 * 		<profile_background_tile>false</profile_background_tile>
		 * 		<statuses_count>14</statuses_count>
		 * 		<notifications>false</notifications>
		 * 		<geo_enabled>false</geo_enabled>
		 * 		<verified>false</verified>
		 * 		<following>true</following>
		 * 	 </user>
		 * 	 <geo/>
		 *   </status>
		 *   <status>
		 * 	 <created_at>Wed Nov 18 18:53:17 +0000 2009</created_at>
		 * 	 <id>5833921302</id>
		 * 	 <text>Can't believe I didn't know about TextMate column-select. @macasek just showed me the power. Now I can't be stopped.</text>
		 * 	 <source><a href="http://www.atebits.com/" rel="nofollow">Tweetie</a></source>
		 * 	 <truncated>false</truncated>
		 * 	 <in_reply_to_status_id></in_reply_to_status_id>
		 * 	 <in_reply_to_user_id></in_reply_to_user_id>
		 * 	 <favorited>false</favorited>
		 * 	 <in_reply_to_screen_name></in_reply_to_screen_name>
		 * 	 <user>
		 * 		<id>364</id>
		 * 		<name>Mike Champion</name>
		 * 		<screen_name>graysky</screen_name>
		 * 		<location>Boston, MA</location>
		 * 		<description>Developer at @oneforty</description>
		 * 		<profile_image_url>http://a1.twimg.com/profile_images/72387934/me3_normal.jpg</profile_image_url>
		 * 		<url>http://graysky.org</url>
		 * 		<protected>false</protected>
		 * 		<followers_count>866</followers_count>
		 * 		<profile_background_color>2f2f2f</profile_background_color>
		 * 		<profile_text_color>2f2f2f</profile_text_color>
		 * 		<profile_link_color>599B4C</profile_link_color>
		 * 		<profile_sidebar_fill_color>FDFDFD</profile_sidebar_fill_color>
		 * 		<profile_sidebar_border_color>599B4C</profile_sidebar_border_color>
		 * 		<friends_count>387</friends_count>
		 * 		<created_at>Sat Jun 24 17:47:36 +0000 2006</created_at>
		 * 		<favourites_count>53</favourites_count>
		 * 		<utc_offset>-18000</utc_offset>
		 * 		<time_zone>Eastern Time (US & Canada)</time_zone>
		 * 		<profile_background_image_url>http://a1.twimg.com/profile_background_images/332/mem_drive_large.jpg</profile_background_image_url>
		 * 		<profile_background_tile>false</profile_background_tile>
		 * 		<statuses_count>3489</statuses_count>
		 * 		<notifications>false</notifications>
		 * 		<geo_enabled>false</geo_enabled>
		 * 		<verified>false</verified>
		 * 		<following>false</following>
		 * 	 </user>
		 * 	 <geo/>
		 *   </status>
		 *    ... (略) ...
		 * </statuses>
		 * ――――――――――――――――――――――――――――――――――――――――――――――――――
		 */
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
			return "http://twitter.com/" + user.screen_name + "/status/" + id;
		}
		
	}
	
}