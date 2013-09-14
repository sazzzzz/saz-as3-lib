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
		
		
		public static const DAY_TABLE_JP_SHORT:Array = ["日", "月", "火", "水", "木", "金", "土"];
		public static const DAY_TABLE_EN_SHORT:Array = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		
		
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
		
		
		public static const YEAR:int = 0;
		public static const MONTH:int = 1;
		public static const DATE:int = 2;
		public static const HOUR:int = 3;
		public static const MINUTE:int = 4;
		public static const SECOND:int = 5;
		public static const MILLISECOND:int = 6;
		
		
		
		/**
		 * キャッシュクリア用のDateを返す。
		 * 
		 * @param type	Dateプロパティのうちどこまで利用するか。ex.YEAR。
		 * @param date	元になるDate。デフォルトはnew Date()つまり、現在時刻。
		 * @return 
		 * 
		 */
		public static function noCache(type:int=HOUR, date:Date=null):Date
		{
			var d:Date = date || new Date();
			switch(type)
			{
				case YEAR:
					throw new ArgumentError("type = YEARはサポートされません。");
				case MONTH:
					return new Date(d.fullYear, d.month);
				case DATE:
					return new Date(d.fullYear, d.month, d.date);
				case HOUR:
					return new Date(d.fullYear, d.month, d.date, d.hours);
				case MINUTE:
					return new Date(d.fullYear, d.month, d.date, d.hours, d.minutes);
				case SECOND:
					return new Date(d.fullYear, d.month, d.date, d.hours, d.minutes, d.seconds);
				case MILLISECOND:
				default:
			}
			return new Date(d.fullYear, d.month, d.date, d.hours, d.minutes, d.seconds, d.milliseconds);
		}
		
		/**
		 * Dateから生成したキャッシュクリア用のStringを返す。なんでこっちをデフォルトにしなかったんだろう…
		 * @param type
		 * @param date
		 * @return 
		 * 
		 */
		public static function noCacheString(type:int=HOUR, date:Date=null):String
		{
			return noCache(type, date).time.toString();
		}
		
		
		/**
		 * Dateインスタンスを複製する。
		 * @param	d
		 * @return
		 */
		public static function clone(d:Date):Date {
			//trace(d.getTime(), new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getMilliseconds()).getTime());
			/*return new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds(), d.getMilliseconds());*/
			return new Date(d.time);
		}
		
		/**
		 * ミリ秒を日時分秒に変換。
		 * @param	time	ミリ秒。
		 * @return	日時分秒を格納したObject。{ date:日, hours:時, minutes:分, seconds:秒, milliseconds:ミリ秒 }。
		 */
		public static function timeToObject(time:Number):Object {
			return {
				date:Math.floor(time / TIME_DATE)
				,hours:Math.floor(time / TIME_HOUR) % 24
				,minutes:Math.floor(time / TIME_MINUTE) % 60
				,seconds:Math.floor(time / TIME_SECOND) % 60
				,milliseconds:time % TIME_SECOND
			};
			/*return {
				date:Math.floor(time / (24 * 60 * 60 * 1000))
				,hours:Math.floor(time / (60 * 60 * 1000)) % 24
				,minutes:Math.floor(time / (60 * 1000)) % 60
				,seconds:Math.floor(time / 1000) % 60
				,milliseconds:time % 1000
			};*/
		}
		
		/**
		 * Dateを文字列表現にして返す
		 * @deprecated	これ汎用性ないな。廃止しよう。
		 * @param	date	Dateインスタンス。
		 * @param	sep	セパレータ。省略すると空文字。
		 * @param	isYear	年を出力するかどうか。
		 * @param	isMonth	月を出力するかどうか。
		 * @param	isDate	日付を出力するかどうか。
		 * @param	isHour	時間を出力するかどうか。
		 * @param	isMinute	分を出力するかどうか。
		 * @param	isSecond	秒を出力するかどうか。
		 * @param	isMillisecound	ミリ秒を出力するかどうか。
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