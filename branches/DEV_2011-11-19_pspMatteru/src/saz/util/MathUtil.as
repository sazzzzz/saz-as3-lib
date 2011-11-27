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
		
	}

}