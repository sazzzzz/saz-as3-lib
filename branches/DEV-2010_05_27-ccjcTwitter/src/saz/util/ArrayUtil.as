﻿package saz.util {
	import saz.IteratorBreakError;
	
	/**
	 * Arrayユーティリティークラス。
	 * @author saz
	 */
	public class ArrayUtil {
		
		/**
		 * 配列の内容から、検索用索引Objectを作る。プロパティ名を指定できる。
		 * @param	taget
		 * @param	key	プロパティ名。デフォルトは"id"。
		 * @return
		 * 入力：[{id:"001"}, {id:"002"}]
		 * 出力：{001:0, 002:1}
		 */
		public static function makeIndexData(target:Array, key:String = "id"):Object {
			var res:Object = new Object;
			var value:Object;
			each(target, function(item:*, index:int) {
				value = item[key];
				if ("number" == typeof(value)) {
					// 数値型だとキーにできないので、エラー
					throw new TypeError("ArrayUtil.makeIndexData(): 値が数値型のため、プロパティ名にできません。");
				}
				res[value] = index;
			});
			return res;
		}
		
		/**
		 * 配列の中から、指定した名前と値を持つ最初の要素を返す
		 * @param	target	対象とする配列
		 * @param	key	探す名前
		 * @param	value	探す値
		 * @return
		 */
		public static function search(target:Array, key:String, value:*):*{
			var res:*= null;
			each(target, function(item:*, index:int) {
				if (value == item[key]) {
					res = item;
					throw new IteratorBreakError("ArrayUtil.search(): 発見");	//returnじゃ抜けれないよ
				}
			});
			return res;
		}
		
		/**
		 * Array内のすべての要素に何かする。いわゆるeach。
		 * @param	target	対象とする配列
		 * @param	iterator
		 */
		public static function each(target:Array, iterator:Function):void {
			try {
				for (var i:Number = 0, l:Number = target.length, item:*; i < l; i++) {
					item = target[i];
					iterator(item, i);
				}
			}catch (e:IteratorBreakError) {
				//ループを抜ける
				return;
			} catch (e:Error) {
				//trace("other error: "+e);
				throw e;	//外側にエラーを投げる
				return;
			}
		}
		
		/**
		 * Array内のすべての要素を削除する。
		 * @param	target	対象とする配列
		 */
		public static function removeAll(target:Array):void {
			target.splice(0);
		}
	}
	
}