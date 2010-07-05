package saz.util.twitter {
	import saz.util.*;
	/**
	 * Twitter関連ユーティリティー。
	 * @author saz
	 */
	public class TwitterUtil {
		//static public const REG_URL:String = "(\\s|^)((https?|ftp)://[0-9a-zA-Z,;:~&=@_'%?+\-/$.!*()]+)(\\s|$)";
		//static public const REG_URL:String = "(\\s|^)" + RegExpUtil.REG_URL + "(\\s|$)";
		//static public const REPL_URL:String = "$1<a href=\"$2\">$2</a>$4";
		
		// ex. http://search.twitter.com/search?q=%232010wc	アメリカ
		//static private const $URL_HASHTAG1:String = "http://search.twitter.com/search?q=";
		// ex. http://twitter.com/#search?q=%23wanko		日本
		static private const $URL_HASHTAG1:String = "http://twitter.com/#search?q=";
		
		static private const $URL_REPLY1:String = "http://twitter.com/";
		
		
		/**
		 * ハッシュタグに一致する正規表現。
		 */
		static public const REG_HASHTAG:String = "\#(\\w+)";
		
		/**
		 * ハッシュタグリンク生成用置換文字列。
		 */
		//static public const REPL_HASHTAG:String = '<a href="http://search.twitter.com/search?q=%23$1" target="_blank">#$1</a>';
		static public const REPL_HASHTAG:String = '<a href="' + $URL_HASHTAG1 + '%23$1" target="_blank">#$1</a>';
		
		/**
		 * ＠ユーザー名に一致する正規表現。
		 */
		static public const REG_REPLY:String = "\@(\\w+)";
		
		/**
		 * ＠ユーザー名リンク生成用置換文字列。
		 */
		//static public const REPL_REPLY:String = '@<a href="http://twitter.com/$1" target="_blank">$1</a>';
		static public const REPL_REPLY:String = '@<a href="' + $URL_REPLY1 + '$1" target="_blank">$1</a>';
		
		
		
		/**
		 * ツイート用にリンクを生成。（URL、ハッシュタグ、＠ユーザー名）
		 * @param	text
		 * @return
		 */
		static public function genTweetLinks(text:String):String {
			// URL変換を一番最初に実行
			return text.replace(new RegExp(RegExpUtil.REG_URL,"g"),RegExpUtil.REPL_URL)
				.replace(new RegExp(TwitterUtil.REG_HASHTAG,"g"),TwitterUtil.REPL_HASHTAG)
				.replace(new RegExp(TwitterUtil.REG_REPLY,"g"),TwitterUtil.REPL_REPLY);
		}
		
		/**
		 * hashタグにリンクをつける。
		 * @param	text
		 * @return
		 */
		static public function genHashTagLink(text:String):String {
			return text.replace(
				new RegExp(REG_HASHTAG, "g"),
				REPL_HASHTAG
			);
		}
		
		/**
		 * ＠ユーザー名にリンクをつける。
		 * @param	text
		 * @return
		 */
		static public function genReplyLink(text:String):String {
			return text.replace(
				new RegExp(REG_REPLY, "g"),
				REPL_REPLY
			);
		}
		
		
		
		/**
		 * ハッシュタグのリンク先URLを返す。
		 * @param	hashTag	ハッシュタグ。
		 * @return	like "http://twitter.com/#search?q=%23nelboke"
		 */
		public static function getHashTagPageUrl(hashTag:String):String {
			//return "http://twitter.com/search?q=" + escape(hashTag);	// encodeURIと結果がちがう
			return $URL_HASHTAG1 + escape(hashTag);		// escape()は、encodeURI()と結果がちがう
		}
		
		
		/**
		 * ツイート個別ページのURLを返す。
		 * @param	userScreenName	ユーザーscreen_name。
		 * @param	tweetId	ツイートid。
		 * @return	like "http://twitter.com/x_karin_x/status/17536861716"
		 */
		public static function getTweetPageUrl(userScreenName:String, tweetId:String):String {
			return "http://twitter.com/" + userScreenName + "/status/" + tweetId;
		}
		
		/**
		 * ツイート個別ページのURLを返す。
		 * @param	tweetData	TwitterUserDataを含む、TwitterTweetDataインスタンス。
		 * @return
		 */
		public static function getTweetPageUrlByData(tweetData:TwitterTweetData):String {
			return getTweetPageUrl(tweetData.user.screen_name, tweetData.id);
		}
		
		
		
		/**
		 * ユーザーページのURLを返す。
		 * @param	userScreenName	ユーザーscreen_name。
		 * @return	like "http://twitter.com/pique3"
		 */
		public static function getUserPageUrl(userScreenName:String):String {
			//return "http://twitter.com/" + userScreenName;
			return $URL_REPLY1 + userScreenName;
		}
		
		/**
		 * ユーザーページのURLを返す。
		 * @param	userData	TwitterUserDataインスタンス。
		 * @return
		 */
		public static function getUserPageUrlByData(userData:TwitterUserData):String {
			return getUserPageUrl(userData.screen_name);
		}
		
	}

}