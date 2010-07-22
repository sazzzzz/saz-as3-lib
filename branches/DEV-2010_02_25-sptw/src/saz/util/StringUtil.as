﻿package saz.util {
	
	/**
	 * Stringユーティリティ。
	 * @author saz
	 */
	public class StringUtil {
		
		/**
		 * 0x0D
		 */
		public static var CR:String = String.fromCharCode(13);	//0x0D
		/**
		 * 0x0A
		 */
		public static var LF:String = String.fromCharCode(10);	//0x0A
		
		/**
		 * Dateを文字列表現にして返す
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
			if (isYear) res.push( zeroPadding(String(date.getFullYear()), 4));
			if (isMonth) res.push( zeroPadding(String(date.getMonth()), 2));
			if (isDate) res.push( zeroPadding(String(date.getDate()), 2));
			if (isHour) res.push( zeroPadding(String(date.getHours()), 2));
			if (isMinute) res.push( zeroPadding(String(date.getMinutes()), 2));
			if (isSecond) res.push( zeroPadding(String(date.getSeconds()), 2));
			if (isMillisecound) res.push( zeroPadding(String(date.getMilliseconds()), 3));
			return res.join(sep);
		}
		
		/**
		 * 余分な"0"を削除。ゼロサプレス。
		 * @param	target	対象となるString型の数字
		 * @return	String型
		 */
		public static function zeroSuppress(target:String):String {
			return parseInt(target, 10).toFixed();
		}
		
		/**
		 * "0"で埋める。ゼロパディング。
		 * @param	target	対象となるString型の数字
		 * @param	digit	桁数。ただし30以下であること。
		 * @return	String型
		 */
		public static function zeroPadding(target:String, digit:int):String {
			if (digit > 30) throw new Error("桁数が大きすぎる");
			// Math.pow(10, 2) = 100 ただし20桁まで。"1e+21"になっちゃう。
			// Math.pow(10, digit).toFixed()でいける。ただしdigit=33から計算誤差。
			// Math.pow(10, 33).toFixed() = "1000000000000000100000000000000000";
			// "0123456789".slice(-4) = "6789"
			return (Math.pow(10, digit).toFixed() + target).slice( -digit);
		}
		
		/**
		 * Web形式カラー値をNumberに変換
		 * @param	hcolor	"#FF00CC"
		 * @return
		 */
		public static function hexColorToNumber(hcolor:String):Number {
			return parseInt(replace(hcolor, "#", ""), 16);
		}
		
		/**
		 * 文字列の置換
		 * @param	target
		 * @param	search
		 * @param	replace
		 * @return
		 */
		public static function replace(target:String, search:String, replace:String):String {
			return target.split(search).join(replace);
		}
		
	}
	
}