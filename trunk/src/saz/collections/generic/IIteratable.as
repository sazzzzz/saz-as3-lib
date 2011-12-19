package saz.collections.generic {
	
	/**
	 * 非ジェネリック コレクションに対する単純な反復処理をサポートする列挙子を公開します。.
	 * @author saz
	 */
	public interface IIteratable {
		
		/**
		 * コレクションを反復処理する列挙子を返します。
		 * @return	コレクションを反復処理するために使用できる IIterator オブジェクト。
		 */
		function getIterator():IIterator;
	}
	
}