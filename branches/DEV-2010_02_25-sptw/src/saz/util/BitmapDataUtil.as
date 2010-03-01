package saz.util {
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * ぜんぜん途中です。
	 * @author saz
	 */
	public class BitmapDataUtil {
		
		
		static private var $newPoint:Point;
		static private var $newRectangle:Rectangle;
		static private var $newMatrix:Matrix;
		static private var $newColorTransform:ColorTransform;
		
		
		
		public static function fillTexture(dst:BitmapData, src:BitmapData):void {
			var p:Point = new Point(0, 0);
			var sw:uint = src.width;
			var sh:uint = src.height;
			var dw:uint = dst.width;
			var dh:uint = dst.height;
			var rSize:uint = Math.floor(dst.height / src.height);
			var cSize:uint = Math.floor(dst.width / src.width);
			//if (rSize < 1 || cSize < 1) throw new Error();
			for (var r:int = 0; r <= rSize; r++) {
				for (var c:int = 0; c <= cSize; c++) {
					p.x = c * src.width;
					p.y = r * src.height;
					dst.copyPixels(src, src.rect, p);
				}
			}
		}
		
		
		/**
		 * MovieClipからBitmapDataに変換。出力bmpサイズを自動で取得してくれるよ。いらなくね。
		 * @param	target	対象DisplayObject。
		 * @return
		 */
		public static function mcToBmp(target:DisplayObject):BitmapData {
			var clipRect:Rectangle = $detectDisplayRect(target);
			return $mcToBmp(target, clipRect);
		}
		
		/**
		 * MovieClipからBitmapDataに変換。
		 * 開発中
		 * @param	target
		 * @param	clipRect	（オプション）切り取る範囲を指定するRectangleインスタンス。省略した場合、範囲は自動で決定。開発中！
		 * @return
		 */
		/*public static function mcToBmpClip(target:DisplayObject, clipRect:Rectangle = null):BitmapData {
			if (clipRect == null) {
				clipRect = $detectDisplayRect(target);
			}
			return $mcToBmpClip(target, clipRect);
		}*/
		
		private static function $detectDisplayRect(target:DisplayObject):Rectangle{
			return target.getBounds(target.parent);
		}
		
		/**
		 * MovieClipからBitmapDataに変換。
		 * サイズ指定自動。ただし、MC原点から右下方向しか取れない。
		 * @param	target	対象MovieClip。
		 * @return
		 */
		/*private static function $mcToBmp(target:DisplayObject):BitmapData {
			var bounds:Object = target.getBounds(target.parent);
			//原点より右下方向にない。
			if (bounds.xMax < 0 | bounds.yMax < 0) return;
			
			return $mcToBmpClip(target, new Rectangle(0, 0, bounds.xMax, bounds.yMax));
		}*/
		
		/**
		 * 範囲指定して、MovieClipからBitmapDataに変換。
		 * @param	target	対象MovieClip。
		 * @param	clipRect	切り取る範囲を指定するRectangleインスタンス。
		 * @return
		 */
		private static function $mcToBmpClip(target:DisplayObject, clipRect:Rectangle):BitmapData {
			trace("BitmapDataUtil.$mcToBmpClip(" + arguments);
			var bmp:BitmapData = new BitmapData(clipRect.width, clipRect.height, true, 0);
			trace(bmp);
			bmp.draw(target, getNewMatrix(), getNewColorTransform(), null, clipRect);
			return bmp;
		}
		
		private static function $mcToBmp(target:DisplayObject, clipRect:Rectangle):BitmapData {
			var bmp:BitmapData = new BitmapData(clipRect.width, clipRect.height, true, 0);
			bmp.draw(target);
			return bmp;
		}
		
		
		static function getNewPoint():Point {
			if ($newPoint == null)$newPoint = new Point();
			return $newPoint;
		}
		
		static function getNewRectangle():Rectangle {
			if ($newRectangle == null)$newRectangle = new Rectangle();
			return $newRectangle;
		}
		
		static function getNewMatrix():Matrix {
			if ($newMatrix == null)$newMatrix = new Matrix();
			return $newMatrix;
		}
		
		static function getNewColorTransform():ColorTransform {
			if ($newColorTransform == null)$newColorTransform = new ColorTransform();
			return $newColorTransform;
		}
		
	}
	
}