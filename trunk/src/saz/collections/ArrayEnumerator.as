package saz.collections {
	/**
	 * IEnumerator インターフェースを持つ Array ラッパ。
	 * @author saz
	 */
	public class ArrayEnumerator extends Enumerator {
		
		/**
		 * コンストラクタ。
		 * @param	component	対象Arrayインスタンス。
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, true, true];
		 * var enu:Enumerable = new Enumerable(new ArrayEnumerator(arr));
		 * trace(enu.all());
		 * </listing>
		 */
		public function ArrayEnumerator(component:Array) {
			super(component, "forEach");
		}
		
		/*override public function forEach(callback:Function, thisObject:* = null):void {
			super.forEach(callback, this);
		}*/
		
	}

}