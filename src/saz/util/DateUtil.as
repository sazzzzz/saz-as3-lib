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
		
		/**
		 * Dateを文字列表現にして返す
		 * @deprecated	これ汎用性ないな。廃止しよう。
		 * @param	date	Dateインスタンス。
		 * @param	sep	セパレータ。省略すると空文字。
		 * @param	isYear	年を出力するかどうか。デフォルトはtrue。
		 * @param	isMonth	月を出力するかどうか。デフォルトはtrue。
		 * @param	isDate	日付を出力するかどうか。デフォルトはtrue。
		 * @param	isHour	時間を出力するかどうか。デフォルトはtrue。
		 * @param	isMinute	分を出力するかどうか。デフォルトはtrue。
		 * @param	isSecond	秒を出力するかどうか。デフォルトはtrue。
		 * @param	isMillisecound	ミリ秒を出力するかどうか。デフォルトはfalse。
		 * @return	String
		 */
		public static function dateToString(date:Date, sep:String="", isYear:Boolean = true, isMonth:Boolean = true, isDate:Boolean = true, isHour:Boolean = true, isMinute:Boolean = true, isSecond:Boolean = true, isMillisecound:Boolean = false):String {
			var res:/*String*/Array = new Array();
			if (isYear) res.push( StringUtil.zeroPadding(String(date.getFullYear()), 4));
			if (isMonth) res.push( StringUtil.zeroPadding(String(date.getMonth()), 2));
			if (isDate) res.push( StringUtil.zeroPadding(String(date.getDate()), 2));
			if (isHour) res.push( StringUtil.zeroPadding(String(date.getHours()), 2));
			if (isMinute) res.push( StringUtil.zeroPadding(String(date.getMinutes()), 2));
			if (isSecond) res.push( StringUtil.zeroPadding(String(date.getSeconds()), 2));
			if (isMillisecound) res.push( StringUtil.zeroPadding(String(date.getMilliseconds()), 3));
			return res.join(sep);
		}
		
	}

}