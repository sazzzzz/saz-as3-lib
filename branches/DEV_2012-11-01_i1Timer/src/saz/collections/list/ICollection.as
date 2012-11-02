package saz.collections.list {
	
	/**
	 * コレクションを操作するメソッドを定義します. （.NET ICollectionのコピー）
	 * @author saz
	 * @see	http://msdn.microsoft.com/ja-jp/library/92t2ye13.aspx
	 */
	public interface ICollection {
		
		//--------------------------------------
		// props
		//--------------------------------------
		
		/**
		 * リスト内のオブジェクト数を返す。
		 * @return
		 */
		function get count():int;
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		/**
		 * 末尾にオブジェクトを追加します。
		 * @param	item	末尾に追加するオブジェクト。
		 */
		function add(item:*):void;
		
		/**
		 * すべての要素を削除します。
		 */
		function clear():void;
		
		/**
		 * 特定の値が格納されているかどうかを判断します。
		 * @param	item	検索するオブジェクト。
		 * @return	item が存在する場合は true。それ以外の場合は false。
		 */
		function contains(item:*):Boolean;
		
		/**
		 * 要素を Array にコピーします。Array の特定のインデックスからコピーが開始されます。
		 * @param	arr	要素をコピーする先の 1 次元の Array. 
		 * @param	arrIndex	コピーの開始位置となる、arr 内の 0 から始まるインデックス。
		 */
		function copyTo(arr:Array, arrIndex:int = 0):void;
		
		/**
		 * 最初に見つかった特定のオブジェクトを削除します。
		 * このメソッドは厳密な等価 (===) 演算子を使用して、値が等しいかどうか確認します。
		 * @param	item	削除するオブジェクト。 
		 * @return	item が正常に削除された場合は true。それ以外の場合は false。 このメソッドは、item が見つからなかった場合にも false を返します。 
		 */
		function remove(item:*):Boolean;
		
	}
	
}