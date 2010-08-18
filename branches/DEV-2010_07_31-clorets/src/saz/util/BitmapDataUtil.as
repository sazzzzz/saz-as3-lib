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
		
		/**
		 * BitmapDataからPointとBitmapDataの配列を作る。
		 * @param	src
		 * @param	size
		 * @return
		 */
		static public function createRectangleParticlesFromBitmapData(src:BitmapData, size:uint):Object {
			var sw:int = src.width;
			var sh:int = src.height;
			
			var c:int = Math.ceil(sw / size);
			var r:int = Math.ceil(sh / size);
			//var points:Array = new Array();
			//var bmps:Array = new Array();
			var points:Array = new Array(c * r);
			var bmps:Array = new Array(c * r);
			trace("c, r, c * r", c, r, c * r);
			
			var index:int = 0;
			var bmp:BitmapData;
			var np:Point = new Point();
			var rect:Rectangle = new Rectangle(0,0,size,size);
			
			do {
				rect.x = 0;
				rect.height = (rect.y + size < sh) ? size : sh - rect.y;
				
				do {
					points[index] = new Point(rect.x, rect.y);
					rect.width = (rect.x + size < sw) ? size : sw - rect.x;
					bmp = new BitmapData(rect.width, rect.height);
					bmps[index] = bmp;
					bmp.copyPixels(src, rect, np);
					//trace(rect);
					
					index++;
					rect.x += size;
				}while (rect.x < sw)
				
				rect.y += size;
			}while (rect.y < sh)
			
			return { points:points, bmps:bmps };
		}
		/*static public function createRectangleParticlesFromBitmapData(src:BitmapData, size:uint):Object {
			var sw:int = src.width;
			var sh:int = src.height;
			
			var c:int = Math.ceil(sw / size);
			var r:int = Math.ceil(sh / size);
			//var points:Array = new Array();
			//var bmps:Array = new Array();
			var points:Array = new Array(c * r);
			var bmps:Array = new Array(c * r);
			trace("c, r, c * r", c, r, c * r);
			
			var index:int = 0;
			//var x:int = 0;
			//var y:int = 0;
			//var w:int, h:int;
			var row:Object;
			var bmp:BitmapData;
			var np:Point = new Point();
			var rect:Rectangle = new Rectangle(0,0,size,size);
			
			do {
				//x = 0;
				//h = (y + size < sh) ? size : sh - y;
				rect.x = 0;
				rect.height = (rect.y + size < sh) ? size : sh - rect.y;
				
				do {
					//points[index] = new Point(x, y);
					points[index] = new Point(rect.x, rect.y);
					rect.width = (rect.x + size < sw) ? size : sw - rect.x;
					if (x + size < sw) {
						//通常サイズ
						rect.width = size;
						bmp = new BitmapData(size, h);
					}else {
						//端切れ
						rect.width = sw - x;
						bmp = new BitmapData(sw - x, h);
					}
					bmp = new BitmapData(rect.width, rect.height);
					bmps[index] = bmp;
					bmp.copyPixels(src, rect, np);
					//trace(rect);
					
					index++;
					//x += size;
					rect.x += size;
				}while (rect.x < sw)
				
				//y += size;
				rect.y += size;
			}while (rect.y < sh)
			
			return { points:points, bmps:bmps };
		}*/
		
		
		
		/**
		 * BitmapDataをきれいに縮小し、新しいBitmapDataインスタンスを返す。段階的に縮小。
		 * @param	src	BitmapData
		 * @param	width	縮小後の横幅。
		 * @param	height	縮小後の高さ。
		 * @param	smoothing	（オプション）スムージング。
		 * @return
		 */
		static public function reduce(src:BitmapData, width:int, height:int, smoothing:Boolean = true):BitmapData {
			var res:BitmapData;
			var bmp1:BitmapData, bmp2:BitmapData;
			var last:BitmapData;
			
			bmp1 = src.clone();
			bmp2 = new BitmapData(Math.ceil(src.width / 2), Math.ceil(src.height / 2), false, 0);
			
			var mtx:Matrix = new Matrix();
			var w:Number = src.width;
			var h:Number = src.height;
			var nw:Number = src.width;
			var nh:Number = src.height;
			var count:int = -1;
			while (w > width * 2 && h > height * 2) {
				count++;
				if (w > width * 2) nw = Math.ceil(w / 2);
				if (h > height * 2) nh = Math.ceil(h / 2);
				mtx.identity();
				mtx.scale(nw / w, nh / h);
				if (count % 2 == 0) {
					bmp2.draw(bmp1, mtx, null, null, null, smoothing);
				}else {
					bmp1.draw(bmp2, mtx, null, null, null, smoothing);
				}
				w = nw;
				h = nh;
				//trace(w, h);
			}
			last = (count % 2 == 0)?bmp2:bmp1;
			
			res = new BitmapData(width, height);
			mtx.identity();
			mtx.scale(width / w, height / h);
			res.draw(last, mtx, null, null, null, smoothing);
			bmp1.dispose();
			bmp2.dispose();
			//trace(res.width, res.height);
			return res;
		}
		
		/**
		 * BitmapDataをタイルパターンとして塗りつぶす。
		 * @param	dst	塗りつぶすBitmapData。
		 * @param	src	タイルパターンとして使用するBitmapData。
		 */
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
		 * MovieClipからBitmapDataに変換。
		 * 出力bmpサイズを自動で取得してくれるけど、いらなくね。
		 * @param	target	対象DisplayObject。
		 * @return
		 */
		public static function mcToBmp(target:DisplayObject):BitmapData {
			var clipRect:Rectangle = $detectDisplayRect(target);
			return $mcToBmp(target, clipRect);
		}
		
		
		
		//FIXME	開発中
		/**
		 * MovieClipからBitmapDataに変換。
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
		
		
		
		
		public static function getNewPoint():Point {
			if ($newPoint == null)$newPoint = new Point();
			return $newPoint;
		}
		
		public static function getNewRectangle():Rectangle {
			if ($newRectangle == null)$newRectangle = new Rectangle();
			return $newRectangle;
		}
		
		public static function getNewMatrix():Matrix {
			if ($newMatrix == null)$newMatrix = new Matrix();
			return $newMatrix;
		}
		
		public static function getNewColorTransform():ColorTransform {
			if ($newColorTransform == null)$newColorTransform = new ColorTransform();
			return $newColorTransform;
		}
		
	}
	
}