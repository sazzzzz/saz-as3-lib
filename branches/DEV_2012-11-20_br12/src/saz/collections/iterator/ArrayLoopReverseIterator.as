package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	import saz.collections.AltArray;
	
	/**
	 * Array用、無限ループIterator逆順版.
	 * @author saz
	 */
	public class ArrayLoopReverseIterator extends ArrayIteratorBase implements IIterator{
		
		
		/**
		 * コンストラクタ.
		 * @copy ArrayLoopIterator
		 */
		public function ArrayLoopReverseIterator(collection:Array, start:int = AltArray.MAX_INDEX) {
			super(collection, start);
		}
		
		/* オーバーライド用 */
		
		override protected function $nextHook():void {
			var len:int = $arr.length;
			$index = (($index - len) % len) + len - 1;
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
			$index = $clipIndex($index);
			$lastIndex = -1;
		}
		
	}

}