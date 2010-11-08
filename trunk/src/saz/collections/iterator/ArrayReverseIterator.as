package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.collections.ArrayHelper;
	/**
	 * Array用逆順Iterator. 要素がなくなったら終了.
	 * @author saz
	 * @example <listing version="3.0" >
	 * import saz.collections.iterator.*;
	 * var n1:Array = [0,1,2,3,4,5,6,7,8,9,10];
	 * var in1:ArrayReverseIterator = new ArrayReverseIterator(n1);
	 * var item:*;
	 * while(in1.hasNext()){
	 * 	item = in1.next();
	 * 	trace(item);
	 * }
	 * </listing>
	 */
	public class ArrayReverseIterator extends ArrayIteratorBase{
		
		public function ArrayReverseIterator(collection:Array, start:int = ArrayHelper.MAX_INDEX) {
			super(collection, Math.min(collection.length - 1, start));
		}
		
		
		/* オーバーライド用 */
		
		override protected function $nextHook():void {
			$index--;
		}
		
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return (0 <= $index);
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