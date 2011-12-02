﻿package saz.util {
	
	/**
	 * Objectユーティリティ
	 * @author saz
	 */
	public class ObjectUtil {
		
		/**
		 * Object内のすべての要素を削除する。
		 * @param	target	対象とするObject
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