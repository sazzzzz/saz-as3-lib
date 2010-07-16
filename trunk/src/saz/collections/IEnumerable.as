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
		//function getEnumerator():IEnumerator;
		function enumerator():IEnumerator;
	}
	
}