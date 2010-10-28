package saz.collections.iterator {
	import saz.collections.*;
	/**
	 * Array用１周Iterator.
	 * @author saz
	 */
	public class ArrayOnceIterator extends ArrayOnceIteratorBase implements IIterator {
		
		public function ArrayOnceIterator(collection:Array, start:int = 0) {
			super(collection, start);
		}
		
		override protected function $nextHook():void {
			$index = ($index + 1) % $arr.length;
		}
		
		override protected function $removeHook():void {
			//$index = $clip($index - 1);
			$index = $clipIndex($index - 1);
		}
		
		
	}

}