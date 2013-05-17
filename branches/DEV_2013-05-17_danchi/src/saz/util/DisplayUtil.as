package saz.util {
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class DisplayUtil {
		
		//--------------------------------------
		// const
		//--------------------------------------
		
		/**
		 * 最小フレーム。
		 */
		public static const MIN_FRAME:int = 1;
		/**
		 * 最大フレーム数。
		 * @see	http://kb2.adobe.com/jp/cps/228/228626.html
		 */
		public static const MAX_FRAME:int = 16000 - 10;
		
		/**
		 * generateLayoutCode用プロパティ名のリスト. 
		 */
		//public static const LAYOUT_ACCESSOR_NAMES:Array = ["x", "y", "scaleX", "scaleY", "rotation", "alpha", "blendMode"];
		public static const LAYOUT_ACCESSOR_NAMES:Array = ["x", "y", "width", "height", "rotation", "alpha", "blendMode"];
		//public static const LAYOUT_ACCESSOR_NAMES:Array = ["x", "y", "width", "height", "scaleX", "scaleY", "rotation", "alpha", "blendMode"];
		
		
		//--------------------------------------
		// vars
		//--------------------------------------
		
		static private var $defaultColorMatrix:Array;
		
		private static var _sprite:Sprite;
		private static var _movieClip:MovieClip;
		
		/**
		 * デフォルトSprite. 
		 */
		public static function get sprite():Sprite {
			_sprite ||= new Sprite();
			return _sprite;
		}
		
		/**
		 * デフォルトMovieClip. 
		 */
		public static function get movieClip():MovieClip {
			_movieClip ||= new MovieClip();
			return _movieClip;
		}
		
		
		//--------------------------------------
		// @deprecated
		//--------------------------------------
		
		/**
		 * 外部swfから指定した名前のクラスを取り出す.
		 * @deprecated	廃止予定. 代わりにClassUtil.extractClassを使え.
		 * @param	loaderInfo	LoaderのLoaderInfoインスタンス.
		 * @param	className	クラス名.
		 * @return
		 */
		/*public static function getExternalClass(loaderInfo:LoaderInfo, className:String):Class {
			return loaderInfo.applicationDomain.getDefinition(className) as Class;
		}*/
		
		
		
		//--------------------------------------
		// code generation
		//--------------------------------------
		
		// 
		private static function _formatLayoutCode(target:DisplayObject, propName:String, value:*):String {
			return target.name + "." + propName + " = " + value + ";\n";
		}
		
		/**
		 * 指定DisplayObjectの、レイアウト用コードをStringで返す. 
		 * @param	target	対象とするDisplayObject. 
		 * @param	isRound	数字を四捨五入するかどうか. scaleX,scaleYは小数点以下2桁で、それ以外は整数化する. 
		 * @param	nameList	プロパティ名のリスト. デフォルトはLAYOUT_ACCESSOR_NAMES. 
		 * @param	formatFunction	出力用関数. デフォルトは_formatLayoutCode. 
		 * @return
		 */
		public static function generateLayoutCode(target:DisplayObject, isRound:Boolean = true, nameList:Array = null, formatFunction:Function = null):String {
			nameList ||= LAYOUT_ACCESSOR_NAMES;
			formatFunction ||= _formatLayoutCode;
			
			var res:String = "";
			var prop:String, value:*;
			for (var i:int = 0, n:int = nameList.length; i < n; i++) {
				prop = nameList[i];
				value = target[prop];
				if (value != sprite[prop]) {
					// 値が違う
					if (isRound && (prop == "scaleX" || prop == "scaleY")) value = Math.round(value * 100) / 100;
					if (isRound && (prop == "x" || prop == "y" || prop == "width" || prop == "height" || prop == "rotation")) value = Math.round(value);
					if (typeof(value) == "string") value = '"' + value + '"';
					res += formatFunction(target, prop, value);
				}
			}
			//res += "addChild(" + target.name + ");\n";
			return res;
		}
		
		/**
		 * 指定DisplayObjectContainer内のDisplayObjectの、レイアウト用コードをStringで返す. 
		 * @param	container	対象とするDisplayObjectContainer. 
		 * @param	isRound	数字を四捨五入するかどうか. scaleX,scaleYは小数点以下2桁で、それ以外は整数化する. 
		 * @param	nameList	プロパティ名のリスト. デフォルトはLAYOUT_ACCESSOR_NAMES. 
		 * @param	formatFunction	出力用関数. デフォルトは_formatLayoutCode. 
		 * @return
		 */
		public static function generateChildenLayoutCode(container:DisplayObjectContainer, isRound:Boolean = true, nameList:Array = null, formatFunction:Function = null):String {
			nameList ||= LAYOUT_ACCESSOR_NAMES;
			formatFunction ||= _formatLayoutCode;
			
			var res:String = "";
			for (var i:int, item:DisplayObject; i < container.numChildren; i++) {
				item = container.getChildAt(i);
				res += generateLayoutCode(item, isRound, nameList, formatFunction);
			}
			return res;
		}
		
		
		
		//--------------------------------------
		// main
		//--------------------------------------
		
		
		/**
		 * フルスクリーンかどうか。
		 * @param stage
		 * @return 
		 * 
		 */
		public static function isFullScreen(stage:Stage):Boolean
		{
			return stage.displayState == StageDisplayState.FULL_SCREEN;
		}
		
		/**
		 * センタリングする. getBounds()を利用. 
		 * @param target
		 * @param centerX
		 * @param centerY
		 * 
		 */
		static public function centeringByBounds(target:DisplayObject, centerX:Number = 0, centerY:Number = 0):void
		{
			/*if (parentObject == null)
			{
				if (target.parent == null) throw new ArgumentError("座標系の基準となるDisplayObjectが指定されていません。");
				
				parentObject = target.parent;
			}*/
			
			var bounds:Rectangle = target.getBounds(target);
			target.x = centerX - Math.round(bounds.x + bounds.width / 2);
			target.y = centerY - Math.round(bounds.y + bounds.height / 2);
		}
		
		
		/**
		 * 中心のx座標.
		 * @param	target
		 * @return
		 */
		static public function center (target:DisplayObject):Number {
			return target.x + (target.width / 2);
		}
		
		/**
		 * 中心のy座標. 
		 * @param	target
		 * @return
		 */
		static public function middle(target:DisplayObject):Number {
			return target.y + (target.height / 2);
		}
		
		/**
		 * 中心の座標をPointで. 
		 * @param	target
		 * @return
		 */
		static public function centerPoint(target:DisplayObject):Point {
			return new Point(center(target), middle(target));
		}
		
		
		
		
		
		/**
		 * 対象DisplayObjectからルートに至るまで、全てのDisplayObjectに対してプロパティを設定. 
		 * @param	target
		 * @param	name
		 * @param	value
		 */
		public static function setPropertyToAllParent(target:DisplayObject, name:String, value:Object):void {
			while (target != null && !(target is Stage)) {
				target[name] = value;
				target = target.parent;
			}
		}
		
		
		/**
		 * 対象DisplayObjectからルートに至るまで、全てのInteractiveObjectに対してmouseEnabledを設定する. 
		 * @param	target	スタート地点となるDisplayObject.
		 * @param	value	mouseEnabledに設定する値. デフォルトはfalse. 
		 */
		public static function forceMouseEnabled(target:DisplayObject, value:Boolean = false):void {
			while (target != null && !(target is Stage)) {
				if (target is InteractiveObject) {
					InteractiveObject(target).mouseEnabled = value;
				}
				target = target.parent;
			}
			//setPropertyToAllParent(target, "mouseEnabled", value);
		}
		
		
		/**
		 * ColorMatrixFilter用デフォルト配列。
		 * @return
		 */
		public static function getDefaultColorMatrix():Array {
			if (!$defaultColorMatrix)$defaultColorMatrix = [
				1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, 1, 0
			];
			return $defaultColorMatrix;
		}
		
		/**
		 * 指定したDisplayObjectのURLがローカルかどうか. ＝"file:///"を含むかどうか. 
		 * @param	dsp	DisplayObjectインスタンス.
		 * @return
		 */
		public static function isLocal(dsp:DisplayObject):Boolean {
			return ( 0 == dsp.loaderInfo.url.indexOf("file:///"));
		}
		
		/**
		 * ドキュメントクラス（あるいはメインタイムライン）が、親SWFかどうかを返す。
		 * @param	target	調べたいドキュメントクラス（あるいはメインタイムライン）。
		 * @return	親SWFならtrue。
		 * @see	http://www.imajuk.com/blog/archives/2008/01/as3root_1.html
		 */
		public static function isRootDocument(document:DisplayObjectContainer):Boolean {
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
		public static function createColorTransform( rgb:uint, alpha:Number = 1 ):ColorTransform {
			// FIXME	createColorTransform(0x000000, 1 / 2)が期待通りにならない。
			var k:Number = 1.0 - alpha;
			var red:Number = (rgb >> 16 & 0xFF) * alpha;
			var green:Number = (rgb >> 8 & 0xFF) * alpha;
			var blue:Number = (rgb & 0xFF) * alpha;
			return new ColorTransform( k, k, k, 1, red, green, blue, 0 );
		}
		/*public static function createColorTransform( rgb:uint, alpha:Number = 1 ):ColorTransform {
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
		/*public static function setRGB(target:DisplayObject, rgb:uint, alpha:Number = 1):void {
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = rgb;
			colorTrans.alphaMultiplier = alpha;
			target.transform.colorTransform = colorTrans;
		}*/
		
		
		/**
		 * DisplayObjectContainerの子用each。
		 * @param	target
		 * @param	iterator
		 * function(item:DisplayObject, index:uint, collection:DisplayObjectContainer):void
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function eachChildren(target:DisplayObjectContainer, iterator:Function):void {
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
		public static function childrenToArray(target:DisplayObjectContainer):Array {
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
		public static function childrenToString(target:DisplayObjectContainer, iterator:Function = null):String {
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
		public static function $childToString(item:DisplayObject, index:int, collection:DisplayObjectContainer):String {
			return item.name + "\r";
		}
		
		/**
		 * DisplayObjectContainerの子リストをtrace。
		 * @param	target
		 */
		public static function dumpChildren(target:DisplayObjectContainer):void {
			trace(childrenToString(target, function(item:DisplayObject, index:int, collection:DisplayObjectContainer):String {
				return "[" + ObjectUtil.getClassName(item) + "]" + "\t" + item.name + "\r";
			}));
		}
		
		
		
		//--------------------------------------
		// MovieClip
		//--------------------------------------
		
		/**
		 * ラベル名からフレーム番号に変換用に、キャッシュObjectを生成. 
		 * @param	target
		 * @return
		 */
		public static function cacheLabelToFrame(target:MovieClip):Object {
			// 62msec @9999回ループ
			var res:Object = { };
			var labels:Array = target.currentLabels;
			for (var i:int = 0, n:int = labels.length, item:FrameLabel; i < n; i++) {
				item = labels[i];
				res[item.name] = item.frame;
			}
			return res;
			// 92msec @9999回ループ
			//var labels:Array = target.currentLabels;
			//return ArrayUtil.arrayToObject(ArrayUtil.propertyList(labels, "name"), ArrayUtil.propertyList(labels, "frame"));
		}
		
		/**
		 * ラベル名からフレーム番号を返す.
		 * @param	target	対象MovieClip. 
		 * @param	label	フレームラベル名. 
		 * @return	フレーム番号を返す. ラベルが見つからない場合は0を返す. 
		 */
		public static function labelToFrame(target:MovieClip, label:String):int {
			var labels:Array = target.currentLabels;
			for (var i:int = 0, n:int = labels.length, item:FrameLabel; i < n; i++) {
				item = labels[i];
				if (FrameLabel(item).name == label) return FrameLabel(item).frame;
			}
			return 0;
		}
		
		
		//--------------------------------------
		// GeomUtilへ移動しました。
		//--------------------------------------
		
		//public static function setPropsByRectangle(target:DisplayObject, rect:Rectangle):void {
		//public static function displayObjectToRectangle(target:DisplayObject):Rectangle {
		
		
	}
	
}