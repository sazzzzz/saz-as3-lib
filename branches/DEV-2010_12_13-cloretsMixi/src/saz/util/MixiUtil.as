package saz.util {
	import flash.external.ExternalInterface;
	/**
	 * mixiユーティリティ.
	 * @author saz
	 */
	public class MixiUtil {
		
		public static const THUM_SIZE_L:int = 180;
		public static const THUM_SIZE_M:int = 76;
		public static const THUM_SIZE_S:int = 40;
		
		public static const URL_NOIMAGE_L:String = "http://img.mixi.jp/img/basic/common/noimage_member180.gif";
		public static const URL_NOIMAGE_M:String = "http://img.mixi.jp/img/basic/common/noimage_member76.gif";
		public static const URL_NOIMAGE_S:String = "http://img.mixi.jp/img/basic/common/noimage_member40.gif";
		
		public static const URL_RUN_APP:String = "http://mixi.jp/run_appli.pl?id=";
		public static const URL_VIEW_APP:String = "http://mixi.jp/view_appli.pl?id=";
		
		/**
		 * アプリ実行ページURL
		 * @param	appId
		 * @return
		 */
		public static function getRunAppUrl(appId:String, params:Object = null):String {
			if (params) {
				//return URL_RUN_APP + appId + "&appParams=" + encodeAppParams(params);
				return URL_RUN_APP + appId + "&" + encodeAppParams(params);
			}else {
				return URL_RUN_APP + appId;
			}
			//return URL_RUN_APP + appId + ((params) ? "&" + encodeAppParams(params) : "");
		}
		
		/**
		 * アプリ紹介ページURL
		 * @param	appId
		 * @return
		 */
		public static function getViewAppUrl(appId:String):String {
			return URL_VIEW_APP + appId;
		}
		
		
		/**
		 * appParams用にObjectをエンコード. 
		 * @param	params
		 * @return
		 */
		public static function encodeAppParams(params:Object):String {
			return ExternalInterface.call("kiss.encodeAppParams", params);
		}
		
		/**
		 * プロフィール画像のURL
		 * @param	thumUrl
		 * @param	size
		 * @return
		 * @see	http://developer.mixi.co.jp/appli/spec/pc/url_rule
		 */
		public static function getProfileImageUrl(thumUrl:String, size:int = THUM_SIZE_M):String {
			if ("" == thumUrl) return getNoImageUrl(size);
			
			var arr:Array = thumUrl.split(".");
			var path:String = arr[arr.length - 2].slice(0, -1);
			switch(size) {
				case THUM_SIZE_L:
					break;
				case THUM_SIZE_M:
					path = path + "s";
					break;
				case THUM_SIZE_S:
					path = path + "m";
					break;
			}
			arr[arr.length - 2] = path;
			return arr.join(".");
		}
		
		/**
		 * 「NO IMAGE」画像のURL
		 * @param	size
		 * @return
		 * @see	http://developer.mixi.co.jp/appli/spec/pc/url_rule
		 */
		public static function getNoImageUrl(size:int = THUM_SIZE_M):String {
			switch(size) {
				case THUM_SIZE_L:
					return URL_NOIMAGE_L;
				case THUM_SIZE_M:
					return URL_NOIMAGE_M;
				case THUM_SIZE_S:
					return URL_NOIMAGE_S;
			}
			return URL_NOIMAGE_S;
		}
		
	}

}