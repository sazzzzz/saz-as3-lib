package saz {
	
	/**
	 * 単発の処理を実行するインターフェース.
	 * @author saz
	 */
	public interface IRunnable {
		
		/**
		 * 実行可能かどうか. 
		 */
		function get runnable():Boolean;
		
		/**
		 * （何かを）実行する. 
		 */
		function run():void;
	}
	
}