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
		
		
		
		//--------------------------------------------------------------------------
		//
		//  テスト用
		//
		//--------------------------------------------------------------------------
		
		
		
		public static function propertiesToString(target:Object, names:Array, separator:String = ": "):String {
			var res:String = "";
			names.forEach(function(item:String, index:int, arr:Array):void {
				res += item + separator + target[item] + "\n";
			});
			return res;
			
		}
		
		/**
		 * Objectの中身を、trace()する. toStringをtraceしてる.
		 * @param	target
		 */
		public static function traceObject(target:Object):void {
			trace(toString(target));
		}
		
		/**
		 * Object の中身をStringにして返す. dumpのエイリアス.
		 */
		public static var toString:Function = dump;
		
		
		/**
		 * Objectの中身を、trace()する。
		 * @param	target
		 * @param	indent
		 */
		public static function dump2(target:Object, indent:String = ""):void {
			var item:*;
			for(var p:String in target){
				item = target[p];
				if (typeof(item) == "object") {
				//if(item is Object){
					trace(indent + p + ":{");
					arguments.callee(item, indent + "  ");
					trace(indent + "}");
				}else{
					trace(indent + p + ":", item);
				}
			}
		}
		
		/**
		 * Object　の中身をStringにして返す。ダンプ用。
		 * @param	target
		 * @return
		 * 
		 * @example <listing version="3.0" >
		 * trace(ObjectUtil.dump(obj));
		 * </listing>
		 */
		public static function dump(target:*):String {
			return $dump(target,"");
		}
		
		static private function $dump(target:*,indent:String):String {
			var res:String = "";
			var item:*;
			res += indent + "{\n";
			for (var name:String in target) {
				item = target[name];
				if (item is Boolean || item is int || item is Number || item is String || item is uint) {
					res += indent + "  " + name + ": " + item +"\n";
				}else {
					//子を持つ
					//res += indent + "  " + name + ":\n" + $dump(item, indent + "  ");
					res += indent + "  " + name + ":\n";
					res += $dump(item, indent + "  ");
				}
			}
			res += indent + "}\n";
			return res;
		}
		
	}
	
}