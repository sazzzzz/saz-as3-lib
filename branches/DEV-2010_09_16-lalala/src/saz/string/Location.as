package saz.string {
	import saz.util.RegExpUtil;
	
	/**
	 * URL操作。
	 * プロパティ名はJSのwindow.locationのまね。<br/>
	 * ローカルファイルは非対応です。<br/>
	 * @see http://pzxa85.hp.infoseek.co.jp/www/js/location.htm
	 * @author saz
	 */
	public class Location {
		
		public static const PROTOCOL_HTTP:String = "http:";
		public static const PROTOCOL_HTTPS:String = "https:";
		public static const PROTOCOL_FTP:String = "ftp:";
		//public static const PROTOCOL_FILE:String = "file:";	//ローカルファイル非対応
		
		static public var regExp:RegExp;
		
		public var protocol:String;
		public var hostname:String;
		public var port:String;
		public var search:String;
		public var hash:String;
		public var directory:String;
		public var filename:String;
		
		
		/**
		 * コンストラクタ。<br/>
		 * <h5>サンプル：</h5>
		 * <pre>
		 * var loc:Location = new Location("http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI#XYZ");
		 * trace(loc.search);
		 * </pre>
		 * <h5>出力例：</h5>
		 * URL の各部を示す文字列を返します。href の値が "http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI#XYZ" だとすると、それぞれの値は以下のようになります。<br/>
		 * <pre>
		 * protocol: "http:"
		 * hostname: "www.yyy.zzz"
		 * port:     "8000"
		 * directory:"/aaa/bbb/"
		 * filename: "ccc.cgi"
		 * search:   "?KEY=CGI"
		 * hash:     "#XYZ"
		 * host:     "www.yyy.zzz:8000"
		 * pathname: "/aaa/bbb/ccc.cgi"
		 * </pre>
		 * @param	url
		 */
		function Location(url:String) {
			this.url = url;
		}
		
		public function parse(url:String):void {
			if (!regExp) regExp = new RegExp(RegExpUtil.PARSE_URL);
			var res:Array = url.match(regExp);
			/*
			0	http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI#XYZ
			1*	http
			2*	www.yyy.zzz
			3	:8000
			4*	8000
			5*	/aaa/bbb/
			6	bbb/
			7*	ccc.cgi
			8*	?KEY=CGI
			9*	#XYZ
			*/
			protocol = res[1] ? res[1] + ":" : "";
			hostname = res[2] ? res[2] : "";
			port = res[4] ? res[4] : "";
			directory = res[5] ? res[5] : "";
			filename = res[7] ? res[7] : "";
			search = res[8] ? res[8] : "";
			hash = res[9] ? res[9] : "";
			//$host = ("" == port) ? hostname : hostname + ":" + port;
			//$pathname = directory + filename;
		}
		
		//--------------------------------------
		// GETTER
		//--------------------------------------
		
		public function get url():String {
			return protocol + "//" + hostname + (("" == port) ? "" : ":" + port) + directory + filename + search + hash;
		}
		
		public function set url(value:String):void {
			parse(value);
		}
		
		public function get host():String {
			return ("" == port) ? hostname : hostname + ":" + port;
		}
		
		public function get pathname():String {
			return directory + filename;
		}
		
		
		
		
		
	}
	
}