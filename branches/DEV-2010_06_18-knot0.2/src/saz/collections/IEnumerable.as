package saz.collections {
	
	/**
	 * IEnumeratorを持ってるインターフェース。
	 * @author saz
	 */
	public interface IEnumerable {
		/**
		 * Enumeratorを取得。
		 * @return
		 */
		public function getEnumerator():IEnumerator;
	}
	
}