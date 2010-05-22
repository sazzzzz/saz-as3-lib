﻿package saz.util {
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class DisplayUtil {
		
		/**
		 * RGB値およびアルファ値から、ColorTransformを生成
		 * @param	rgb	0xff0000など。
		 * @param	alpha
		 * @return	ColorTransformインスタンス
		 * 
		 * @example <listing version="3.0" >
		 * // ColorTransform インスタンスを作成します。
		 * var color:ColorTransform = DisplayUtil.createColorTransform(0xff0000, 0.5);
		 * 
		 * // MovieClipに適用
		 * mc.transform.colorTransform = color;
		 * </listing>
		 * 
		 * @see	http://level0.kayac.com/2009/06/colortransform.php
		 * @see	http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7fd1.html#WS5b3ccc516d4fbf351e63e3d118a9b90204-7f6c
		 */
		public static function createColorTransform( rgb:int, alpha:Number = 1 ):ColorTransform {
			var k:Number = 1.0 - alpha;
			var red:Number = (rgb >> 16 & 0xFF) * alpha;
			var green:Number = (rgb >> 8 & 0xFF) * alpha;
			var blue:Number = (rgb & 0xFF) * alpha;
			return new ColorTransform( k, k, k, 1, red, green, blue, 0 );
		}
		/*public static function createColorTransform( rgb:int, alpha:Number = 1 ):ColorTransform {
			var k:Number = 1.0 - alpha;
			var red:Number = rgb >> 16 & 0xFF *alpha;
			var green:Number = rgb >> 8 & 0xFF *alpha;
			var blue:Number = rgb & 0xFF * alpha;
			return new ColorTransform( k, k, k, 1, red, green, blue );
		}*/
		
		/**
		 * 着色する
		 * @deprecated	createColorTransform()を使えや
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