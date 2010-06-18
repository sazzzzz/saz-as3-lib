package saz.util {
	
	/**
	 * 変数のデフォルト値
	 * @see	http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7f9d.html#WS5b3ccc516d4fbf351e63e3d118a9b90204-7f8b
	 * @author saz
	 */
	public class VarDefault {
		
		public static const UNDEFINED = undefined;
		
		/**
		 * Numberのデフォルト値判定には、isNumberDefault()を使う。
		 */
		public static const NUMBER = NaN;
		
		public static const BOOLEAN = false;
		public static const INT = 0;
		public static const UINT = 0;
		public static const STRING = null;
		public static const OBJECT = null;
		public static const OTHERS = null;
		
		/**
		 * Numberがデフォルト値かどうかを返す。
		 * @param	value
		 * @return
		 */
		public static function isNumberDefault(value:Number):Boolean {
			return isNaN(value);
		}
		
	}
	
}