package saz.errors {
	/**
	 * コレクションにそれ以上要素がない場合にスローされます。
	 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/Iterator.html
	 * @author saz
	 */
	public class NoSuchElementError extends Error{
		
		public function NoSuchElementError(message:String = "", id:int = 0) {
			super(message, id);
		}
		
	}

}