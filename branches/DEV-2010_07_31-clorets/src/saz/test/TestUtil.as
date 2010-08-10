package saz.test {
	/**
	 * テスト用ユーティリティー
	 * @author saz
	 */
	public class TestUtil{
		
		/**
		 * 指定したFunctionの実行時間を計測して返す。
		 * @param	func	計測する関数。
		 * @return	msec。
		 */
		static public function benchMark(func:Function):Number {
			var start:Number, end:Number;
			start = new Date().time;
			func();
			end = new Date().time;
			return (end - start);
		}
		
		/**
		 * 指定したFunctionの実行時間を計測し、文字列に整形して返す。
		 * @param	func
		 * @return	msec。
		 */
		static public function stringBenchMark(func:Function, format:String="Time: %rms"):String {
			//return "Time: " + benchMark(func) + "ms";
			return format.replace("%r", "" + benchMark(func));
		}
		
		/**
		 * 指定したFunctionを指定回数実行し、実行時間を計測して返す。ただし関数呼び出しのオーバーヘッドがあるので、非推奨。
		 * @param	func	計測する関数。
		 * @param	count	実行回数。
		 * @return	msec。
		 */
		static public function benchMarkLoop(func:Function, count:uint = 1):Number {
			var start:Number, end:Number;
			start = new Date().time;
			while (count > 0) {
				func();
				count--;
			}
			end = new Date().time;
			return (end - start);
		}
		
	}

}