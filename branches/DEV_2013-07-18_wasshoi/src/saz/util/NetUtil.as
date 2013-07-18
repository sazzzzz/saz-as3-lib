package saz.util
{
	import flash.net.*;

	public class NetUtil
	{
		
		/**
		 * URLreqeust+URLVariablesを文字列に変換。
		 * @param request
		 * @return 
		 * 
		 */
		public static function requestToUrl(request:URLRequest):String
		{
			if (request.data == null) return request.url;
			
			var hash:Array = request.url.split("#");
			if (hash.length == 1) return request.url + "?" + URLVariables(request.data).toString();
			
			var u:String = hash.shift();
			return u + "?" + URLVariables(request.data).toString() + "#" + hash.join("#");
		}
		
		
		/**
		 * URL文字列をURLReqeustに変換する。
		 * @param url
		 * @return 
		 * 
		 */
		public static function urlToRequest(url:String):URLRequest
		{
			var u:String;
			var hash:Array = url.split("#");
			u = hash.shift();
			
			var arr:Array = u.split("?");
			u = arr.shift();
			
			if (hash.length > 0) u = u + "#" + hash.join("#");
			var req:URLRequest = new URLRequest(u);
			
			if (arr.length > 0)
			{
				var data:URLVariables = new URLVariables(arr.join("?"));
				req.data = data;
			}
			return req;
		}
		
	}
}