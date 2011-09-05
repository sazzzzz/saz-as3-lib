package saz.test {
	import flash.system.System;
	import saz.util.StringUtil;
	/**
	 * テスト用ユーティリティー。
	 * @author saz
	 * @see	http://wonderfl.net/c/xCUo/
	 */
	public class TestUtil {
		
		//public static const FORMAT_BENCH_MEMORY:String = "Memory: %m bytes";
		public static const FORMAT_BENCH_TIME:String = "Time: %t ms";
		public static const FORMAT_BENCH:String = "Memory: %m bytes\rTime: %t ms";
		
		/**
		 * 指定したFunctionの実行時間を計測して返す。
		 * @param	func	計測する関数。
		 * @return	msec。
		 */
		public static function meansureTime(func:Function):Number {
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
		//public static function formatMeansureTime(func:Function, format:String="Time: %tms"):String {
		public static function formatMeansureTime(func:Function, format:String = FORMAT_BENCH_TIME):String {
			return format.replace("%t", "" + meansureTime(func));
		}
		
		
		/**
		 * 指定したFunctionを計測。
		 * @param	func	計測する関数。
		 * @return	実行時間とメモリ消費を返す。{ time:ttt, memory:mmm }
		 */
		public static function benchmark(func:Function):Object {
			var start:Number, end:Number;
			var smem:Number, emem:Number;
			smem = System.totalMemory;
			start = new Date().time;
			func();
			end = new Date().time;
			emem = System.totalMemory;
			return { time:end - start, memory:emem - smem };
		}
		
		/**
		 * 指定したFunctionを計測し、文字列に整形して返す。
		 * @param	func
		 * @return	msec。
		 */
		public static function formatBenchmark(func:Function, format:String = FORMAT_BENCH):String {
			var res:Object = benchmark(func);
			return format.replace("%m", StringUtil.addComma("" + res.memory)).replace("%t", StringUtil.addComma("" + res.time));
		}
		
		/**
		 * 指定したFunctionを指定回数実行し、実行時間を計測して返す。ただし関数呼び出しのオーバーヘッドがあるので、非推奨。
		 * @param	func	計測する関数。
		 * @param	count	実行回数。
		 * @return	msec。
		 */
		/*public static function benchmarkLoop(func:Function, count:uint = 1):Number {
			var start:Number, end:Number;
			start = new Date().time;
			while (count > 0) {
				func();
				count--;
			}
			end = new Date().time;
			return (end - start);
		}*/
		
	}

}