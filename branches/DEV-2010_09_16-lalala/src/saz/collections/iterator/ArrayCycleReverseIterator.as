package saz.collections.iterator {
	import saz.collections.*;
	import saz.util.ArrayUtil;
	/**
	 * Array用逆回転１周Iterator.
	 * @author saz
	 */
	public class ArrayCycleReverseIterator extends ArrayCycleIteratorBase implements IIterator {
		
		public function ArrayCycleReverseIterator(collection:Array, start:int = ArrayHelper.MAX_INDEX) {
			super(collection, Math.min(collection.length - 1, start));
		}
		
		override protected function $nextHook():void {
			var len:int = $arr.length;
			//$index = (($index - (len-1) - 1) % len) + (len-1);
			$index = (($index - len) % len) + len - 1;
		}
		
		override protected function $removeHook():void {
			//$index = $clip($index);
			$index = $clipIndex($index);
		}
		
	}

}