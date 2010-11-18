package saz.util {
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class DisplayUtil {
		
		/**
		 * 最小フレーム。
		 */
		static public const MIN_FRAME:int = 1;
		/**
		 * 最大フレーム数。
		 * @see	http://kb2.adobe.com/jp/cps/228/228626.html
		 */
		static public const MAX_FRAME:int = 16000 - 10;
		
		
		
		/**
		 * ドキュメントクラス（あるいはメインタイムライン）が、親SWFかどうかを返す。
		 * @param	target	調べたいドキュメントクラス（あるいはメインタイムライン）。
		 * @return	親SWFならtrue。
		 * @see	http://www.imajuk.com/blog/archives/2008/01/as3root_1.html
		 */
		static public function isRootDocument(document:DisplayObjectContainer):Boolean {
			return document.parent is Stage;
		}
		
		
		/**
		 * RGB値およびアルファ値から、ColorTransformを生成。
		 * バグの可能性。（createColorTransform(0x000000, 1 / 2)が期待通りにならない？）
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
			// FIXME	createColorTransform(0x000000, 1 / 2)が期待通りにならない。
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
		 * DisplayObject.transform.colorTransformをリセットする。
		 * @param	target
		 */
		public static function clearRGB(target:DisplayObject):void {
			var colorTrans:ColorTransform = new ColorTransform();
			target.transform.colorTransform = colorTrans;
		}
		
		/**
		 * 着色する。createColorTransform()を使えや。
		 * @param	target
		 * @param	rgb
		 * @param	alpha
		 * @deprecated	createColorTransform()を使えや。
		 */
		public static function setRGB(target:DisplayObject, rgb:int, alpha:Number = 1):void {
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = rgb;
			colorTrans.alphaMultiplier = alpha;
			target.transform.colorTransform = colorTrans;
		}
		
		
		/**
		 * DisplayObjectContainerの子用each。
		 * @param	target
		 * @param	iterator
		 * function(item:DisplayObject, index:int, collection:DisplayObjectContainer):void
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		static public function eachChildren(target:DisplayObjectContainer, iterator:Function):void {
			var num:int = target.numChildren;
			var item:DisplayObject;
			for (var i:int = 0; i < num; i++) {
				item = target.getChildAt(i);
				iterator(item, i, target);
			}
		}
		
		/**
		 * DisplayObjectContainerの子をArrayに。
		 * @param	target
		 * @return
		 */
		static public function childrenToArray(target:DisplayObjectContainer):Array {
			var res:Array = new Array();
			eachChildren(target, function(item:DisplayObject, index:int, collection:DisplayObjectContainer):void {
				res.push(item);
			});
			return res;
		}
		
		/**
		 * DisplayObjectContainerの子リストをStringに。ダンプ用。
		 * @param	target
		 * @param	iterator	（オプション）DisplayObject→String変換関数。
		 * @return
		 */
		static public function childrenToString(target:DisplayObjectContainer, iterator:Function = null):String {
			if (null == iterator) iterator = $childToString;
			var res:String = "";
			eachChildren(target, function(item:DisplayObject, index:int, collection:DisplayObjectContainer):void {
				res += iterator(item, index, collection);
			});
			return res;
		}
		
		/**
		 * childrenToString用デフォルト関数。
		 * @param	item
		 * @param	index
		 * @param	collection
		 * @return
		 */
		static public function $childToString(item:DisplayObject, index:int, collection:DisplayObjectContainer):String {
			return item.name + "\r";
		}
		
		/**
		 * DisplayObjectContainerの子リストをtrace。
		 * @param	target
		 */
		static public function dumpChildren(target:DisplayObjectContainer):void {
			trace(childrenToString(target, function(item:DisplayObject, index:int, collection:DisplayObjectContainer):String {
				return "[" + ObjectUtil.getClassName(item) + "]" + "\t" + item.name + "\r";
			}));
		}
		
		
		
		
		//--------------------------------------
		// GeomUtilへ移動しました。
		//--------------------------------------
		
		/**
		 * DisplayObjectのx,y,width,heightをRectangleで指定。
		 * @param	target
		 * @param	rect
		 * @deprecated	GeomUtil.setRectangle へ移行。
		 */
		static public function setPropsByRectangle(target:DisplayObject, rect:Rectangle):void {
			target.x = rect.x;
			target.y = rect.y;
			target.width = rect.width;
			target.height = rect.height;
		}
		
		/**
		 * DisplayObjectからRectangleを返す。
		 * @param	target
		 * @return	
		 * @deprecated	GeomUtil.setRectangle へ。
		 */
		static public function displayObjectToRectangle(target:DisplayObject):Rectangle {
			return new Rectangle(
				target.x
				,target.y
				,target.width
				,target.height
			);
		}
		
		
	}
	
}