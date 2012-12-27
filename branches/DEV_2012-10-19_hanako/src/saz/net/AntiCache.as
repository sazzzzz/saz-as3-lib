package saz.net
{
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import saz.util.NetUtil;
	import saz.util.StringUtil;

	/**
	 * ブラウザキャッシュ対策。
	 * @author saz
	 * 
	 */
	public class AntiCache
	{
		
		public static const DATE_TYPE_YEAR:int = 0;
		public static const DATE_TYPE_MONTH:int = 1;
		public static const DATE_TYPE_DATE:int = 2;
		public static const DATE_TYPE_HOUR:int = 3;
		public static const DATE_TYPE_MINUTE:int = 4;
		public static const DATE_TYPE_SECOND:int = 5;
		
		public var name:String = "";

		private var _loaderInfoOnServer:Boolean;
		private var _method:Function;
		
		public function AntiCache(loaderInfo:LoaderInfo, propName:String = "anticache")
		{
			_init(loaderInfo, propName);
		}
		
		
		//--------------------------------------
		// 初期化
		//--------------------------------------
		
		/**
		 * 乱数を使うように初期化。
		 * @param multi	Math.random()に欠ける数。ここで設定した値の-1が最大値になる。
		 * 
		 */
		public function setMethodByRandom(multi:int):void
		{
			setMethod(function():String
			{
				return "" + Math.floor(Math.random() * multi);
			});
		}
		
		/**
		 * Dateを使うように初期化。
		 * @param type	Dateの値のうち、どこまで使うかを指定する。"DATE_TYPE_～"を指定すること。デフォルトはDATE_TYPE_HOUR。
		 * 
		 */
		public function setMethodByDate(type:int = DATE_TYPE_HOUR):void
		{
			setMethod(function():String
			{
				var d:Date = new Date();
				var ret:String = "";
				switch(type)
				{
					case DATE_TYPE_SECOND:
						ret = StringUtil.zeroPadding(d.getSeconds(), 2) + ret;
					case DATE_TYPE_MINUTE:
						ret = StringUtil.zeroPadding(d.getMinutes(), 2) + ret;
					case DATE_TYPE_HOUR:
						ret = StringUtil.zeroPadding(d.getHours(), 2) + ret;
					case DATE_TYPE_DATE:
						ret = StringUtil.zeroPadding(d.getDate(), 2) + ret;
					case DATE_TYPE_MONTH:
						ret = StringUtil.zeroPadding(d.getMonth() + 1, 2) + ret;
					case DATE_TYPE_YEAR:
						ret = StringUtil.zeroPadding(d.getFullYear(), 4) + ret;
				}
				return ret;
			});
		}
		
		/**
		 * 値を生成する関数を設定。
		 * @param callback
		 * 
		 */
		public function setMethod(callback:Function):void
		{
			_method = callback;
		}
		
		
		//--------------------------------------
		// 使う
		//--------------------------------------
		
		
		/**
		 * 値を返す。
		 * @return 
		 * 
		 */
		public function getValue():String
		{
			return _method() as String;
		}
		
		/**
		 * URLReqeustにキャッシュ対策用パラメータを付与して返す。
		 * @param request
		 * @return 
		 * 
		 */
		public function decorateRequest(request:URLRequest):URLRequest
		{
			if (request.method != URLRequestMethod.GET) throw new ArgumentError("AntiCache.decorateRequest: URLRequest.method は 'GET'のみ対応しています。");
			
			if (_getOnServer(request.url) || _loaderInfoOnServer)
			{
				var data:URLVariables = request.data as URLVariables || new URLVariables();
				data[name] = getValue();
				request.data = data;
			}
			
			return request;
		}
		
		/**
		 * URLにキャッシュ対策用パラメータを付与して返す。
		 * @param url
		 * @return 
		 * 
		 */
		public function decorateUrl(url:String):String
		{
			return NetUtil.requestToUrl(decorateRequest(NetUtil.urlToRequest(url)));
		}
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		
		
		private function _getOnServer(url:String):Boolean
		{
			return StringUtil.leftHandMatch(url, "http://") || StringUtil.leftHandMatch(url, "https://")
		}
		
		private function _init(loaderInfo:LoaderInfo, propName:String):void
		{
			var u:String = loaderInfo.url;
			_loaderInfoOnServer = _getOnServer(loaderInfo.url);
			name = propName;
			
			// デフォルトメソッド
			setMethodByDate();
		}
		
		
		
		
	}
}