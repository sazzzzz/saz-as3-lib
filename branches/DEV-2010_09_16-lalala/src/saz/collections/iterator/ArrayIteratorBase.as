package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	
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
		protected var $start:int;

		protected var $index:int;
		protected var $lastIndex:int;
		
		
		/**
		 * 
		 * @param	collection
		 * @param	start	自動的にクリップされる.
		 */
		public function ArrayIteratorBase(collection:Array, start:int = 0) {
			super();
			$arr = collection;
			$start = $clipIndex(start);
			
			reset();
		}
		
		
		/* オーバーライド用 */
		
		// 主にインデックス処理
		protected function $nextHook():void { }
		protected function $resetHook():void { }
		//protected function $removeHook():void { }
		
		
		/* protected */
		
		/**
		 * インデックスをクリップする.
		 * @param	index
		 * @return
		 */
		protected function $clipIndex(index:int):int {
			return Math.max(0, Math.min(index, $arr.length - 1));
		}
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return false;
		}
		
		/**
		 * @copy	IIterator#next
		 */
		override public function next():*{
			if (!hasNext()) throw new NoSuchElementError("これ以上要素がありません。");
			var res:*= $arr[$index];
			$lastIndex = $index;
			$nextHook();
			return res;
		}
		
		/**
		 * @copy	IIterator#reset
		 */
		override public function reset():void {
			$index = $start;
			$lastIndex = -1;
			$resetHook();
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		/*override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			$removeHook();
			$lastIndex = -1;
		}*/
		
	}

}