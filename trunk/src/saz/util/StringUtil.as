package saz.util {
	import flash.net.URLRequest;
	
	/**
	 * Stringユーティリティ。
	 * @author saz
	 */
	public class StringUtil {
		
		/**
		 * CR。0x0D。
		 */
		static public var CR:String = String.fromCharCode(13);	//0x0D
		/**
		 * LF。0x0A。
		 */
		static public var LF:String = String.fromCharCode(10);	//0x0A
		
		
		/**
		 * 指定URLがローカルかどうか. ＝"file:///"を含むかどうか. 
		 * @param	urlStr	URL文字列.
		 * @return
		 */
		static public function isLocal(urlStr:String):Boolean {
			//trace(urlStr.indexOf("file:///"));
			return ( 0 == urlStr.indexOf("file:///"));
		}
		
		/**
		 * 文字列の置換. 
		 * 廃止予定だったけど、String.replace()が1回しか置換してくれないので存続. 
		 * @param	target
		 * @param	search
		 * @param	replace
		 * @return
		 */
		static public function replace(target:String, search:String, replace:String):String {
			return target.split(search).join(replace);
		}
		
		
		
		//--------------------------------------
		// 数字
		//--------------------------------------
		
		/**
		 * 
		 * @param	value
		 * @return
		 */
		static public function addComma(value:Object):String {
			var str:String = value.toString();
			
			if (str.slice(0, 1) == "-") {
				//負
				return "-"+addComma(str.slice(1));
			}
			if (str.indexOf(".") > -1) {
				//小数点を含む
				var arr:Array = str.split(".");
				return $addCommaPositiveInt(arr[0], 3) + "." + arr[1];
			}
			return $addCommaPositiveInt(str, 3);
		}
		
		/**
		 * 
		 * @param	str	正の整数
		 * @param	len	カンマを入れる間隔
		 * @return
		 */
		static private function $addCommaPositiveInt(str:String, len:Number = 3, sep:String = ","):String {
			if (str.length > len) {
				//再帰
				return arguments.callee(str.slice(0, -len), len) + sep + str.slice( -len);
			}else{
				return str;
			}
		}
		
		/**
		 * 余分な"0"を削除。ゼロサプレス。
		 * @param	value	対象とする数字
		 * @return	String
		 */
		//static public function zeroSuppress(target:String):String {
		static public function zeroSuppress(value:Object):String {
			return parseInt(value.toString(), 10).toFixed();
		}
		
		/**
		 * "0"で埋める。ゼロパディング。
		 * @param	value	対象とする数字
		 * @param	digit	桁数。ただし30以下であること。
		 * @return	String
		 */
		//static public function zeroPadding(value:String, digit:int):String {
		static public function zeroPadding(value:Object, digit:int):String {
			if (digit > 30) throw new Error("桁数が大きすぎる");
			// Math.pow(10, 2) = 100 ただし20桁まで。"1e+21"になっちゃう。
			// Math.pow(10, digit).toFixed()でいける。ただしdigit=33から計算誤差。
			// Math.pow(10, 33).toFixed() = "1000000000000000100000000000000000";
			// "0123456789".slice(-4) = "6789"
			return (Math.pow(10, digit).toFixed() + value.toString()).slice( -digit);
		}
		
		/**
		 * Web形式カラー値をNumberに変換
		 * @param	hcolor	"#FF00CC"
		 * @return
		 */
		static public function hexColorToNumber(hcolor:String):Number {
			return parseInt(replace(hcolor, "#", ""), 16);
		}
		
		
		
		//--------------------------------------
		// convert
		//--------------------------------------
		
		/**
		 * 可能ならNumberに変換、無理ならStringで返す. 
		 * @param	value
		 * @return
		 */
		static public function asNumber(value:Object):*{
			// http://cuaoar.jp/2006/01/is.html
			var str:String = value.toString();
			var num = Number(str);
			return isNaN(num) ? str : num;
		}
		
		static private const $asB:Object = { _true:true, _false:false };
		
		/**
		 * 可能ならBooleanに変換、無理ならStringで返す. 
		 * "true","TRUE","True" -> true
		 * @param	value	
		 * @return
		 */
		static public function asBoolean(value:Object):*{
			var key:String = "_" + value.toString().toLowerCase();
			return ( key in $asB) ? $asB[key] : value.toString();
		}
		
		/**
		 * URLRequestを文字列表現にして返す. クエリーを開きたいときに. 
		 * @param	req
		 * @return
		 */
		static public function URLRequestToString(req:URLRequest):String {
			return (null == req.data) ? req.url : req.url + "?" + req.data.toString();
		}
		
		
		//--------------------------------------
		// 廃止
		//--------------------------------------
		
		/**
		 * Dateを文字列表現にして返す。DateUtilに移動。
		 * @deprecated	DateUtilに移動。
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
		static public function dateToString(date:Date, sep:String = "", isYear:Boolean = true, isMonth:Boolean = true, isDate:Boolean = true, isHour:Boolean = true, isMinute:Boolean = true, isSecond:Boolean = true, isMillisecound:Boolean = false):String {
			return DateUtil.dateToString(date, sep, isYear, isMonth, isDate, isHour, isMinute, isSecond, isMillisecound);
		}
			
		//static public function dateToString(date:Date, sep:String="", isYear:Boolean = true, isMonth:Boolean = true, isDate:Boolean = true, isHour:Boolean = true, isMinute:Boolean = true, isSecond:Boolean = true, isMillisecound:Boolean = false):String {
			//var res:/*String*/Array = new Array();
			//if (isYear) res.push( zeroPadding(String(date.getFullYear()), 4));
			//if (isMonth) res.push( zeroPadding(String(date.getMonth()), 2));
			//if (isDate) res.push( zeroPadding(String(date.getDate()), 2));
			//if (isHour) res.push( zeroPadding(String(date.getHours()), 2));
			//if (isMinute) res.push( zeroPadding(String(date.getMinutes()), 2));
			//if (isSecond) res.push( zeroPadding(String(date.getSeconds()), 2));
			//if (isMillisecound) res.push( zeroPadding(String(date.getMilliseconds()), 3));
			//return res.join(sep);
		//}
		
	}
	
}