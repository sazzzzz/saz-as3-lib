package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	
	/**
	 * Array用、無限ループIterator.
	 * @author saz
	 */
	public class ArrayLoopIterator extends ArrayIteratorBase implements IIterator{
		
		
		/**
		 * コンストラクタ.
		 * @param	collection	対象とするArray. 
		 * @param	start	インデックスの初期値.
		 */
		public function ArrayLoopIterator(collection:Array, start:int = 0) {
			super(collection, start);
		}
		
		/* オーバーライド用 */
		
		override protected function $nextHook():void {
			$index = ($index + 1) % $arr.length;
		}
		
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return true;
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			$index = $clipIndex($index - 1);
			$lastIndex = -1;
		}
		
	}

}