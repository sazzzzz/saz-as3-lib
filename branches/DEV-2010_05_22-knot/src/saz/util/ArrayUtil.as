package saz.util {
	import saz.IteratorBreakError;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayUtil {
		
		/**
		 * Array内のすべての要素に何かする。いわゆるeach。
		 * @param	target
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
		 * @param	target
		 */
		public static function removeAll(target:Array):void {
			target.splice(0);
		}
	}
	
}