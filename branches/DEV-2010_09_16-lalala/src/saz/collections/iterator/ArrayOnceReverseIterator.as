package saz.collections.iterator {
	import saz.collections.*;
	import saz.util.ArrayUtil;
	/**
	 * Array用逆回転１周Iterator.
	 * @author saz
	 */
	public class ArrayReverseCycleIterator extends ArrayCycleIteratorBase implements IIterator {
		
		public function ArrayReverseCycleIterator(collection:Array, start:int = ArrayHelper.MAX_INDEX) {
			super(collection, Math.min(collection.length - 1, start));
		}
		
		override protected function $nextHook():void {
			var len:int = $arr.length;
			//$index = (($index - (len-1) - 1) % len) + (len-1);
			$index = (($index - len) % len) + len - 1;
		}
		
		override protected function $removeHook():void {
			$index = $clip($index);
		}
		
	}

}