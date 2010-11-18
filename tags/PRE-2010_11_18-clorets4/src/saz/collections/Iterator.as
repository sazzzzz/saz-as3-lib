package saz.collections {
	import flash.errors.IllegalOperationError;
	/**
	 * IIteratorを実装した親クラス。
	 * @author saz
	 */
	public class Iterator implements IIterator, IEnumeration, IEnumerable {
		
		public function Iterator() {
		}
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		public function hasNext():Boolean{
			throw new IllegalOperationError("このメソッドは実装されていません。");
			return false;
		}
		
		/**
		 * @copy	IIterator#next
		 */
		public function next():*{
			throw new IllegalOperationError("このメソッドは実装されていません。");
			return null;
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		public function remove():void{
			throw new IllegalOperationError("このメソッドは実装されていません。");
		}
		
		/**
		 * @copy	IIterator#reset
		 */
		public function reset():void {
			throw new IllegalOperationError("このメソッドは実装されていません。");
		}
		
		/* ORIGINAL */
		
		/**
		 * IteratorEnumeratorを返す。
		 * FIXME	暫定的につけてみる。
		 * @return
		 */
		public function enumerator():IEnumerator {
		//public function enumerator():IteratorEnumerator {
			return new IteratorEnumerator(this);
		}
		
		/**
		 * Enumerableインスタンスを返す。
		 * FIXME	暫定的につけてみる。
		 * @return	Enumerableインスタンス。
		 */
		public function enumerable():Enumerable {
			return new Enumerable(enumerator());
		}
		
	}

}