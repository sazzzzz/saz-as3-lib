﻿package saz.util {
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	/**
	 * Objectユーティリティ
	 * @author saz
	 */
	public class ObjectUtil {
		
		/**
		 * プロパティ名の一覧を返す.
		 * @param	target	対象とするObject。
		 * @return	プロパティ名を含むArray. 順不同. 
		 */
		static public function propNames(target:Object):Array {
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
		static public function deepClone(target:Object):* {
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
		static public function getClassName(target:*):String {
			return String(describeType(target).@name).match(/::(.*)/)[1];
		}
		
		/**
		 * Objectの中身を、trace()する。
		 * @param	target
		 * @param	indent
		 */
		static public function dump2(target:Object, indent:String = ""):void {
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
		
		// エイリアス
		static public var toString:Function = dump;
		
		/**
		 * Object　の中身をStringにして返す。ダンプ用。
		 * @param	target
		 * @return
		 * 
		 * @example <listing version="3.0" >
		 * trace(ObjectUtil.dump(obj));
		 * </listing>
		 */
		static public function dump(target:*):String {
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