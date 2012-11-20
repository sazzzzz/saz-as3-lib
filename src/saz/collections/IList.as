package saz.collections {
	import saz.IBasic;
	
	/**
	 * Listインターフェース
	 * @author saz
	 */
	//public interface IList extends IBasic  {
	public interface IList {
		
		/**
		 * Arrayインスタンスを返す。
		 * @return
		 */
		function getArray():Array;
		
		/**
		 * リスト内のオブジェクト数を返す。
		 * @return
		 */
		function count():int;
		
		/**
		 * 指定したインデックスの位置にあるオブジェクトを返す。
		 * @param	index	0から始まる整数値。
		 * @return
		 */
		function gets(index:int):*;
		
		/**
		 * リスト内の最初のオブジェクトを返す。
		 * @return
		 */
		function first():*;
		
		/**
		 * リスト内の最後のオブジェクトを返す。
		 * @return
		 */
		function last():*;
		
		/**
		 * 指定インデックスの位置にあるオブジェクトを置き換える。
		 * @param	index	0から始まる整数値。
		 * @param	item
		 */
		function sets(index:int, item:*):void;
		
		//
		// 追加
		//
		
		/**
		 * リストの最後に追加。
		 * @param	item
		 */
		function append(item:*):void;
		
		/**
		 * リストの最初に追加。
		 * @param	item
		 */
		function prepend(item:*):void;
		
		//
		// 削除
		//
		
		/**
		 * 与えられた要素をリストから削除する。
		 * @param	item
		 */
		function remove(item:*):void;
		
		/**
		 * リストの最初の要素を削除する。
		 */
		function removeFirst():void;
		
		/**
		 * リストの最後の要素を削除する。
		 */
		function removeLast():void;
		
		/**
		 * リストの全ての要素を削除する。
		 */
		function removeAll():void;
		
		
		//
		// スタックインタフェース
		//
		
		/**
		 * （リストをスタックと見たときの）トップ要素を返す。
		 * @return
		 */
		function top():*;
		
		/**
		 * スタックに要素をプッシュする。
		 * @param	item
		 */
		function push(item:*):void;
		
		/**
		 * スタックから要素をポップする。
		 * @return
		 */
		function pop():*;
		
		
		function clone():*;
		function destroy():void;
		function toString():String;
		
	}
}