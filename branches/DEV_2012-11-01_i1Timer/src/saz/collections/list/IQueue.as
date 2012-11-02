package saz.collections.list {
	
	/**
	 * ...
	 * @author saz
	 */
	public interface IQueue {
		
		/**
		 * 先頭にあるオブジェクトを削除せずに返します. 
		 * @return	先頭にあるオブジェクト.
		 */
		function peek():*;
		
		/**
		 * 末尾にオブジェクトを追加します. 
		 * @param	item	追加するオブジェクト. 
		 */
		function enqueue(item:*):void;
		
		/**
		 * 先頭にあるオブジェクトを削除し、返します. 
		 * @return	先頭から削除されたオブジェクト. 
		 */
		function dequeue():*;
		
	}
	
}