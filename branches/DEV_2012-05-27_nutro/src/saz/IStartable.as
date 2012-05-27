package saz {
	
	/**
	 * 処理開始／停止をコントロールするインターフェース.
	 * @author saz
	 */
	public interface IStartable {
		
		/**
		 * 処理開始.
		 */
		function start():void;
		
		/**
		 * 処理停止. 
		 */
		function stop():void;
	}
	
}