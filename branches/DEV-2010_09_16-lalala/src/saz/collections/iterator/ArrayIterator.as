package saz.collections.iterator {
	import saz.collections.iterator.ArrayIteratorBase;
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	/**
	 * Array用Iterator
	 * @author saz
	 */
	//public class ArrayIterator implements IIterator {
	//public class ArrayIterator extends Iterator implements IIterator {
	public class ArrayIterator extends ArrayIteratorBase implements IIterator {
		
		//--------------------------------------
		// OUTSIDE
		//--------------------------------------
		//protected var $arr:Array;
		
		//--------------------------------------
		// INSIDE
		//--------------------------------------
		//protected var $index:int;
		//protected var $lastIndex:int;
		
		public function ArrayIterator(collection:Array) {
			super(collection);
			//$arr = collection;
			reset();
		}
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return ($index < $arr.length);
		}
		
		/**
		 * @copy	IIterator#next
		 */
		override public function next():*{
			if (!hasNext()) throw new NoSuchElementError("これ以上要素がありません。");
			var res:*= $arr[$index];
			$lastIndex = $index;
			$index++;
			return res;
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			//$index = $lastIndex;
			$index = Math.max(0, $index - 1);
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