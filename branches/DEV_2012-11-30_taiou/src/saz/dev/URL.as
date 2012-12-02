package saz.dev
{
	import flash.net.URLRequest;

	/**
	 * URLを表す。directoryとfilnameぐらいしかテストしてない。完成にはほど遠い。
	 * @author saz
	 * 
	 * 
	 */
	public class URL
	{
		
		//--------------------------------------
		// 実装方針
		// データはなるべく細かい単位で保管する。
		//
		// 機能案
		// 相対移動
		// moveUp()
		// move(name)
		//--------------------------------------
		

		public function get scheme():String
		{
			return _scheme;
		}

		public function set scheme(value:String):void
		{
			_scheme = value;
		}
		private var _scheme:String = "";


		public function get host():String
		{
			return _host;
		}

		public function set host(value:String):void
		{
			_host = value;
		}
		private var _host:String = "";


		public function get directory():String
		{
			return _directory;
		}

		public function set directory(value:String):void
		{
			while(value.substr(-1, 1) == "/")
			{
				value = value.substr(0, value.length - 1);
			}
			_directory = value;
		}
		private var _directory:String = "";
		

		public function get filename():String
		{
			return _filename;
		}

		public function set filename(value:String):void
		{
			_filename = value;
		}
		private var _filename:String = "";
		
		

		public function get url():String
		{
			return _schemeForMerge() + _hostForMerge() + _directoryForMerge() + _filenameForMerge();
		}

		/*public function set url(value:String):void
		{
			_url = value;
			var index:int = url
		}
		private var _url:String = "";*/
		
		

		public function get request():URLRequest
		{
			if (_request == null) _request = new URLRequest();
			_request.url = url;
			return _request;
		}
		private var _request:URLRequest;

		
		/**
		 * コンストラクタ。
		 * 
		 * http://help.adobe.com/ja_JP/FlashPlatform/reference/actionscript/3/String.html#substr()
		 * ~~~~   ~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~
		 * scheme host           directory                                    filename
		 *                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		 *                       path
		 * 
		 * http://www.yyy.zzz:8000/aaa/bbb/ccc.cgi?KEY=CGI#XYZ
		 * ~~~~   ~~~~~~~~~~~ ~~~~ ~~~~~~~ ~~~~~~~ ~~~~~~~ ~~~
		 * scheme host        port directory       search?
		 *                                 filename        hash
		 * 
		 * @see	http://ja.wikipedia.org/wiki/Uniform_Resource_Locator
		 * @see	http://www.tohoho-web.com/js/location.htm
		 */
//		public function URL(initUrl:String = "")
		public function URL()
		{
//			url = initUrl;
		}
		
		private function _schemeForMerge():String
		{
			return scheme != "" ? scheme + ":" : "";
		}
		
		private function _hostForMerge():String
		{
			return host != "" ? "//" + host + "/" : "";
		}
		
		private function _directoryForMerge():String
		{
			return directory != "" ? directory + "/" : "";
		}
		
		private function _filenameForMerge():String
		{
			return filename;
		}
		
	}
}