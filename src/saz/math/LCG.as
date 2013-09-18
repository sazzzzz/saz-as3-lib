package saz.math
{
	/**
	 * 線形合同法で擬似乱数を生成する。
	 * 同じシード値を指定すれば、必ず同じ（擬似）乱数が生成される。
	 * @author saz
	 * 
	 */
	public class LCG
	{
		public static const MAX_VALUE:uint = 32767;
		
		private var value:uint = 1;
		
		/**
		 * コンストラクタ。
		 * 
		 * @param seed	乱数のシード値。
		 * 
		 * @see	http://www.sousakuba.com/weblabo/actionscript-linear-random.html
		 * 
		 * @example サンプルコード:
		 * <listing version="3.0">
		 * var lcg:LCG = new LCG(1);
		 * var rnd:Number = lcg.nextNumber();
		 * </listing>
		 */
		
		public function LCG(seed:int)
		{
			value = seed;
		}
		
		/**
		 * 乱数を生成する。0～32767のint。
		 * @return 
		 * 
		 */
		public function nextInt():int
		{
			value = ( 214013 * value + 2531011 );
			return ( ( value >> 16 ) & MAX_VALUE );
		}
		
		/**
		 * 乱数を生成し、0～1のNumberに変換。
		 * @return 
		 * 
		 */
		public function nextNumber():Number
		{
			return nextInt() / (MAX_VALUE + 1);
		}
	}
}