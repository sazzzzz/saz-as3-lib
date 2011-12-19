package saz.collections.generic {
	
	/**
	 * 非ジェネリック コレクションに対する単純な反復処理をサポートします。.
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * // Iteratorはダミークラス
	 * var i:IIterator = new ArrayIterator(collection);
	 * var item;
	 * while(i.next()){
	 *   item = i.current;
	 *   // do something...
	 *   
	 * }
	 * </listing>
	 */
	public interface IIterator {
		
		/**
		 * コレクション内の現在の要素を取得します。<br/>
		 * 列挙子を作成した後や reset メソッドを呼び出した後に、コレクションの最初の要素に列挙子を進めるためには、current プロパティの値を読み取る前に next メソッドを呼び出す必要があります。<br/>
		 * そうしない場合、current は未定義になります。<br/>
		 */
		function get current():Object;
		
		/**
		 * 列挙子をコレクションの次の要素に進めます。<br/>
		 * @return	列挙子が次の要素に正常に進んだ場合は true。列挙子がコレクションの末尾を越えた場合は false。
		 */
		function next():Boolean;
		
		/**
		 * 列挙子を初期位置、つまりコレクションの最初の要素の前に設定します。
		 */
		function reset():void;
	}
	
}