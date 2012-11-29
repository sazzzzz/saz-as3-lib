package saz.collections.generic {
	
	/**
	 * ジェネリック コレクションを操作するメソッドを定義します。.
	 * @author saz
	 */
	public interface ICollection extends IIteratable {
		
		/**
		 * 格納されている要素の数を取得します。
		 */
		function get count():int;
		
		/**
		 * 項目を追加します。
		 * @param	item	追加するオブジェクト。
		 */
		function add(item:Object):void;
		
		/**
		 * ICollection 内で最初に見つかった特定のオブジェクトを削除します。
		 * @param	item	削除するオブジェクト。
		 * @return	item が正常に削除された場合は true。それ以外の場合は false。 このメソッドは、item が見つからない場合にも false を返します。 
		 */
		function remove(item:Object):Boolean;
		
		/**
		 * すべての項目を削除します。
		 */
		function clear():void;
		
		/**
		 * 特定の値が格納されているかどうかを判断します。
		 * @param	item	ICollection内で検索するオブジェクト。
		 * @return	item が ICollection に存在する場合は true。それ以外の場合は false。
		 */
		function contains(item:Object):Boolean;
		
		/**
		 * ICollection の要素を Array にコピーします。Array の特定のインデックスからコピーが開始されます。
		 * @param	arr	ICollection から要素がコピーされる 1 次元の Array。 Array には、0 から始まるインデックス番号が必要です。 
		 * @param	index	コピーの開始位置となる、array 内の 0 から始まるインデックス。
		 */
		function copyTo(arr:Array, index:int):void;
	}
	
}