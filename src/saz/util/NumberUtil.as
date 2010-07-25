package saz.util {
	
	/**
	 * ...
	 * @author saz
	 */
	public class NumberUtil {
		
		/**
		 * 2つのNumber比較用の値。
		 * @example <listing version="3.0" >
		 * if(Math.abs(a-b) < NumberUtil.EPSILON) {
		 * 	...
		 * }
		 * </listing>
		 * @see	http://itpro.nikkeibp.co.jp/article/COLUMN/20071019/285010/?ST=oss&P=2
		 */
		static public const EPSILON:Number = 2.22044604925031e-16;
		
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
		
		/**
		 * 最大公約数（greatest common divisor）を求める。
		 * @param	a
		 * @param	b
		 * @return
		 * @see	http://itpro.nikkeibp.co.jp/article/COLUMN/20071004/283832/?ST=oss&P=4
		 */
		static public function gcd(a:int, b:int):Number {
			//2 つの自然数（または整式） a, b (a ≧ b) について、a の b による剰余を r とすると、 a と b との最大公約数は b と r との最大公約数に等しいという性質が成り立つ。
			//この性質を利用して、 b を r で割った剰余、 除数 r をその剰余で割った剰余、と剰余を求める計算を逐次繰り返すと、剰余が 0 になった時の除数が a と b との最大公約数となる。
			//http://ja.wikipedia.org/wiki/%E3%83%A6%E3%83%BC%E3%82%AF%E3%83%AA%E3%83%83%E3%83%89%E3%81%AE%E4%BA%92%E9%99%A4%E6%B3%95
			if (0 == b) {
				return a;
			}else {
				return arguments.callee(b, a % b);
			}
		}
		
		/**
		 * 2つのNumberが同じ値とみなしてよいかを返す。
		 * @param	a
		 * @param	b
		 * @return	2つのNumberの差がEPSILONより小さければtrue、大きければfalse。
		 */
		static public function equals(a:Number, b:Number):Boolean {
			return Math.abs(a - b) < EPSILON;
		}
		
	}
	
}