package saz.collections.iterator {
	
	/**
	 * Iterator インターフェース.
	 * current()は実装しないぞ.　関数で遅いので「あえて」実装しない. 参照を自分で保持してね.
	 * @see	java.util.Iterator インターフェース と同じ。
	 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/Iterator.html
	 * @see	http://www.javainthebox.net/publication/200209JP26API/Iterator.html
	 * @author saz
	 * @example <listing version="3.0" >
	 * var item:Foo, i:int = 0;
	 * while (iterator.hasNext()) {
	 * 	item = Foo(iterator.next());
	 * 	item.bar();
	 * 	i++;
	 * }
	 * </listing>
	 */
	public interface IIterator {
		
		/**
		 * 次の要素があるかどうか。
		 * @return	繰り返し処理でさらに要素がある場合に true を返します。
		 */
		function hasNext():Boolean;
		
		/**
		 * 次の要素を取得。
		 * それ以上要素がない場合はエラー。
		 * @return
		 */
		function next():*;
		
		/**
		 * 最初の要素に戻す。
		 * IteratorEnumeratorのために、.NETのIEnumerator風にしてみる。
		 */
		function reset():void;
		
		/**
		 * （このメソッドはオプションです.）next()で、最後に取得した要素を削除する。
		 * このメソッドは、next の呼び出しごとに 1 回だけ呼び出すことができます。
		 * 反復子の動作は、繰り返し処理がこのメソッドの呼び出し以外の方法で実行されているときに基になるコレクションが変更された場合は保証されません。
		 * remove()をサポートしない場合はエラー。
		 * next()が呼び出されていないか、最後のnext()の後にすでにremove()が実行されている場合もエラー。
		 */
		function remove():void;
	}
	
}