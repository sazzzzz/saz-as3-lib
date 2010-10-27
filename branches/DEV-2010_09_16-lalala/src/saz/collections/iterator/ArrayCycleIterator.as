package saz.collections.iterator {
	import saz.collections.*;
	/**
	 * Array用１周Iterator.
	 * @author saz
	 */
	public class ArrayCycleIterator extends ArrayCycleIteratorBase implements IIterator {
		
		public function ArrayCycleIterator(collection:Array, start:int = 0) {
			super(collection, start);
		}
		
		override protected function $nextHook():void {
			$index = ($index + 1) % $arr.length;
		}
		
		override protected function $removeHook():void {
			$index = $clip($index - 1);
		}
		
		
	}

}