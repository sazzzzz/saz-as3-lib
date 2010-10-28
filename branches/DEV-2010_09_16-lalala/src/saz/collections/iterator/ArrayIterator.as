package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	/**
	 * Array用Iterator. 要素がなくなったら終了.
	 * @author saz
	 * @example <listing version="3.0" >
	 * import saz.collections.iterator.*;
	 * var n1:Array = [0,1,2,3,4,5,6,7,8,9,10];
	 * var in1:ArrayIterator = new ArrayIterator(n1);
	 * var item:*;
	 * while(in1.hasNext()){
	 * 	item = in1.next();
	 * 	trace(item);
	 * }
	 * </listing>
	 */
	public class ArrayIterator extends ArrayIteratorBase implements IIterator {
		
		public function ArrayIterator(collection:Array, start:int = 0) {
			super(collection, start);
		}
		
		
		/* オーバーライド用 */
		
		// 主にインデックス処理
		override protected function $nextHook():void {
			$index++;
		}
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return ($index < $arr.length);
		}
		
		/**
		 * @copy	IIterator#remove
		 */
		override public function remove():void{
			if ( -1 == $lastIndex) throw new IllegalStateError("next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されています。");
			$arr.splice($lastIndex, 1);
			$index = Math.max(0, $index - 1);
			$lastIndex = -1;
		}
		
	}

}