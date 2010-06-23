package saz.string {
	
	/**
	 * URL操作。
	 * プロパティ名はJSのwindow.locationのまね。<br/>
	 * TODO:	ローカルパスへの対応が中途半端。<br/>
	 * @see http://pzxa85.hp.infoseek.co.jp/www/js/location.htm
	 * @author saz
	 */
	public class Location {
		
		public static const PROTOCOL_HTTP:String = "http:";
		public static const PROTOCOL_HTTPS:String = "https:";
		public static const PROTOCOL_FILE:String = "file:";
		
		private var $url:String;
		
		private var $protocol:String;
		private var $host:String;
		private var $hostname:String;
		private var $port:String;
		private var $pathname:String;
		private var $search:String;
		private var $hash:String;
		
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
		 * host:     "www.yyy.zzz:8000"
		 * hostname: "www.yyy.zzz"
		 * port:     "8000"
		 * pathname: "/aaa/bbb/ccc.cgi"
		 * search:   "?KEY=CGI"
		 * hash:     "#XYZ"
		 * </pre>
		 * @param	url
		 */
		function Location(url:String) {
			$init(url);
		}
		
		private function $init(url:String):void {
			this.$url = url;
			var rest:String = url;
			var arr1:Array;
			arr1 = rest.split("//");
			this.$protocol = String(arr1.shift());
			rest = arr1.join("//");
			
			arr1 = rest.split("/");
			this.$host = String(arr1.shift());
			var hostArr:Array = this.$host.split(":");
			this.$hostname = hostArr[0];
			this.$port = (hostArr[1] == undefined) ? "" : hostArr[1];
			rest = arr1.join("/");
			
			arr1 = rest.split("#");
			//trace(arr1);
			//trace(arr1.length);
			this.$hash = (arr1.length == 1) ? "" : "#" + arr1.pop();
			//trace(arr1);
			//trace(arr1.length);
			rest = arr1.join("#");
			
			arr1 = rest.split("?");
			this.$pathname = "/" + String(arr1.shift());
			rest = arr1.join("?");
			
			this.$search = (rest == "") ? "" : "?" + rest;
		}
		
		//--------------------------------------
		// GETTER
		//--------------------------------------
		
		public function get url():String { return $url; }
		
		
		/**
		 * プロトコル
		 * "http:", "file:"
		 */
		public function get protocol():String { return $protocol; }
		
		/**
		 * ポート込みのホスト
		 * "www.yyy.zzz:8000"
		 */
		public function get host():String { return $host; }
		
		/**
		 * ホスト名
		 * "www.yyy.zzz"
		 */
		public function get hostname():String { return $hostname; }
		
		/**
		 * ポート
		 * "8000"
		 */
		public function get port():String { return $port; }
		
		/**
		 * パス
		 * "/aaa/bbb/ccc.cgi"
		 */
		public function get pathname():String { return $pathname; }
		
		/**
		 * クエリー部分
		 * "?KEY=CGI"
		 */
		public function get search():String { return $search; }
		
		/**
		 * ハッシュ
		 */
		public function get hash():String { return $hash; }
		
		
	}
	
}