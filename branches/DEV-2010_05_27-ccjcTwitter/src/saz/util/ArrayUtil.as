package saz.util {
	import saz.IteratorBreakError;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayUtil {
		
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
					throw new IteratorBreakError("ArrayUtil.search: 発見");	//returnじゃ抜けれないよ
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