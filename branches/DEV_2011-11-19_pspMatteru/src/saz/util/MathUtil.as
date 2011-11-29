package saz.util {
	/**
	 * ...
	 * @author saz
	 */
	public class MathUtil {
		
		static private const _D2R:Number = Math.PI / 180;
		/**
		 * 角度からラジアン. 
		 * @param	degree
		 * @return
		 */
		static public function degreeToRadian(degree:Number):Number {
			return degree * _D2R;
		}
		
		
		static private const _R2D:Number = 180 / Math.PI;
		/**
		 * ラジアンから角度. 
		 * @param	radian
		 * @return
		 */
		static public function radianToDegree(radian:Number):Number {
			return radian * _R2D;
		}
		
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  http://clockmaker.jp/blog/2009/11/wonderfl-optimize/
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 絶対値. 高速版. 
		 * @param	value
		 * @return
		 * @see	http://wonderfl.net/c/vDJ2/
		 */
		static public function abs(value:Number):Number {
			return (0 < value) ? value : -value;
		}
		
		/**
		 * 大きいほうの値を返す. 高速版. 
		 * @param	num1
		 * @param	num2
		 * @return
		 * @see	http://wonderfl.net/c/vDJ2/
		 */
		static public function max(num1:Number, num2:Number):Number {
			(num2 < num1) ? num1 : num2;
		}
		
		/**
		 * 小さいほうの値を返す. 高速版. 
		 * @param	num1
		 * @param	num2
		 * @return
		 * @see	http://wonderfl.net/c/vDJ2/
		 */
		static public function max(num1:Number, num2:Number):Number {
			(num2 > num1) ? num1 : num2;
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  以下
		// http://actionscript.g.hatena.ne.jp/ConquestArrow/20070621/1182359767 より
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------
		// 以下テストしてない
		//--------------------------------------
		
		/**
		 * 
		 * @param	value
		 * @return
		 * 
		 * @see	http://actionscript.g.hatena.ne.jp/ConquestArrow/20070621/1182359767
		 */
		//static public function abs(value:Number):Number {
			//return (value ^ (value >> 31)) - (value >> 31);
		//}
		
		/**
		 * intの符号が一致するかどうか. 
		 * @param	a
		 * @param	b
		 * @return
		 * 
		 * @see	http://actionscript.g.hatena.ne.jp/ConquestArrow/20070621/1182359767
		 */
		static public function equalSignInt(a:int, b:int):Boolean {
			return a ^ b >= 0;
		}
		
	}

}