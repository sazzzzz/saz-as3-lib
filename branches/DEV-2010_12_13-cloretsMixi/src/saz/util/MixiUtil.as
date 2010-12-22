package saz.util {
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