package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	import saz.collections.ArrayHelper;
	/**
	 * Array用逆回転１周Iterator.
	 * @author saz
	 */
	//public class ArrayCycleReverseIterator extends ArrayCycleIteratorBase implements IIterator {
	public class ArrayCycleReverseIterator extends ArrayIteratorBase implements IIterator {
		
		private var $cycleCount:int;
		private var $cycle:int;
		
		public function ArrayCycleReverseIterator(collection:Array, start:int = ArrayHelper.MAX_INDEX, cycleCount:int = 1) {
			$cycleCount = cycleCount;
			
			super(collection, Math.min(collection.length - 1, start));
		}
		
		
		/* オーバーライド用 */
		
		override protected function $nextHook():void {
			var len:int = $arr.length;
			//$index = (($index - (len-1) - 1) % len) + (len-1);
			$index = (($index - len) % len) + len - 1;
			if ($index == $start) $cycle--;
		}
		
		override protected function $resetHook():void {
			$cycle = $cycleCount;
		}
		
		
		
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return (0 < $cycle);
		}
		
		/**
		 * このメソッドは実装されていません。
		 */
		override public function remove():void {
			super.remove();
		}
		
	}

}