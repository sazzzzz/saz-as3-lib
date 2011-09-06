package saz.controll {
	import saz.IRunnable;
	
	/**
	 * 指定回数だけ実行する.
	 * @author saz
	 */
	public class Repeat implements IRunnable {
		
		/**
		 * 実行したい処理内容を設定. 
		 */
		public function get atRun():Function {
			return _atRun;
		}
		public function set atRun(value:Function):void {
			_atRun = value;
			_count = 0;
		}
		private var _atRun:Function;
		
		/**
		 * （デフォルト＝1）実行する回数. 
		 */
		public function get times():int {
			return _times;
		}
		public function set times(value:int):void {
			_times = value;
		}
		private var _times:int = 1;
		
		private var _count:int = 0;
		
		/**
		 * コンストラクタ. 
		 * @param	runFunc	atRunに設定. 
		 * @param	runTimes	（デフォルト＝1）実行する回数. 
		 */
		public function Repeat(runFunc:Function = null, runTimes:int = 1) {
			if (runFunc != null) atRun = runFunc;
			times = runTimes;
		}
		
		/* INTERFACE saz.IRunnable */
		
		/**
		 * @copy	IRunnable#runnable
		 */
		public function get runnable():Boolean {
			return !(_times <= _count);
		}
		
		/**
		 * @copy	IRunnable#run
		 */
		public function run():void {
			if (_times <= _count) return;
			_atRun();
			_count++;
		}
		
		// イラネ
		/*public function reset():void {
			_count = 0;
		}*/
		
	}

}