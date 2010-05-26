package saz.util {
	
	/**
	 * ...
	 * @author saz
	 */
	public class NumberUtil {
		
		/**
		 * ランダムな整数を返す。
		 * @param	min	最小値
		 * @param	max	最大値
		 * @return
		 */
		public static function randomInt(min:int, max:int):int {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		
	}
	
}