package saz.util {
	/**
	 * 正規表現ユーティリティークラス. 正規表現テンプレートなど. 
	 * @author saz
	 * @example <listing version="3.0" >
	 * trace(html1.replace(new RegExp(RegExpUtil.REG_URL, "g"), RegExpUtil.REPL_URL));
	 * </listing>
	 */
	public class RegExpUtil {
		
		// MEMO
		// コンストラクタでは、"\"を二重にすること. "\\d" "\\?" など. 
		
		/**
		 * URLに一致する正規表現. 
		 */
		static public const REG_URL:String = "((https?|ftp)://[0-9a-zA-Z,;:~&=@_'%?+\-/$.!*()]+)";
		//static public const URL:RegExp = /((https?|ftp)://[0-9a-zA-Z,;:~&=@_'%?+\-\/$.!*()]+)/;		//未テスト
		static public const URL:RegExp = new RegExp(REG_URL);		//未テスト
		
		/**
		 * URL展開する正規表現.
		 * @example <listing version="3.0" >
		 * var url:Strin = "http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI#XYZ";
		 * var res:Array = url.match(RegExpUtil.PARSE_URL);
		 * // http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI,http,www.yyy.zzz,:8000,8000,/aaa/bbb/,bbb/,ccc.cgi,?KEY=CGI
		 * </listing>
		 */
		static public const PARSE_URL:String = "(https?|ftp)://([^:/]+)(:(\\d+))?(/([^/]+/)*)?([^/?#]*)?(\\?[^#]*)?(#.*)?";
		//static public const PARSE_URL:String = "(https?|ftp|file)(://|:///)([^:/]+)(:(\\d+))?(/([^/]+/)*)?([^/?#]*)?(\\?[^#]*)?(#.*)?";
		
		/**
		 * URL -> <a>タグ用置換文字列. 
		 */
		static public const REPL_URL:String = '<a href="$1" target="_blank">$1</a>';
		
		
		/**
		 * HTMLタグに一致する正規表現. 
		 */
		static public const REG_HTML_TAG:String = '<[^>]*>';
		static public const HTML_TAG:RegExp = new RegExp(REG_HTML_TAG);
		
		/**
		 * メールアドレスに一致（簡易版）. 
		 */
		// http://blog.tofu-kun.org/070416103551.php
		static public const REG_MAIL:String = '^[^@]+@[^.]+\..+';
		static public const MAIL:RegExp = new RegExp(REG_MAIL);
		// http://www.tt.rim.or.jp/~canada/comp/cgi/tech/mailaddrmatch/
		
		/**
		 * 文字列中のURLをリンクつきに置換. 
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