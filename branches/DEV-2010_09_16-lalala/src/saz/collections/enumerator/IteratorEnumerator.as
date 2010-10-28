package saz.collections {
	import saz.errors.IllegalStateError;
	/**
	 * IIteratorをIEnumeratorにするラッパ。
	 * @author saz
	 */
	public class IteratorEnumerator extends Enumerator implements IEnumerator{
		
		private var $iterator:IIterator;
		
		public function IteratorEnumerator(component:IIterator) {
			super(component);
			$iterator = component;
		}
		
		/* INTERFACE saz.collections.IEnumerator */
		
		/**
		 * @copy	Enumerator$forEach
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			var item:*;
			var index:int = 0;
			$iterator.reset();
			while ($iterator.hasNext()) {
				item = $iterator.next();
				callback.apply(thisObject, [item, index, $iterator]);
				index++;
			}
		}
		
	}

}