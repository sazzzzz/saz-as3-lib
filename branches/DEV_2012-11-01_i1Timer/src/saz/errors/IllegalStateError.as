package saz.errors {
	/**
	 * 不正または不適切なときにメソッドが呼び出されたことを示します。
	 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/Iterator.html
	 * @author saz
	 */
	public class IllegalStateError extends Error{
		
		public function IllegalStateError(message:String = "", id:int = 0) {
			super(message, id);
		}
		
	}

}