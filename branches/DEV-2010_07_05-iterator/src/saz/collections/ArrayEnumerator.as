package saz.collections {
	/**
	 * IEnumerator インターフェースを持つ Array ラッパ。
	 * @author saz
	 */
	public class EnumeratorArray extends Enumerator {
		
		/**
		 * コンストラクタ。
		 * @param	component	対象Arrayインスタンス。
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, true, true];
		 * var enu:Enumerable = new Enumerable(new EnumeratorArray(arr));
		 * trace(enu.all());
		 * </listing>
		 */
		public function EnumeratorArray(component:Array) {
			super(component, "forEach");
		}
		
	}

}