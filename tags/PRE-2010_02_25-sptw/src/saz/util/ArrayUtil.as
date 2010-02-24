package saz.util {
	import saz.IteratorBreakError;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayUtil {
		
		public static function each(target:Array, iterator:Function):void {
			try {
				for (var i:Number = 0,l:Number=target.length,item; i < l; i++) {
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
		
		public static function removeAll(target:Array):void {
			target.splice(0);
		}
	}
	
}