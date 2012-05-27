package saz.collections.iterator {
	import saz.errors.IllegalStateError;
	import saz.errors.NoSuchElementError;
	/**
	 * Array用、周回数指定Iterator.
	 * @author saz
	 */
	public class ArrayCycleIterator extends ArrayIteratorBase implements IIterator {
		
		private var $cycleCount:int;
		private var $cycle:int;
		
		/**
		 * コンストラクタ.
		 * @param	collection	対象とするArray. 
		 * @param	start	インデックスの初期値.
		 * @param	cycleCount	ループ回数.0で無限にすればよかった…
		 */
		public function ArrayCycleIterator(collection:Array, start:int = 0, cycleCount:int = 1) {
			$cycleCount = cycleCount;
			
			super(collection, start);
		}
		
		
		/* オーバーライド用 */
		
		override protected function $nextHook():void {
			$index = ($index + 1) % $arr.length;
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