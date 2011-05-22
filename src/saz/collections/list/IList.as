package saz.collections.list {
	import saz.collections.enumerator.IEnumerator;
	import saz.ICore;
	
	/**
	 * 新Listインターフェース. （.NET IListのタイニー版）
	 * @author saz
	 * @see	http://msdn.microsoft.com/ja-jp/library/5y536ey6.aspx
	 */
	public interface IList extends ICollection {
		
		// http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/List.html
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		
		/**
		 * 指定したインデックス位置の要素を取得します。
		 * @param	index	0から始まる整数値。
		 * @return
		 */
		function get(index:int):*;
		
		/**
		 * 指定したインデックス位置の要素を設定します。
		 * @param	index	0から始まる整数値。
		 * @param	item	設定する要素。
		 * @return
		 */
		function set(index:int, item:*):void;
		
		
		
		
		/**
		 * 指定したインデックスの位置に要素を挿入します。
		 * @param	index	item を挿入する位置の 0 から始まるインデックス。
		 * @param	item	挿入するオブジェクト。
		 */
		function insert(index:int, item:*):void;
		
		
		/**
		 * 指定したインデックスにある要素を削除します。
		 * @param	index
		 */
		function removeAt(index:int):void;
		
		
		/**
		 * 厳密な等価 (===) を使用して指定したオブジェクトを検索し、最初に見つかった位置の 0 から始まるインデックスを返します。
		 * @param	item	検索するオブジェクト。
		 * @return	全体内で item が見つかった場合は、最初に見つかった位置の 0 から始まるインデックス。それ以外の場合は –1。
		 */
		function indexOf(item:*):int;
		
		/**
		 * 厳密な等価 (===) を使用して指定したオブジェクトを検索し、最後に見つかった位置の 0 から始まるインデックスを返します。
		 * @param	item	検索するオブジェクト。
		 * @return	全体内で item が見つかった場合は、最後に見つかった位置の 0 から始まるインデックス。それ以外の場合は –1。
		 */
		//function lastIndexOf(item:*):int;
		
		
		/**
		 * 要素を新しい配列にコピーします。
		 * @return	要素のコピーを格納する配列。
		 */
		//function toArray():Array;
		
		/**
		 * 現在のオブジェクトを表す文字列を返します。
		 * @return	現在のオブジェクトを説明する文字列。
		 */
		//function toString():String;
		
		
		/* mid */
		
		/**
		 * ある範囲の要素の簡易コピーを作成します。
		 * @param	index	範囲の開始位置となる、0 から始まるインデックス。
		 * @param	count	範囲内の要素の数。
		 * @return	ある範囲の要素の簡易コピー。
		 */
		//function getRange(index:int, count:int):IList;
		
		/**
		 * 指定したコレクションの要素を末尾に追加します。
		 * @param	collection	追加するコレクション。
		 */
		//function addRange(enum:IEnumerator):void;
		
		/**
		 * コレクションの要素を指定したインデックスの位置に挿入します。
		 * @param	index	新しい要素が挿入される位置の 0 から始まるインデックス。
		 * @param	collection	挿入するコレクション。 
		 */
		//function insertRange(index:int, enum:IEnumerator):void;
		
		/**
		 * 要素の範囲を削除します。
		 * @param	index	削除する要素の範囲の開始位置を示す 0 から始まるインデックス。
		 * @param	count	削除する要素の数。
		 */
		//function removeRange(index:int, count:int):void;
		
		
		/* rich */
		
		/**
		 * 条件に一致するすべての要素を削除します。
		 * @param	match	Booleanを返すFunction. ex. function(item:*):Boolean{
		 * @return
		 */
		//function removeAll(match:Function):int;
		
		
		
	}
}