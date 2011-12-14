package saz.collections.generic {
	
	/**
	 * 非ジェネリック コレクションに対する単純な反復処理をサポートします。.
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * //i.reset()
	 * var item;
	 * do{
	 *   item = i.current;
	 *   // do something...
	 *   
	 * }while(i.next())
	 * </listing>
	 * @example <listing version="3.0" >
	 * //i.reset()
	 * var item;
	 * while(i.current){
	 *   item = i.current;
	 *   // do something...
	 *   
	 *   i.next();
	 * }
	 * </listing>
	 */
	public interface IIterator {
		
		/**
		 * コレクション内の現在の要素を取得します。
		 */
		function get current():Object;
		
		/**
		 * 列挙子をコレクションの次の要素に進めます。
		 * @return	列挙子が次の要素に正常に進んだ場合は true。列挙子がコレクションの末尾を越えた場合は false。
		 */
		function next():Boolean;
		
		/**
		 * 列挙子を初期位置、つまりコレクションの最初の要素の前に設定します。
		 */
		function reset():void;
	}
	
}