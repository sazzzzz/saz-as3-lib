package saz.collections {
	
	/**
	 * IIteratorを持ってるインターフェース。
	 * @author saz
	 */
	public interface IIterable {
		/**
		 * Iteratorを取得。
		 * @return
		 */
		function getIterator():IIterator;
	}
	
}