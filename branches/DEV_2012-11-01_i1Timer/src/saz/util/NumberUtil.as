package saz.util {
	
	/**
	 * Numberユーティリティ. MathUtilに変名したい...
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
		public static const EPSILON:Number = 2.22044604925031e-16;
		
		
		/**
		 * 重複がない総当り.
		 * @param	count	チーム数. 
		 * @param	callback	コールバック. function(a:int, b:int):void
		 */
		//* @param	includeSelf	自分同士の組み合わせを含めるかどうか. 
		//static public function roundRobin(count:int, callback:Function, includeSelf:Boolean = false):void
		static public function roundRobin(count:int, callback:Function):void
		{
			var i:int, j:int;
			for(i = 0; i < count; i++) {
				for(j = 0; j < i; j++) {
					// do it
					callback(i,j);
					callback(j,i);
				}
			}
			
			/*var i:int, j:int;
			var n:int, m:int;
			for(i = 0, n = count; i < n; i++)
			{
				for(j = i + 1, m = count; j < m; j++)
				{
					// something
					callback(i, j);
					callback(j, i);
				}
			}*/
			/*for(i = 0, n = count; i < n; i++)
			{
				for(j = i, m = count; j < m; j++)
				{
					if (i == j)
					{
						// self
						if(includeSelf)
						{
							callback(i, j);
						}
					}
					else
					{
						// something
						callback(i, j);
						callback(j, i);
					}
				}
			}*/
		}
		
		//--------------------------------------------------------------------------
		//
		//  2つの値シリーズ
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 2つの数字を比較して、大きい値を返す. （Math.maxより高速）
		 * @param	a
		 * @param	b
		 * @return
		 * @see	http://wonderfl.net/c/2y4I
		 */
		public static function large(a:Number, b:Number):Number {
			return (a > b) ? a : b;
		}
		
		/**
		 * 2つの数字を比較して、小さい値を返す. （Math.minより高速）
		 * @param	a
		 * @param	b
		 * @return
		 * @see	http://wonderfl.net/c/2y4I
		 */
		public static function small(a:Number, b:Number):Number {
			return (a < b) ? a : b;
		}
		
		
		/**
		 * 最大公約数（greatest common divisor）を求める。
		 * @param	a
		 * @param	b
		 * @return
		 * @see	http://itpro.nikkeibp.co.jp/article/COLUMN/20071004/283832/?ST=oss&P=4
		 */
		public static function gcd(a:int, b:int):Number {
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
		public static function equals(a:Number, b:Number):Boolean {
			return Math.abs(a - b) < EPSILON;
		}
		
		
		
		
		
		
		
		
		
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
		 * 平均値計算用関数（クロージャ）を返す。
		 * @return	平均値計算用関数。
		 * @example <listing version="3.0" >
		 * var getAverage:Function = NumberUtil.averageClosure();
		 * trace(getAverage(1));
		 * trace(getAverage(2));
		 * </listing>
		 */
		public static function averageClosure():Function {
			var count:int = 0;
			var total:Number = 0.0;
			return function(value:Number):Number {
				count++;
				total += value;
				return total / count;
			}
		}
		
	}
	
}