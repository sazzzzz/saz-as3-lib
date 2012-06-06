package saz.util {
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	/**
	 * Stringユーティリティ。
	 * @author saz
	 */
	public class StringUtil {
		
		private static const KEY2STR_TBL:Object = {
			48:"0",		// フルキーの0
			49:"1",
			50:"2",
			51:"3",
			52:"4",
			53:"5",
			54:"6",
			55:"7",
			56:"8",
			57:"9",
			96:"0",		// Keyboard.NUMPAD_0:"0",
			97:"1", 	// Keyboard.NUMPAD_1:"1",
			98:"2",		// Keyboard.NUMPAD_2:"2",
			99:"3",		// Keyboard.NUMPAD_3:"3",
			100:"4",	// Keyboard.NUMPAD_4:"4",
			101:"5",	// Keyboard.NUMPAD_5:"5",
			102:"6",	// Keyboard.NUMPAD_6:"6",
			103:"7",	// Keyboard.NUMPAD_7:"7",
			104:"8",	// Keyboard.NUMPAD_8:"8",
			105:"9",	// Keyboard.NUMPAD_9:"9",
			0:""
		};
		
		/**
		 * CR。0x0D。
		 */
		public static var CR:String = String.fromCharCode(13);	//0x0D
		/**
		 * LF。0x0A。
		 */
		public static var LF:String = String.fromCharCode(10);	//0x0A
		
		
		/**
		 * キーコードから対応するStringを返す. とりあえずフルキーの0~9とテンキーの0~9のみ. 
		 * @param	kcode	キーコード. 
		 * @return	String. 
		 */
		public static function fromKeyCode(kcode:uint):String {
			var res:String = KEY2STR_TBL[kcode];
			return res == null ? "" : res;
		}
		
		
		
		/**
		 * 指定URLがローカルかどうか. ＝"file:///"を含むかどうか. 
		 * @param	urlStr	URL文字列.
		 * @return
		 */
		public static function isLocal(urlStr:String):Boolean {
			//trace(urlStr.indexOf("file:///"));
			return ( 0 == urlStr.indexOf("file:///"));
		}
		
		
		
		
		
		/**
		 * スネークケース（アンダーバー区切り）をスペース区切りに。
		 * @param value
		 * @return 
		 */
		public static function snakeCaseToSpaceSeparated(value:String):String{
			return value.split("_").join(" ");
		}
		
		/**
		 * スペース区切りをパスカルケース（単語の頭大文字）に。
		 * @param value
		 * @return 
		 */
		public static function spaceSeparatedToPascalCase(value:String):String
		{
			var arr:Array = value.split(" ");
			for (var i:int = 0, n:int = arr.length; i < n; i++) 
			{
				arr[i] = toTitleCase(arr[i]);
			}
			return arr.join(""); 
		}
		
		/**
		 * スネークケースをパスカルケースに。
		 * @param value
		 * @return 
		 */
		public static function snakeCaseToPascalCase(value:String):String
		{
			return spaceSeparatedToPascalCase(snakeCaseToSpaceSeparated(value));
		}
		
		
		
		/**
		 * 頭文字だけ大文字、他は小文字に. 
		 * @param	value	文字列. 
		 * @return
		 */
		public static function toTitleCase(value:String):String {
			return value.substr(0, 1).toUpperCase() + value.substr(1).toLowerCase();
		}
		
		
		
		/**
		 * 左端から指定された長さの文字をコピーし、Stringにして返す. 
		 * @param	target	対象とするString
		 * @param	len	抜き出す長さ
		 * @return
		 */
		public static function left(target:String, len:int):String {
			return target.substr(0, len);
		}
		
		/**
		 * 右端から指定された長さの文字をコピーし、Stringにして返す. 
		 * @param	target	対象とするString
		 * @param	len	抜き出す長さ
		 * @return
		 */
		public static function right(target:String, len:int):String {
			return target.substr( -len, len);
		}
		
		/**
		 * 改行を削除
		 * @param	targe
		 * @return
		 */
		public static function nonBreak(target:String):String {
			/*var res:String = "";
			for (var i:int = 0, n:int = target.length, l:String; i < n; i++) {
				l = target.substr(i, 1);
				if (l != "\n") res += l;
			}
			return res;*/
			// 置換の際はグローバルスイッチ「g」がないと、1回しかしてくれない
			return target.replace(/\n/g, "");
		}
		
		
		/**
		 * 文字列の置換. 
		 * 廃止予定だったけど、String.replace()が1回しか置換してくれないので存続. 
		 * @param	target
		 * @param	search
		 * @param	replace
		 * @return
		 */
		public static function replace(target:String, search:String, replace:String):String {
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
		public static function addComma(value:Object):String {
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
		//public static function zeroSuppress(target:String):String {
		public static function zeroSuppress(value:Object):String {
			return parseInt(value.toString(), 10).toFixed();
		}
		
		/**
		 * "0"で埋める。ゼロパディング。
		 * @param	value	対象とする数字
		 * @param	digit	桁数。ただし30以下であること。
		 * @return	String
		 */
		//public static function zeroPadding(value:String, digit:int):String {
		public static function zeroPadding(value:Object, digit:int):String {
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
		public static function hexColorToNumber(hcolor:String):Number {
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
		public static function asNumber(value:Object):*{
			// http://cuaoar.jp/2006/01/is.html
			var str:String = value.toString();
			var num:Number = Number(str);
			return isNaN(num) ? str : num;
		}
		
		static private const $asB:Object = { _true:true, _false:false };
		
		/**
		 * 可能ならBooleanに変換、無理ならStringで返す. 
		 * "true","TRUE","True" -> true
		 * @param	value	
		 * @return
		 */
		public static function asBoolean(value:Object):*{
			var key:String = "_" + value.toString().toLowerCase();
			return ( key in $asB) ? $asB[key] : value.toString();
		}
		
		/**
		 * URLRequestを文字列表現にして返す. クエリーを開きたいときに. 
		 * @param	req
		 * @return
		 */
		public static function URLRequestToString(req:URLRequest):String {
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
		public static function dateToString(date:Date, sep:String = "", isYear:Boolean = true, isMonth:Boolean = true, isDate:Boolean = true, isHour:Boolean = true, isMinute:Boolean = true, isSecond:Boolean = true, isMillisecound:Boolean = false):String {
			return DateUtil.dateToString(date, sep, isYear, isMonth, isDate, isHour, isMinute, isSecond, isMillisecound);
		}
			
		//public static function dateToString(date:Date, sep:String="", isYear:Boolean = true, isMonth:Boolean = true, isDate:Boolean = true, isHour:Boolean = true, isMinute:Boolean = true, isSecond:Boolean = true, isMillisecound:Boolean = false):String {
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