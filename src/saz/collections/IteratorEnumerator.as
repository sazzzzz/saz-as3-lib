package saz.collections {
	import saz.errors.IllegalStateError;
	/**
	 * IIteratorをIEnumeratorにするラッパ。IIteratorの性質上、forEach()は1回しか使えない。
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
		 * 1回しか使えない。
		 * @copy	Enumerator$forEach
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			if (null == $iterator) throw new IllegalStateError("forEachは、1回しか実行できません。");
			
			var item:*;
			var index:int = 0;
			while ($iterator.hasNext()) {
				item = $iterator.next();
				callback.apply(thisObject, [item, index, $iterator]);
				index++;
			}
			// 1回しか使えないことを明示的にするため削除。
			$iterator = null;
		}
		
	}

}