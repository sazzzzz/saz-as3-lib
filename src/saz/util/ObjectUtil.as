package saz.util {
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	/**
	 * Objectユーティリティ
	 * @author saz
	 */
	public class ObjectUtil {
		
		
		//public static function listDefferenceProperties(target:Object,names:Array):
		
		/**
		 * Objectのメンバを全て削除する. for...inで実装. 
		 * @param target
		 * 
		 */
		static public function clear(target:Object):void {
			for (var p:String in target) {
				delete target[p];
			}
		}
		
		
		
		/**
		 * Objectのプロパティを配列にして返す. 
		 * @param	target
		 * @return
		 * 
		 * @see	saz.collections.generic.ObjectIterator#_toArray
		 */
		static public function toArray(target:Object):Array {
			// ▽ループ　ActionScript3.0 Flash CS3
			// http://1art.jp/flash9/chapter/125/
			var res:Array = [];
			var item:Object;
			
			// for each		こっちが早い
			for each(item in target){
				res.push(item);
			}
			return res;
		}
		
		
		/**
		 * 指定プロパティの値を配列にして返す.
		 * @param	target	対象オブジェクト.
		 * @param	names	プロパティ名のリスト.
		 * @return
		 */
		public static function getProperties(target:Object, names:Array):Array {
			var res:Array = new Array(names.length);
			names.forEach(function(item:*, index:int, arr:Array):void {
				res[index] = target[item];
			});
			return res;
		}
		
		/**
		 * 対象オブジェクトのプロパティを一括設定します.jp.nium.utils.ObjectUtil.setProperties のマネ.
		 * @param	target	対象オブジェクト.
		 * @param	params	設定したいプロパティを含んだオブジェクトです.
		 * @see	jp.nium.utils.ObjectUtil#setProperties
		 * @see	http://asdoc.progression.jp/4.0/jp/nium/utils/ObjectUtil.html#setProperties()
		 */
		public static function setProperties(target:Object, params:Object):void {
			for (var p:String in params) {
				target[p] = params[p];
			}
		}
		
		
		/**
		 * プロパティ名の一覧を返す.
		 * @param	target	対象とするObject。
		 * @return	プロパティ名を含むArray. 順不同. 
		 */
		public static function propNames(target:Object):Array {
			var res:Array = new Array();
			for (var p:* in target) {
				res.push(p);
			}
			return res;
		}
		
		/**
		 * Objectの深い複製。
		 * @see	http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ee7.html
		 * @param	target	対象とするObject。
		 * @return
		 */
		public static function deepClone(target:Object):* {
			var ba:ByteArray = new ByteArray();
			ba.writeObject(target);
			ba.position = 0;
			return (ba.readObject());
		}
		
		/**
		 * Objectインスタンスを複製する。
		 * 各要素は複製せず、参照を代入するのみ。
		 * @param	target	対象とするObject。
		 * @return
		 */
		public static function clone(target:Object):Object {
			var res:Object = new Object();
			for (var name:String in target) {
				res[name] = target[name];
			}
			return res;
		}
		
		/**
		 * Object内のすべての要素を削除する。
		 * @param	target	対象とするObject。
		 */
		public static function removeAll(target:Object):void {
			// for each じゃダメでした！
			/*for each(var item:* in target) {
				item = null;
			}*/
			for (var name:String in target) {
				//target[name] = null;		// null代入だとエントリが残っちゃう！
				delete target[name];		// for..in で、 delete じゃないとダメみたい。
			}
		}
		
		/**
		 * オブジェクトからクラス名を取得する
		 * @param	target
		 * @return
		 * @see	http://www.func09.com/wordpress/archives/152
		 */
		public static function getClassName(target:*):String {
			return String(describeType(target).@name).match(/::(.*)/)[1];
		}
		
		
		/**
		 * インスタンス同士を比較して、値が異なるアクセサをリストにして返す. ただし対象となるアクセサはBoolean, String, Number, int, utin型のみ. 
		 * @param	target	調べる対象のインスタンス. 
		 * @param	original	比較対象のインスタンス. 
		 * @return	{name:"name", value:value}形式のObjectの配列. 
		 * @see	http://help.adobe.com/ja_JP/Flash/CS5/AS3LR/flash/utils/package.html#describeType()
		 * @see	http://www.be-interactive.org/?itemid=26
		 */
		public static function listDifferentAccessor(target:*, original:*):Array {
			var res:Array = [];
			var value:*;
			for each(var acc:XML in describeType(target)..accessor) {
				value = target[acc.@name];
				var to:String = typeof(value);
				if ( (to == "boolean" || to == "string" || to == "number") && value != original[acc.@name]) {
					res.push({name:acc.@name, value:value});
				}
			}
			return res;
		}
		
		
		/**
		 * シンプルな toString() メソッドの実装を提供.
		 * @param	target	対象インスタンス
		 * @param	className	対象となるクラス名
		 * @param	names	プロパティ名
		 * @return
		 */
		public static function formatToString( target:*, className:String, ... names:Array ):String {
			var res:String = "[" +className;
			var i:int, n:int, name:String, value:*;
			for (i = 0, n = names.length; i < n; i++) {
				name = names[i];
				value = target[name];
				if (value is String) {
					res += " " + name + "=\"" + value + "\"";
				}else {
					res += " " + name + "=" + value;
				}
			}
			return res + "]";
		}
		
		
		
		/**
		 * 指定プロパティのみをStringにして返す（みたい）. 
		 * toString()とは別系統. 
		 * @param	target	対象Object. 
		 * @param	names	プロパティ名の配列
		 * @param	separator
		 * @return
		 */
		public static function propertiesToString(target:Object, names:Array, separator:String = ": "):String {
			var res:String = "";
			names.forEach(function(item:String, index:int, arr:Array):void {
				res += item + separator + target[item] + "\n";
			});
			return res;
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  テスト用
		//
		//--------------------------------------------------------------------------
		
		// TODO:	出力用メソッドが乱立しとる！整理したい！
		
		
		
		
		
		
		
		
		/**
		 * for in で列挙できるかどうか（仮実装）。
		 * @param item
		 * @return 
		 */
		public static function isEnumerable(item:Object):Boolean
		{
			return item != null && typeof(item) == "object";
		}
		
		
		
		/**
		 * Objectの中身を、trace()する. toStringをtraceしてる.
		 * @param	target	対象Object. 
		 */
		public static function traceObject(target:Object):void {
			trace(toString(target));
		}
		
		/**
		 * for in で列挙できるObjectの中身をStringにして返す。
		 * @param target
		 * @return 
		 */
		public static function toObjectString(target:Object, indent:String = "  "):String
		{
			return _startToObjectString(target, "", indent);
		}
		
		
		
		
		
		
		private static function _startToObjectString(target:Object, curIndent:String = "", indent:String = "  "):String {
			if (target == null) return "null";
			var res:String = "";
			res += "{\n";
			res += _toObjectString(target, curIndent + indent, indent);
			res += "}";
			return res;
		}
		
		
		private static function _toObjectStringEnum(target:Object, name:String, curIndent:String = "", indent:String = "  "):String
		{
			var res:String = "";
			res += curIndent + name + ": {\n";
			res += _toObjectString(target, curIndent + indent, indent);
			res += curIndent + "}\n";
			return res;
		}
		
		private static function _toObjectStringItem(item:Object, name:String, curIndent:String = "", indent:String = "  "):String
		{
			return curIndent + name + ": " + item + "\n";
		}
		
		// toString用サブメソッド。
		private static function _toObjectString(target:Object, curIndent:String = "", indent:String = "  "):String {
			var res:String = "";
			var item:*;
			for(var p:String in target){
				item = target[p];
				if (isEnumerable(item)) {
					res += _toObjectStringEnum(item, p, curIndent, indent);
				}else{
					res += _toObjectStringItem(item, p, curIndent, indent);
				}
			}
			return res;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * Objectの中身を、trace()する. toStringをtraceしてるだけ.
		 * @param	target	対象Object. 
		 * @deprecated	traceObject()を使え. 
		 */
		public static function log(target:Object):void {
			trace(toString(target));
		}
		
		/**
		 * Objectの中身を、trace()する。
		 * @param	target	対象Object. 
		 * @param	indent
		 * @deprecated	traceObject()を使え. 
		 */
		public static function dump2(target:Object, indent:String = "  "):void {
			trace(toObjectString(target, indent));
		}
		
		
		
		/**
		 * Object の中身をStringにして返す. 
		 * @param	target	対象Object. 
		 * @return
		 * 
		 * @deprecated	toObjectString()を使え. 
		 * 
		 * @example <listing version="3.0" >
		 * trace(ObjectUtil.toString(obj));
		 * </listing>
		 */
		public static function toString(target:*):String {
			return toObjectString(target);
		}
		
		/**
		 * Object　の中身をStringにして返す. toString()を使え. 
		 * @param	target	対象Object. 
		 * @return
		 * @deprecated	toObjectString()を使え. 
		 */
		public static function dump(target:*):String {
			return toObjectString(target);
		}
	}
	
}