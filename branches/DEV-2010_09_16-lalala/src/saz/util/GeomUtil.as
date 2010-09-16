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
		
		/**
		 * x,y,width,heightを持つObjectから、プロパティをコピーしたRectangleを生成。
		 * @param	obj
		 * @return
		 */
		static public function objectToRectangle(obj:Object):Rectangle {
			return new Rectangle(obj.x, obj.y, obj.width, obj.height);
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
		
		/**
		 * targetからRectangleを返す。
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
		 * baseに対してtargetをセンタリングする。
		 * @param	target
		 * @param	base
		 * @return
		 */
		static public function centering(target:Rectangle, base:Rectangle):Point {
			return new Point(base.x + (base.width - target.width) / 2, base.y + (base.height - target.height) / 2);
		}
		
		static public var innterFit:Function = inscribe;
		static public var outerFit:Function = circumscribe;
		
		/**
		 * targetの縦横比で、frameに内接するRectangleを返す。
		 * @param	target	
		 * @param	frame	
		 * @return
		 */
		static public function inscribe(target:Rectangle, frame:Rectangle):Rectangle {
			var scale:Number = (target.width / target.height < frame.width / frame.height)? frame.height / target.height : frame.width / target.width;
			return fit(target, frame, scale);
		}
		
		/**
		 * targetの縦横比で、frameに外接するRectangleを返す。
		 * @param	target	
		 * @param	frame	
		 * @return
		 */
		static public function circumscribe(target:Rectangle, frame:Rectangle):Rectangle {
			//var srcScale:Number = target.width / target.height;
			//var frameScale:Number = frame.width / frame.height;
			//var scale:Number = (srcScale > frameScale)? frame.height / target.height : frame.width / target.width;
			var scale:Number = (target.width / target.height > frame.width / frame.height)? frame.height / target.height : frame.width / target.width;
			return fit(target, frame, scale);
		}
		
		static public function fit(target:Rectangle, frame:Rectangle, scale:Number):Rectangle {
			return new Rectangle(
				frame.x - Math.round((target.width * scale-frame.width) / 2)
				,frame.y - Math.round((target.height * scale-frame.height) / 2)
				,target.width * scale
				,target.height * scale
			);
		}
		
		
		/**
		 * Rectangle配列を、左から順に並べる。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 * @param	left	開始位置。
		 * @param	margin	マージン。
		 */
		public static function arrangeFromLeftArray(rectList:/*Rectangle*/Array, left:Number = 0, margin:Number = 0):void {
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
		public static function arrangeFromRightArray(rectList:/*Rectangle*/Array, right:Number = 0, margin:Number = 0):void {
			var prev:Number = right;
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				item.x = prev - item.width;
				prev -= item.width + margin;
			});
		}
		
		/**
		 * Rectangle配列を、高さ方向で真ん中ぞろえにする。
		 * @param	rectList	対象のRectangle配列。これを直接変更するので注意。
		 */
		public static function alignMiddleArray(rectList:/*Rectangle*/Array):void {
			var baseRect:Rectangle = unionArray(rectList);
			for (var i:int = 0, len:int = rectList.length, item:Rectangle; i < len; i++) {
				item = rectList[i];
				alignMiddle(item, baseRect);
			}
		}
		
		/**
		 * 高さ方向で真ん中ぞろえにする。
		 * @param	target	対象のRectangle。これを直接変更するので注意。
		 * @param	base	ベースとなるRectangle。
		 */
		public static function alignMiddle(target:Rectangle, base:Rectangle):void {
			target.y = (base.height - target.height) / 2 + base.y;
		}
		
		/**
		 * 配列で指定されたRectangleすべてを内包するRectangleを返す。
		 * @param	rectList	対象のRectangle配列。
		 * @return
		 */
		public static function unionArray(rectList:/*Rectangle*/Array):Rectangle {
			var res:Rectangle = new Rectangle();
			rectList.forEach(function(item:*, index:int, arr:Array):void {
				res = res.union(item);
			});
			return res;
		}
		
	}

}