package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	import saz.collections.*;
	/**
	 * Array用１周Iteratorベースクラス.
	 * @author saz
	 */
	public class ArrayCycleIteratorBase extends Iterator implements IIterator {
		
		//--------------------------------------
		// OUTSIDE
		//--------------------------------------
		protected var $arr:Array;
		
		//--------------------------------------
		// INSIDE
		//--------------------------------------
		protected var $index:int;
		protected var $lastIndex:int;
		
		protected var $start:int;
		protected var $count:int;
		
		public function ArrayCycleIteratorBase(collection:Array, start:int = 0) {
			super();
			if (collection.length <= start) throw new ArgumentError("startはcollection.lengthより小さくなくてはいけません。");
			$arr = collection;
			$start = start;
			reset();
		}
		
		
		/* オーバーライド用 */
		protected function $nextHook():void { }
		protected function $removeHook():void {}
		
		
		
		
		protected function $clip(index:int):int {
			return Math.max(0, Math.min(index, $arr.length - 1));
		}
		
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return (0 < $count);
		}
		
		/**
		 * @copy	IIterator#next
		 */
		override public function next():*{
			if (!hasNext()) throw new NoSuchElementError("これ以上要素がありません。");
			var res:*= $arr[$index];
			$lastIndex = $index;
			$nextHook();
			$count--;
			return res;
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			$removeHook();
			$lastIndex = -1;
		}
		
		/**
		 * @copy	IIterator#reset
		 */
		override public function reset():void {
			$index = $start;
			$lastIndex = -1;
			$count = $arr.length;
		}
		
	}

}