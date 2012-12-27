package saz.net
{
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
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

		private var _isLocal:Boolean;
		private var _method:Function;
		
		public function AntiCache(loaderInfo:LoaderInfo, propName:String = "anticache")
		{
			init(loaderInfo, propName);
		}
		
		public function setMethod(callback:Function):void
		{
			_method = callback;
		}
		
		public function setMethodByRandom(multi:int):void
		{
			setMethod(function():String
			{
				return "" + Math.floor(Math.random() * multi);
			});
		}
		
		public function setMathodByDate(type:int):void
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
						ret = StringUtil.zeroPadding(d.getMonth(), 2) + ret;
					case DATE_TYPE_YEAR:
						ret = StringUtil.zeroPadding(d.getFullYear(), 4) + ret;
				}
				return ret;
			});
		}
		
		public function getValue():String
		{
			return _method();
		}
		
		public function decorateRequest(request:URLRequest):URLRequest
		{
			if (request.method != URLRequestMethod.GET) throw new ArgumentError("AntiCache.decorateRequest: URLRequest.method は 'GET'のみ対応しています。");
			
			var data:URLVariables = request.data || new URLVariables();
			data[name] = getValue();
			request.data = data;
			return request;
		}
		
		
		protected function init(loaderInfo:LoaderInfo, propName:String):void
		{
			var u:String = loaderInfo.url;
			_isLocal = StringUtil.leftHandMatch(u, "file:///");
			name = propName;
		}
		
		
		
		
	}
}