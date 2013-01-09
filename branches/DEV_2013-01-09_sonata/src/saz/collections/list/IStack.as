package saz.collections.list {
	
	/**
	 * スタックインターフェース.
	 * @author saz
	 */
	public interface IStack {
		
		/**
		 * 先頭にあるオブジェクトを削除せずに返します. 
		 * @return
		 */
		function peek():*;
		
		/**
		 * 要素を格納する. 
		 * @param	item
		 */
		function push(item:*):void;
		
		/**
		 * 要素を1つ取り出す. 
		 * @return
		 */
		function pop():*;
	}
	
}