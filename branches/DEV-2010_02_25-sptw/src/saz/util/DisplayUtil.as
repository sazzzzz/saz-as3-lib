package saz.util {
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class DisplayUtil {
		
		/**
		 * 着色する
		 * @param	target
		 * @param	rgb
		 * @param	alpha
		 */
		public static function setRGB(target:DisplayObject, rgb:int, alpha:Number = 1):void {
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = rgb;
			colorTrans.alphaMultiplier = alpha;
			target.transform.colorTransform = colorTrans;
		}
		
	}
	
}