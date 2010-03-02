package saz.util {
	
	/**
	 * ...
	 * @author saz
	 */
	public class StringUtil {
		
		/**
		 * Web形式カラー値をNumberに変換
		 * @param	hcolor	"#FF00CC"
		 * @return
		 */
		public static function hexColorToNumber(hcolor:String):Number {
			return parseInt(replace(hcolor, "#", ""), 16);
		}
		
		/**
		 * 文字列の置換
		 * @param	target
		 * @param	search
		 * @param	replace
		 * @return
		 */
		public static function replace(target:String, search:String, replace:String):String {
			return target.split(search).join(replace);
		}
		
	}
	
}