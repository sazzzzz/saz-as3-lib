package saz.collections.iterator {
	/**
	 * Object用Iterator。順番は不定。
	 * @author saz
	 */
	public class ObjectIterator extends Iterator implements IIterator {
		
		//--------------------------------------
		// OUTSIDE
		//--------------------------------------
		private var $arr:Array;
		
		//--------------------------------------
		// INSIDE
		//--------------------------------------
		private var $iterator:ArrayIterator;
		//private var $lastItem:
		
		public function ObjectIterator(collection:Object) {
			super();
			$arr = new Array();
			// Object > Array
			for each(var item:* in collection) {
				$arr.push(item);
			}
			$iterator = new ArrayIterator($arr);
		}
		
		/* INTERFACE saz.collections.IIterator */
		
		/**
		 * @copy	IIterator#hasNext
		 */
		override public function hasNext():Boolean{
			return $iterator.hasNext();
		}
		
		/**
		 * @copy	IIterator#next
		 */
		override public function next():*{
			return $iterator.next();
		}
		
		/**
		 * サポートしない。
		 */
		/*override public function remove():void{
			return $iterator.remove();
		}*/
		
		/**
		 * @copy	IIterator#reset
		 */
		override public function reset():void {
			$iterator.reset();
		}
		
	}

}