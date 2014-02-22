package saz.util {
	import flash.display.Stage;
	import flash.geom.*;

	/**
	 * Geomユーティリティー
	 * @author saz
	 */
	public class GeomUtil {
		
		
		
		/**
		 * 2つのPoint間の距離. Point.distance()の高速版. 
		 * @param	pt1
		 * @param	pt2
		 * @return
		 * @see	http://wonderfl.net/c/97BW/
		 */
		static public function distance(pt1:Point, pt2:Point):Number {
			var dx:Number = pt1.x - pt2.x;
			var dy:Number = pt1.y - pt2.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		
		
		
		
		
		
		
		
		
		
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
		public static function getPoint(target:Object):Point {
			return new Point(target.x, target.y);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * Rectangleの中心のX座標。
		 * @param rect
		 * @return 
		 * 
		 */
		public static function rectangleCenter(rect:Rectangle):Number
		{
			return rect.left + (rect.width / 2);
		}
		
		/**
		 * Rectangleの中心のY座標。
		 * @param rect
		 * @return 
		 * 
		 */
		public static function rectangleMiddle(rect:Rectangle):Number
		{
			return rect.top + (rect.height / 2);
		}
		
		
		/**
		 * 指定Rectangleを、中心点同じで指定サイズに変形する。
		 * @param rect
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */
		public static function rectangleInflate(target:Rectangle, width:Number, height:Number):void
		{
			target.inflate(
				(width - target.width) / 2, (height - target.height) / 2
			);
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
		public static function getAlignCenterX(target:Rectangle, base:Rectangle):Number {
			return base.x + (base.width - target.width) / 2;
		}
		
		/**
		 * 縦方向センタリングするためのY座標を返す。
		 * @param	target	センタリングする対象Rectangle。
		 * @param	base	基準とするRectangle。
		 * @return
		 */
		public static function getAlignMiddleY(target:Rectangle, base:Rectangle):Number {
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
		
		
		
		/**
		 * 高さ方向で真ん中ぞろえにする。
		 * @param	target	対象のRectangle。これを直接変更するので注意。
		 * @param	base	基準とするRectangle。
		 */
		public static function alignRectangleToMiddle(target:Rectangle, base:Rectangle):void {
			target.y = getAlignMiddleY(target, base);
		}
		/*public static var alignMiddle:Function = alignRectangleToMiddle;
		public static var alignMiddleArray:Function = alignRectanglesToMiddle;*/
		
		/**
		 * Rectangle配列を、高さ方向で真ん中ぞろえにする。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 */
		public static function alignRectanglesToMiddle(rectList:/*Rectangle*/Array):void {
			var baseRect:Rectangle = unionRectangles(rectList);
			for (var i:int = 0, len:int = rectList.length, item:Rectangle; i < len; i++) {
				item = rectList[i];
				alignRectangleToMiddle(item, baseRect);
			}
		}
		
		
		
		/**
		 * Rectangleをセンタリングするための座標を返す。
		 * @param	target	対象のRectangle。
		 * @param	base	基準とするRectangle。
		 * @return	baseに対してtargetをセンタリングした座標。
		 */
		public static function getCenteringPoint(target:Rectangle, base:Rectangle):Point {
			return new Point(getAlignCenterX(target, base), getAlignMiddleY(target, base));
		}
		/*public static var centering:Function = getCenteringPoint;*/
		
		
		
		
		
		
		
		/**
		 * Rectangle配列を、左から順に並べる。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 * @param	left	開始位置。
		 * @param	margin	マージン。
		 */
		public static function arrangeRectanglesFromLeft(rectList:/*Rectangle*/Array, left:Number = 0, margin:Number = 0):void {
			var prev:Number = left;
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				item.x = prev;
				prev += item.width + margin;
			});
		}
		/*public static var arrangeFromLeftArray:Function = arrangeRectanglesFromLeft;*/
		
		/**
		 * Rectangle配列を、右から順に並べる。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 * @param	right	開始位置。
		 * @param	margin	マージン。
		 */
		public static function arrangeRectanglesFromRight(rectList:/*Rectangle*/Array, right:Number = 0, margin:Number = 0):void {
			var prev:Number = right;
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				item.x = prev - item.width;
				prev -= item.width + margin;
			});
		}
		/*public static var arrangeFromRightArray:Function = arrangeRectanglesFromRight;*/
		
		
		
		/**
		 * 内接するための比率を返す。
		 * @param targetW
		 * @param targetH
		 * @param frameW
		 * @param frameH
		 * @return 
		 * 
		 */
		public static function inscribeScale(targetW:Number, targetH:Number, frameW:Number, frameH:Number):Number
		{
			return (targetW / targetH < frameW / frameH) ? frameH / targetH : frameW / targetW;
		}
		
		/**
		 * 外接するための比率を返す。
		 * @param targetW
		 * @param targetH
		 * @param frameW
		 * @param frameH
		 * @return 
		 * 
		 */
		public static function circumscribeScale(targetW:Number, targetH:Number, frameW:Number, frameH:Number):Number
		{
			return (targetW / targetH > frameW / frameH) ? frameH / targetH : frameW / targetW;
		}
		
		
		
		/**
		 * 外接するための比率を、セーフエリアありで計算する。
		 * @param targetW
		 * @param targetH
		 * @param frameW
		 * @param frameH
		 * @param safe	セーフエリアを、対象のオリジナルサイズを1とした比率で指定。
		 * @return 
		 * 
		 */
		public static function circumscribeScaleWithSafeArea(targetW:Number, targetH:Number, frameW:Number, frameH:Number, safe:Number):Number
		{
			var cscale:Number = circumscribeScale(targetW, targetH, frameW, frameH);
			var wscale:Number = frameW / (targetW * safe);
			var hscale:Number = frameH / (targetH * safe);
			
			return Math.min(cscale, wscale, hscale);
		}
		
		
		
		/**
		 * targetの縦横比で、frameに内接するRectangleを返す。
		 * @param	target	対象Rectangle。
		 * @param	frame	枠Rectangle。
		 * @return
		 */
		public static function inscribeRect(target:Rectangle, frame:Rectangle):Rectangle {
			var scale:Number = inscribeScale(target.width, target.height, frame.width, frame.height);
			return fit(target, frame, scale);
		}
		/*public static var innterFit:Function = inscribeRect;
		public static var inscribe:Function = inscribeRect;*/
		
		
		
		/**
		 * targetの縦横比で、frameに外接するRectangleを返す。
		 * @param	target	対象Rectangle。
		 * @param	frame	枠Rectangle。
		 * @return
		 */
		public static function circumscribeRect(target:Rectangle, frame:Rectangle):Rectangle {
			var scale:Number = circumscribeScale(target.width, target.height, frame.width, frame.height);
			return fit(target, frame, scale);
		}
		/*public static var outerFit:Function = circumscribeRect;
		public static var circumscribe:Function = circumscribeRect;*/
		
		
		/**
		 * targetと同じ縦横比で、frameに外接するRectangleを、セーフエリアありで計算する。
		 * 
		 * @param target
		 * @param frame
		 * @param safe
		 * @return 
		 */
		public static function circumscribeRectWithSafeArea(target:Rectangle, frame:Rectangle, safe:Number):Rectangle {
			return fit(target, frame, circumscribeScaleWithSafeArea(target.width, target.height, frame.width, frame.height, safe));
		}
		
		
		
		/**
		 * targetを、指定倍率でリサイズした上、base基準にセンタリング。
		 * @param	target	対象Rectangle。
		 * @param	base	基準とするRectangle。
		 * @param	scale	倍率。
		 * @return
		 */
		public static function fit(target:Rectangle, base:Rectangle, scale:Number):Rectangle {
			// inscribeとcircumscribeから使われている
			return new Rectangle(
				base.x - Math.round((target.width * scale-base.width) / 2)
				,base.y - Math.round((target.height * scale-base.height) / 2)
				,target.width * scale
				,target.height * scale
			);
		}
		
		
		
		
		
		/**
		 * 配列で指定されたRectangleすべてを内包するRectangleを返す。
		 * @param	rectList	対象のRectangle配列。
		 * @return
		 */
		public static function unionRectangles(rectList:/*Rectangle*/Array):Rectangle {
			var res:Rectangle = new Rectangle();
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				res = res.union(item);
			});
			return res;
		}
		/*public static var unionArray:Function = unionRectangles;*/
		
		
		
		
		
		
		//--------------------------------------
		// 3D
		//--------------------------------------
		
		/**
		 * PerspectiveProjection.fieldOfViewを再計算する。
		 * 
		 * @param baseFov	ベースとなるfieldOfViewの値。
		 * @param baseDocWidth	ベースとなるドキュメント横幅の値。
		 * @param stage	Stage。
		 * @return 
		 * 
		 */
		public static function calcFieldOfView(baseFov:Number, baseDocWidth:Number, stage:Stage):Number
		{
			// どうもfieldOfViewは、横幅基準で決まるっぽい。
			// 122.4	@1920x1080	<--orginal
			// 91.3		@1080x1080
			// 88.2		@1024x1080
			// 84.5		@ 960x1080
			// 62.4		@ 640x 360
			
			/*var dis:Number = (baseDocWidth / 2) / Math.tan(MathUtil.degreeToRadian(baseFov / 2));
			var rad:Number = Math.atan2(stage.stageWidth / 2, dis);
			return MathUtil.radianToDegree(rad) * 2;*/
			return MathUtil.radianToDegree(Math.atan2(stage.stageWidth / 2, (baseDocWidth / 2) / Math.tan(MathUtil.degreeToRadian(baseFov / 2)))) * 2
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