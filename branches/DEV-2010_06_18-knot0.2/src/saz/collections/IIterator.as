package saz.collections {
	
	/**
	 * Iterator インターフェース。
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
		 * @return
		 */
		public function hasNext():Boolean;
		
		/**
		 * 次の要素を取得。
		 * @return
		 */
		public function next():*;
		
		/**
		 * next()で取得した要素を削除する。
		 */
		public function remove():void;
	}
	
}