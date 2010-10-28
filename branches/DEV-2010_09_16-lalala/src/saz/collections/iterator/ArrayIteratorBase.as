package saz.collections.iterator {
	import saz.collections.*;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayIteratorBase extends Iterator implements IIterator {
		
		//--------------------------------------
		// OUTSIDE
		//--------------------------------------
		protected var $arr:Array;
		
		//--------------------------------------
		// INSIDE
		//--------------------------------------
		protected var $index:int;
		protected var $lastIndex:int;
		
		public function ArrayIteratorBase(collection:Array) {
			super();
			$arr = collection;
		}
		
		
		/* オーバーライド用 */
		protected function $constructHook():void { }
		protected function $nextHook():void { }
		protected function $removeHook():void { }
		
		
		protected function $clipIndex(index:int):int {
			return Math.max(0, Math.min(index, $arr.length - 1));
		}
		
	}

}