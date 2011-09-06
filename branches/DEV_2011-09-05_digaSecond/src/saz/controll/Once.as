package saz.controll {
	import saz.IRunnable;
	/**
	 * 1回だけ実行する.
	 * @author saz
	 */
	public class Once implements IRunnable {
		
		/**
		 * 実行したい処理内容を設定. 
		 */
		public function get atRun():Function {
			return _atRun;
		}
		public function set atRun(value:Function):void {
			_atRun = value;
			_runned = false;
		}
		private var _atRun:Function;
		
		private var _runned:Boolean = false;
		
		
		/**
		 * コンストラクタ. 
		 * @param	runFunc	atRunに設定. 
		 */
		public function Once(runFunc:Function = null) {
			if (runFunc != null) atRun = runFunc;
		}
		
		/* INTERFACE saz.IRunnable */
		
		// こっちのシンプルな実装のほうが早い！関数呼び出しのオーバーヘッドが大きいのか？
		// 47,48
		public function run():void {
			if (_runned) return;
			_atRun();
			_runned = true;
		}
		
	}
	
	
	// 102
	/*public class Once {
		
		private var _runned:Boolean = false;
		private var _runFunc:Function;
		
		public function get atRun():Function {
			return _atRun;
		}
		
		public function set atRun(value:Function):void {
			_runned = false;
			_atRun = value;
			
			_runFunc = function():void {
				trace("_runFunc");
				_runned = true;
				_atRun();
				//_runFunc = function():void { };		// 116, さらに遅くなった
			}
		}
		private var _atRun:Function;
		
		public function Once(func:Function = null) {
			if (func != null) atRun = func;
		}
		
		public function run():void {
			_runFunc();
		}
		
		private function _doNothing():void { }
		
	}*/

}