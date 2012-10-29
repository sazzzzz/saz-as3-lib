package saz.math
{
	import flash.geom.Point;

	/**
	 * パーリンノイズ2D. 
	 * @author saz
	 * 
	 */
	public class PerlinNoise2D extends PerlinNoise1D
	{
		
		public static function noise(x:Number, y:Number):Number
		{
			var X:int = Math.floor(x) as int;
			var Y:int = Math.floor(y) as int;
			x -= Math.floor(x);
			y -= Math.floor(y);
			var u:Number = fade(x);
			var v:Number = fade(y);
			var A:int = perm[X  ] + Y;
			var B:int = perm[X+1] + Y;
			return lerp(v, lerp(u, grad(perm[A  ], x,   y  ),
								   grad(perm[B  ], x-1, y  )),
						   lerp(u, grad(perm[A+1], x,   y-1),
							   	   grad(perm[B+1], x-1, y-1)));
		}
		
		/**
		 * Fractional Brownian motion（非整数ブラウン運動）関数.
		 * @param x
		 * @param y
		 * @param octave
		 * @return 
		 * 
		 */
		public static function fbm(x:Number, y:Number, octave:int):Number
		{
			var f:Number = 0.0;
			var w:Number = 0.5;
			var coord:Point = new Point(x, y);
			for (var i:int = 0; i < octave; i++) 
			{
				f += w * noise(coord.x, coord.y);
				coord.normalize(coord.length * 2.0);
				w *= 0.5;
			}
			return f;
		}
		
		
		private static function grad(hash : int, x : Number, y : Number):Number
		{
			return ((hash & 1) ? x : -x) + ((hash & 2) ? y : -y);
		}		
	}
}