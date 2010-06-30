package saz.errors {
	
	/**
	 * イテレータ脱出用クラス
	 * @author saz
	 */
	public class IteratorBreakError extends Error {
		
		public function IteratorBreakError(message:String = "", id:int = 0) {
			super(message, id);
		}
		
	}
	
}