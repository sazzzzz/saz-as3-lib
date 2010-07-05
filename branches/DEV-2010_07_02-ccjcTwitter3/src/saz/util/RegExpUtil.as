package saz.util {
	/**
	 * 正規表現ユーティリティークラス。正規表現テンプレートなど。
	 * @author saz
	 * @example <listing version="3.0" >
	 * trace(html1.replace(new RegExp(RegExpUtil.REG_URL, "g"), RegExpUtil.REPL_URL));
	 * </listing>
	 */
	public class RegExpUtil {
		
		/**
		 * URLに一致する正規表現。
		 */
		static public const REG_URL:String = "((https?|ftp)://[0-9a-zA-Z,;:~&=@_'%?+\-/$.!*()]+)";
		/**
		 * URL -> <a>タグ用置換文字列。
		 */
		static public const REPL_URL:String = '<a href="$1" target="_blank">$1</a>';
		
		
		/**
		 * HTMLタグに一致する正規表現。
		 */
		static public const REG_HTML_TAG:String = '<[^>]*>';
		
		/**
		 * 文字列中のURLをリンクつきに置換。
		 * @param	target
		 * @return
		 */
		static public function genUrlLink(text:String):String {
			return text.replace(new RegExp(REG_URL, "g"), REPL_URL);
		}
		
		
		
		/*public static function get url(flags:String = null):RegExp {
			if (null == $url) $url = new RegExp("((https?|ftp)://[0-9a-zA-Z,;:~&=@_'%?+\-/$.!*()]+)", flags);
			return $url;
		}*/
		
	}

}