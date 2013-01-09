package saz.util {
	import flash.display.*;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.*;
	
	/**
	 * ぜんぜん途中です。
	 * @author saz
	 */
	public class BitmapDataUtil {
		
		public static const VER9_MAX_SIZE:int = 2880;
		
		static private var $newPoint:Point;
		static private var $newRectangle:Rectangle;
		static private var $newMatrix:Matrix;
		static private var $newColorTransform:ColorTransform;
		
		// drawHistogram用テンポラリBitmdapData
		static private var $histogramTmp:BitmapData;
		
		/**
		 * ビットマップにフィルターを掛け、ぴったりのサイズにトリミングしたBitmapDataを返す. 
		 * @param	src	元画像. 
		 * @param	filter	フィルター. 
		 * @param	transparent	ビットマップイメージがピクセル単位の透明度をサポートするかどうか. デフォルト値は true です (透明).
		 * @param	fillColor	ビットマップイメージ領域を塗りつぶすのに使用する 32 ビット ARGB カラー値です。デフォルト値は 0xFFFFFFFF (白) です.
		 * @return
		 */
		public static function filterAndTrim(src:BitmapData, filter:BitmapFilter, transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF):BitmapData {
			var rect:Rectangle = src.generateFilterRect(src.rect, filter);
			var res:BitmapData = new BitmapData(rect.width, rect.height, transparent, fillColor);
			res.applyFilter(src, src.rect, new Point( -rect.x, -rect.y), filter);
			return res;
		}
		
		
		/**
		 * レベル補正. 
		 * @param	src	元画像
		 * @param	dst	出力先画像
		 * @param	shadow	シャドウ. 0～255. デフォルトは0.
		 * @param	middle	中間調（ガンマ）. 0～255. デフォルトは128.
		 * @param	hilite	ハイライト. 0～255. デフォルトは255.
		 * @see	http://d.hatena.ne.jp/nitoyon/20071009/as3_histogram3
		 */
		static public function applyLevels(src:BitmapData, dst:BitmapData, shadow:int = 0, middle:int = 128, hilite:int = 255):void {
			var gamma:Number = Math.log((middle - shadow) / (hilite - shadow)) / Math.log(0.5);
			var mapR:Array = [], mapG:Array = [], mapB:Array = [];
			for (var i:int = 0; i < 0x100; i++) {
				mapB[i] = i < shadow ? 0 : i > hilite ? 0xFF : 255 * Math.pow((i - shadow) / (hilite - shadow), 1 / gamma);
				mapG[i] = mapB[i] << 8;
				mapR[i] = mapB[i] << 16;
			}
			dst.paletteMap(src, src.rect, getNewPoint(), mapR, mapG, mapB);
		}
		
		
		
		/**
		 * ヒストグラムを描画する
		 * @param	bmp	対象となるBitmapData
		 * @param	graphics	描画する対象. 原点から右上方向に描画する. 
		 * @param	color	描画する色. デフォルトは0x000000. 
		 * @param	alpha	描画する際のアルファ. デフォルトは1.0. 
		 * @param	height	グラフの最大高さ. デフォルトは100. 
		 * @see	http://d.hatena.ne.jp/nitoyon/20071009/as3_histogram1
		 */
		static public function drawHistogram(bmp:BitmapData, graphics:Graphics, color:uint = 0x000000, alpha:Number = 1.0, height:int = 100):void {
			var values:Array = getHistogramData(bmp);
			//描画
			//var ratio:Number = height / max;
			var max:int = bmp.width * bmp.height / 50;
			graphics.lineStyle(1, color, alpha);
			var i:int, value:uint;
			for (i = 0; i < 0x100; i++) {
				graphics.moveTo(i, 0);
				graphics.lineTo(i, Math.max( -height, - values[i] / max * height));
			}
		}
		
		/**
		 * ヒストグラム用データを得る
		 * @param	bmp	対象となるBitmapData.
		 * @return	使用回数の配列.
		 */
		static public function getHistogramData(bmp:BitmapData):Array {
			var tmp:BitmapData = bmp.clone();
			//グレースケールに
			tmp.applyFilter(tmp, tmp.rect, getNewPoint(), new ColorMatrixFilter(
				[1 / 3, 1 / 3, 1 / 3, 0, 0,
				1 / 3, 1 / 3, 1 / 3, 0, 0,
				1 / 3, 1 / 3, 1 / 3, 0, 0,
				0, 0, 0, 1, 0]
			));
			//カウント
			var values:Array = new Array(0x100);
			var i:int, value:uint;
			for ( i = 0; i < 0x100; i++) {
				value = tmp.threshold(tmp, tmp.rect, getNewPoint(), "==", i, 0x000000, 0xFF, false);
				values[i] = value;
			}
			tmp.dispose();
			return values;
		}
		
		
		/**
		 * BitmapDataからPointとBitmapDataの配列を作る。
		 * @param	src
		 * @param	size
		 * @return
		 */
		public static function createRectangleParticlesFromBitmapData(src:BitmapData, size:uint):Object {
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
		/*public static function createRectangleParticlesFromBitmapData(src:BitmapData, size:uint):Object {
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
		public static function reduce(src:BitmapData, width:int, height:int, smoothing:Boolean = true):BitmapData {
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
		
		
		
		/**
		 * @deprecated	saz.util.GeomUtilへ移動。
		 */
		public static function getNewPoint():Point {
			if ($newPoint == null)$newPoint = new Point();
			return $newPoint;
		}
		
		/**
		 * @deprecated	saz.util.GeomUtilへ移動。
		 */
		public static function getNewRectangle():Rectangle {
			if ($newRectangle == null)$newRectangle = new Rectangle();
			return $newRectangle;
		}
		
		/**
		 * @deprecated	saz.util.GeomUtilへ移動。
		 */
		public static function getNewMatrix():Matrix {
			if ($newMatrix == null)$newMatrix = new Matrix();
			return $newMatrix;
		}
		
		/**
		 * @deprecated	saz.util.GeomUtilへ移動。
		 */
		public static function getNewColorTransform():ColorTransform {
			if ($newColorTransform == null)$newColorTransform = new ColorTransform();
			return $newColorTransform;
		}
		
	}
	
}