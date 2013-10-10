package saz.math
{
	/**
	 * パーリンノイズ. 
	 * https://github.com/keijiro/unity-perlin/blob/master/Assets/Perlin.js のベタ移植. 
	 * @author saz
	 * 
	 * @see	https://github.com/keijiro/unity-perlin/blob/master/Assets/Perlin.js
	 * @see	http://mrl.nyu.edu/~perlin/noise/
	 * @see	http://ja.wikipedia.org/wiki/%E9%9D%9E%E6%95%B4%E6%95%B0%E3%83%96%E3%83%A9%E3%82%A6%E3%83%B3%E9%81%8B%E5%8B%95
	 */
	public class PerlinNoise1D
	{
		
		/**
		 * パーリンノイズ. 
		 * @param x
		 * @return 
		 * 
		 */
		public static function noise(x:Number):Number
		{
			var X:int = Math.floor(x) as int;
			x -= Math.floor(x);
			var u:Number = fade(x);
			return lerp(u, (perm[X  ] & 1) ? x     :    -x,
						   (perm[X+1] & 1) ? x-1.0 : 1.0-x);
		}
		
		/**
		 * Fractional Brownian motion（非整数ブラウン運動）関数.
		 * ・0 付近を行ったり来たりする。
		 * ・大きな動きと小さな動きがまんべんなく混ざっている。
		 * ・どの時点を切り出しても、同じようなランダムな動きをする。
		 * ・連続性がある（値が飛んだりしない）。
		 * @param x			元になる値。0.001ぐらいずつ変化させると良さ気。
		 * @param octave	不明。どうやら大きいほうがなめらかになる？http://blog.livedoor.jp/toropippi/archives/91389.html
		 * @return 最大値はよくわからない。
		 * 
		 */
		public static function fbm(x:Number, octave:int):Number
		{
			var f:Number = 0.0;
			var w:Number = 0.5;
			for (var i:int = 0; i < octave; i++) 
			{
				f += w * noise(x);
				x *= 2.0;
				w *= 0.5;
			}
			return f;
		}
		
		/*private static function grad(hash:int, x:Number, y:Number):Number
		{
			return 0;
		}*/
		
		
		//
		// common
		//
		
		protected static function fade(t:Number):Number
		{
			return t * t * t * (t * (t * 6 - 15) + 10);
		}
		
		protected static function lerp(t:Number, a:Number, b:Number):Number
		{
			return a + t * (b - a);
		}
		
		
		protected static var perm:Array = [151,160,137,91,90,15,
			131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
			190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
			88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
			77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
			102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
			135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
			5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
			223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
			129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
			251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
			49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
			138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,
			151];
		
	}
}