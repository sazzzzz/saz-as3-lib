package saz.util {
	
	/**
	 * ...
	 * @author saz
	 */
	public class NumberUtil {
		
		/**
		 * 指定範囲内に丸める。
		 * @param	value	
		 * @param	min	最小値。
		 * @param	max	最大値。
		 * @return	minとmaxの間の値に丸める。
		 */
		public static function clip(value:Number, min:Number, max:Number):Number {
			return Math.min(Math.max(value, min), max);
		}
		
		/**
		 * ランダムな整数を返す。
		 * @param	min	最小値。
		 * @param	max	最大値。
		 * @return
		 */
		public static function randomInt(min:int, max:int):int {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		
	}
	
}