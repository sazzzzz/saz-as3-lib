package saz.util
{
	import flash.net.*;
	
	import saz.string.Location;

	public class NetUtil
	{
		
		/**
		 * location.searchから、URLVariablesを生成。
		 * @param search
		 * @return 
		 * 
		 */
		public static function searchToVariables(search:String):URLVariables
		{
			return new URLVariables(searchToQuery(search));
		}
		
		/**
		 * location.searchからクエリ部分だけ取り出して返す（"?"を削除）。
		 * @param search
		 * @return 
		 * 
		 */
		public static function searchToQuery(search:String):String
		{
			var res:String = search;
			if (res.substr(0, 1) == "?") res = res.substr(1);
			return res;
		}
		
		public static function urlAddParams(params:Object, url:String):String
		{
			var loc:Location = new Location(url);
			var q:String = loc.search;
			if (q.indexOf("?") == 0) q = q.substr(1);
			var vars:URLVariables = new URLVariables(q);
			variablesAddParams(params, vars);
			
			return loc.protocol + "//" + loc.host + loc.pathname + (vars.toString().length > 0 ? "?" : "") + vars.toString() + loc.hash;
		}
		
		
		/**
		 * Objectのプロパティを、URLRequest追加する（浅いコピー）。
		 * @param params
		 * @param request
		 * @return 
		 * 
		 */
		public static function requestAddParams(params:Object, request:URLRequest=null):URLRequest
		{
			var res:URLRequest = request || new URLRequest();
			var vars:URLVariables = request.data as URLVariables || new URLVariables();
			res.data = variablesAddParams(params, vars);
			return res;
		}
		
		
		
		
		/**
		 * Objectのプロパティを、URLVariablesに追加する（浅いコピー）。
		 * @param params
		 * @param vars
		 * @return 
		 * 
		 */
		public static function variablesAddParams(params:Object, vars:URLVariables=null):URLVariables
		{
			var res:URLVariables = vars || new URLVariables();
			for (var key:String in params) 
			{
				res[key] = params[key];
			}
			return res;
		}
		
		
		/**
		 * URLVariablesに設定されたパラメータを空にする。
		 * @param vars
		 * @return 
		 * 
		 */
		public static function clearVariables(vars:URLVariables):URLVariables
		{
			for (var key:String in vars) 
			{
				delete vars[key];
			}
			return vars;
		}
		
		
		
		
		/**
		 * URLreqeust+URLVariablesを、文字列に変換。
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
		 * クエリを含んだURL文字列をパースして、URLReqeustに変換。
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
		
		
		/**
		 * URLから、キャッシュ対策したURLRequestを生成する。
		 * 
		 * @param url
		 * @return 
		 * 
		 */
		/*public static function urlToRequestNocache(url:String, type:int=DateUtil.HOUR, date:Date=null):URLRequest*/	// type:int=DateUtil.HOURでエラー
		public static function urlToNoCacheRequest(url:String):URLRequest
		{
			/*var vars:URLVariables = new URLVariables();
			vars.nocache = DateUtil.noCacheString();
			var req:URLRequest = new URLRequest(url);
			req.data = vars;
			return req;*/
			
			var req:URLRequest = urlToRequest(url);
			var vars:Object = req.data || new URLVariables();
			vars.nocache = DateUtil.noCacheString();
			req.data = vars;
			return req;
		}

		
		
	}
}