package saz.util {
	/**
	 * Dateユーティリティー
	 * @author saz
	 */
	public class DateUtil{
		
		/**
		 * 1 ミリ秒をミリ秒単位で表した定数。
		 */
		public static const TIME_MILLISECOND:int = 1;
		/**
		 * 1 秒をミリ秒単位で表した定数。
		 */
		public static const TIME_SECOND:int = TIME_MILLISECOND * 1000;
		/**
		 * 1 分をミリ秒単位で表した定数。
		 */
		public static const TIME_MINUTE:int = TIME_SECOND * 60;
		/**
		 * 1 時間をミリ秒単位で表した定数。
		 */
		public static const TIME_HOUR:int = TIME_MINUTE * 60;
		/**
		 * 1 日をミリ秒単位で表した定数。
		 */
		public static const TIME_DATE:int = TIME_HOUR * 24;
		
		/**
		 * Dateループサンプル。
		 * @example <listing version="3.0" >
		 * var startDate = new Date(2010,4,29,15,50);
		 * var endDate = new Date(2010,4,29,17,50);
		 * // startDate非破壊
		 * for(var d:Date = DateUtil.clone(startDate); d < endDate; d.setMinutes(d.getMinutes() + 1)) {
		 * 	trace(d);
		 * }
		 * </listing>
		 */
		public function DateUtil() {
		}
		
		/**
		 * Dateインスタンスを複製する。
		 * @param	d
		 * @return
		 */
		public static function clone(d:Date):Date {
			//trace(d.getTime(), new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getMilliseconds()).getTime());
			return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getMilliseconds());
		}
		
		
	}

}