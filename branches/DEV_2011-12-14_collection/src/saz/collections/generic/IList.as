package saz.collections.generic {
	
	/**
	 * インデックスによって個別にアクセスできるオブジェクトのコレクションを表します。.
	 * @author saz
	 */
	public interface IList extends ICollection {
		
		/**
		 * 指定したインデックスにある要素を取得します。
		 * @param	index	取得または設定する要素の、0 から始まるインデックス番号。
		 * @return
		 */
		function get(index:int):Object;
		
		/**
		 * 指定したインデックスにある要素を設定します。
		 * @param	index	取得または設定する要素の、0 から始まるインデックス番号。
		 * @param	item	設定するオブジェクト。
		 */
		function set(index:int, item:Object):void;
		
		/**
		 * 指定した項目のインデックスを調べます。
		 * @param	item	検索するオブジェクト。
		 * @return	リストに存在する場合は item のインデックス。それ以外の場合は -1。
		 */
		function indexOf(item:Object):int;
		
		/**
		 * 指定したインデックス位置に項目を挿入します。
		 * @param	index	item を挿入する位置の、0 から始まるインデックス番号。
		 * @param	item	挿入するオブジェクト。
		 */
		function insert(index:int, item:Object):void
		
		/**
		 * 指定したインデックス位置の項目を削除します。
		 * @param	index	削除する項目の 0 から始まるインデックス。
		 */
		function removeAt(index:int):void;
	}
	
}