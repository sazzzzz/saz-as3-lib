package saz.math
{
	import flash.geom.Vector3D;

	public class PerlinNoise3D extends PerlinNoise1D
	{
		
		public static function noise(x:Number, y:Number, z:Number):Number
		{
			var X:int = Math.floor(x) as int;
			var Y:int = Math.floor(y) as int;
			var Z:int = Math.floor(z) as int;
			x -= Math.floor(x);
			y -= Math.floor(y);
			z -= Math.floor(z);
			var u:Number = fade(x);
			var v:Number = fade(y);
			var w:Number = fade(z);
			var A :int = perm[X  ] + Y;
			var B :int = perm[X+1] + Y;
			var AA:int = perm[A  ] + Z;
			var BA:int = perm[B  ] + Z;
			var AB:int = perm[A+1] + Z;
			var BB:int = perm[B+1] + Z;
			
			return lerp(w, lerp(v, lerp(u, grad(perm[AA  ], x  , y  , z   ),
										   grad(perm[BA  ], x-1, y  , z   )),
								   lerp(u, grad(perm[AB  ], x  , y-1, z   ),
										   grad(perm[BB  ], x-1, y-1, z   ))),
						   lerp(v, lerp(u, grad(perm[AA+1], x  , y  , z-1 ),
										   grad(perm[BA+1], x-1, y  , z-1 )),
								   lerp(u, grad(perm[AB+1], x  , y-1, z-1 ),
										   grad(perm[BB+1], x-1, y-1, z-1 ))));
		}
		
		/**
		 * Fractional Brownian motion（非整数ブラウン運動）関数.
		 * @param x
		 * @param y
		 * @param z
		 * @param octave
		 * @return 
		 * 
		 */
		public static function fbm(x:Number, y:Number, z:Number, octave:int):Number
		{
			var f:Number = 0.0;
			var w:Number = 0.5;
			var coord:Vector3D = new Vector3D(x, y, z);
			for (var i:int = 0; i < octave; i++) 
			{
				f += w * noise(coord.x, coord.y, coord.z);
				coord.scaleBy(2.0);
				w *= 0.5;
			}
			return f;
		}
		
		
		private static function grad(hash : int, x : Number, y : Number, z:Number):Number
		{
			var h:int = hash & 15;
			var u:Number = h < 8 ? x : y;
			var v:Number = h < 4 ? y : (h == 12 || h == 14 ? x : z);
			return ((h & 1) ? u : -u) + ((h & 2) ? v : -v);
		}		
	}
}