package saz.collections.iterator {
	import saz.collections.IIterator;
	import saz.collections.Iterator;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayLoopIterator extends ArrayIteratorBase implements IIterator{
		
		
		//--------------------------------------
		// OUTSIDE
		//--------------------------------------
		//protected var $arr:Array;
		
		//--------------------------------------
		// INSIDE
		//--------------------------------------
		//protected var $index:int;
		//protected var $lastIndex:int;
		
		protected var $start:int;
		
		public function ArrayLoopIterator(collection:Array, start:int = 0) {
			super(collection);
			$arr = collection;
			$start = start;
			reset();
		}
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return true;
		}
		
		/**
		 * @copy	IIterator#next
		 */
		override public function next():*{
			if (!hasNext()) throw new NoSuchElementError("これ以上要素がありません。");
			var res:*= $arr[$index];
			$lastIndex = $index;
			$index = ($index + 1) % $arr.length;
			return res;
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			//$index = $clip($index - 1);
			$index = $clipIndex($index - 1);
			$lastIndex = -1;
		}
		
		/**
		 * @copy	IIterator#reset
		 */
		override public function reset():void {
			$index = 0;
			$lastIndex = -1;
		}
		
	}

}