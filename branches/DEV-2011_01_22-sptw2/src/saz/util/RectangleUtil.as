package saz.util {
	import flash.geom.*;
	/**
	 * Rectangleユーティリティー
	 * @author saz
	 */
	public class RectangleUtil {
		
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