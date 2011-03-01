package saz.util {
	import flash.geom.*;
	/**
	 * Geomユーティリティー
	 * @author saz
	 */
	public class GeomUtil {
		
		//--------------------------------------
		// BitmapDataUtilから移動
		//--------------------------------------
		static private var $newPoint:Point;
		static private var $newRectangle:Rectangle;
		static private var $newMatrix:Matrix;
		static private var $newColorTransform:ColorTransform;
		
		
		/**
		 * createTransformMatrixの簡略版. 
		 * @param	srcWidth
		 * @param	srcHeight
		 * @param	dstWidth
		 * @param	dstHeight
		 * @return
		 */
		static public function createScaleMatrix(srcWidth:Number, srcHeight:Number, dstWidth:Number, dstHeight:Number):Matrix {
			return createTransformMatrix(
				getNewPoint(), new Point(srcWidth, 0), new Point(0, srcHeight), getNewPoint(), new Point(dstWidth, 0), new Point(0, dstHeight)
			);
		}
		
		/**
		 * 座標変換用Matrixをつくる
		 * @param	a0
		 * @param	a1
		 * @param	a2
		 * @param	b0
		 * @param	b1
		 * @param	b2
		 * @return
		 * @see	http://www.d-project.com/flex/009_FreeTransform/
		 */
		static public function createTransformMatrix(a0:Point, a1:Point, a2:Point, b0:Point, b1:Point, b2:Point):Matrix {
			
			var ma : Matrix = new Matrix(
				a1.x - a0.x, a1.y - a0.y,
				a2.x - a0.x, a2.y - a0.y);
			ma.invert();
			
			var mb : Matrix = new Matrix(
				b1.x - b0.x, b1.y - b0.y,
				b2.x - b0.x, b2.y - b0.y);
			
			var m : Matrix = new Matrix();
			
			// O(原点)へ移動 
			m.translate(-a0.x, -a0.y);
			
			// 単位行列に変換(aの座標系の逆行列)
			m.concat(ma);
			
			// bの座標系に変換 
			m.concat(mb);
			
			// b0へ移動 
			m.translate(b0.x, b0.y);
			
			return m;
		}
		
		
		
		/**
		 * targetのx,yをコピーしたPointを生成。
		 * @param	rect
		 * @return
		 */
		static public function getPoint(target:Object):Point {
			return new Point(target.x, target.y);
		}
		
		
		
		
		
		
		
		/**
		 * ベクトルを正規化. 向きはそのままで、長さ1にしたベクトルを返す.
		 * Point.nomalize()を使えよ！
		 * @param	point
		 * @return
		 */
		static public function normalizeVector(x:Number, y:Number):Point {
			var len:Number = Math.sqrt((x * x) + (y * y));
			return new Point(
				x / len, y / len
			);
		}
		
		
		
		
		
		/**
		 * x,y,width,heightを持つObjectから、プロパティをコピーしたRectangleを生成。
		 * @param	obj
		 * @return
		 */
		/*static public function objectToRectangle(obj:Object):Rectangle {
			return new Rectangle(obj.x, obj.y, obj.width, obj.height);
		}*/
		
		static public var objectToRectangle:Function = getRectangle;
		
		/**
		 * targetのx,y,width,heightをコピーしたRectangleを生成。
		 * @param	target
		 * @return
		 */
		static public function getRectangle(target:Object):Rectangle {
			return new Rectangle(
				target.x
				,target.y
				,target.width
				,target.height
			);
		}
		
		/**
		 * targetのx,y,width,heightをRectangleで指定。
		 * @param	target
		 * @param	rect
		 */
		static public function setRectangle(target:Object, rect:Rectangle):void {
			target.x = rect.x;
			target.y = rect.y;
			target.width = rect.width;
			target.height = rect.height;
		}
		
		
		
		//--------------------------------------
		// LAYOUT
		//--------------------------------------
		
		
		/**
		 * 横方向センタリングするためのX座標を返す。
		 * @param	target	センタリングする対象Rectangle。
		 * @param	base	基準とするRectangle。
		 * @return
		 */
		static public function getAlignCenterX(target:Rectangle, base:Rectangle):Number {
			return base.x + (base.width - target.width) / 2;
		}
		
		/**
		 * 縦方向センタリングするためのY座標を返す。
		 * @param	target	センタリングする対象Rectangle。
		 * @param	base	基準とするRectangle。
		 * @return
		 */
		static public function getAlignMiddleY(target:Rectangle, base:Rectangle):Number {
			return base.y + (base.height - target.height) / 2;
		}
		
		
		
		
		/**
		 * 横方向で真ん中ぞろえにする。
		 * @param	target	対象のRectangle。これを直接変更するので注意。
		 * @param	base	基準とするRectangle。
		 */
		public static function alignRectangleToCenter(target:Rectangle, base:Rectangle):void {
			target.y = getAlignCenterX(target, base);
		}
		
		
		static public var alignMiddle:Function = alignRectangleToMiddle;
		static public var alignMiddleArray:Function = alignRectanglesToMiddle;
		
		/**
		 * 高さ方向で真ん中ぞろえにする。
		 * @param	target	対象のRectangle。これを直接変更するので注意。
		 * @param	base	基準とするRectangle。
		 */
		//public static function alignMiddle(target:Rectangle, base:Rectangle):void {
		public static function alignRectangleToMiddle(target:Rectangle, base:Rectangle):void {
			target.y = getAlignMiddleY(target, base);
		}
		
		/**
		 * Rectangle配列を、高さ方向で真ん中ぞろえにする。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 */
		//public static function alignMiddleArray(rectList:/*Rectangle*/Array):void {
		public static function alignRectanglesToMiddle(rectList:/*Rectangle*/Array):void {
			var baseRect:Rectangle = unionArray(rectList);
			for (var i:int = 0, len:int = rectList.length, item:Rectangle; i < len; i++) {
				item = rectList[i];
				alignMiddle(item, baseRect);
			}
		}
		
		
		static public var centering:Function = getCenteringPoint;
		
		/**
		 * Rectangleをセンタリングするための座標を返す。
		 * @param	target	対象のRectangle。
		 * @param	base	基準とするRectangle。
		 * @return	baseに対してtargetをセンタリングした座標。
		 */
		//static public function centering(target:Rectangle, base:Rectangle):Point {
		static public function getCenteringPoint(target:Rectangle, base:Rectangle):Point {
			//return new Point(base.x + (base.width - target.width) / 2, base.y + (base.height - target.height) / 2);
			return new Point(getAlignCenterX(target, base), getAlignMiddleY(target, base));
		}
		
		
		
		
		
		
		static public var arrangeFromLeftArray:Function = arrangeRectanglesFromLeft;
		static public var arrangeFromRightArray:Function = arrangeRectanglesFromRight;
		
		/**
		 * Rectangle配列を、左から順に並べる。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 * @param	left	開始位置。
		 * @param	margin	マージン。
		 */
		//public static function arrangeFromLeftArray(rectList:/*Rectangle*/Array, left:Number = 0, margin:Number = 0):void {
		public static function arrangeRectanglesFromLeft(rectList:/*Rectangle*/Array, left:Number = 0, margin:Number = 0):void {
			var prev:Number = left;
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				item.x = prev;
				prev += item.width + margin;
			});
		}
		
		/**
		 * Rectangle配列を、右から順に並べる。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 * @param	right	開始位置。
		 * @param	margin	マージン。
		 */
		//public static function arrangeFromRightArray(rectList:/*Rectangle*/Array, right:Number = 0, margin:Number = 0):void {
		public static function arrangeRectanglesFromRight(rectList:/*Rectangle*/Array, right:Number = 0, margin:Number = 0):void {
			var prev:Number = right;
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				item.x = prev - item.width;
				prev -= item.width + margin;
			});
		}
		
		
		
		
		
		
		static public var innterFit:Function = inscribe;
		static public var outerFit:Function = circumscribe;
		
		/**
		 * targetの縦横比で、frameに内接するRectangleを返す。
		 * @param	target	対象Rectangle。
		 * @param	frame	枠Rectangle。
		 * @return
		 */
		static public function inscribe(target:Rectangle, frame:Rectangle):Rectangle {
			var scale:Number = (target.width / target.height < frame.width / frame.height)? frame.height / target.height : frame.width / target.width;
			return fit(target, frame, scale);
		}
		
		/**
		 * targetの縦横比で、frameに外接するRectangleを返す。
		 * @param	target	対象Rectangle。
		 * @param	frame	枠Rectangle。
		 * @return
		 */
		static public function circumscribe(target:Rectangle, frame:Rectangle):Rectangle {
			var scale:Number = (target.width / target.height > frame.width / frame.height)? frame.height / target.height : frame.width / target.width;
			return fit(target, frame, scale);
		}
		
		
		/**
		 * targetを、指定倍率でリサイズした上、base基準にセンタリング。
		 * @param	target	対象Rectangle。
		 * @param	base	基準とするRectangle。
		 * @param	scale	倍率。
		 * @return
		 */
		static public function fit(target:Rectangle, base:Rectangle, scale:Number):Rectangle {
			// inscribeとcircumscribeから使われている
			return new Rectangle(
				base.x - Math.round((target.width * scale-base.width) / 2)
				,base.y - Math.round((target.height * scale-base.height) / 2)
				,target.width * scale
				,target.height * scale
			);
		}
		
		
		
		
		static public var unionArray:Function = unionRectangles;
		
		/**
		 * 配列で指定されたRectangleすべてを内包するRectangleを返す。
		 * @param	rectList	対象のRectangle配列。
		 * @return
		 */
		//public static function unionArray(rectList:/*Rectangle*/Array):Rectangle {
		public static function unionRectangles(rectList:/*Rectangle*/Array):Rectangle {
			var res:Rectangle = new Rectangle();
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				res = res.union(item);
			});
			return res;
		}
		
		
		
		
		
		//--------------------------------------
		// BitmapDataUtilから移動
		//--------------------------------------
		
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