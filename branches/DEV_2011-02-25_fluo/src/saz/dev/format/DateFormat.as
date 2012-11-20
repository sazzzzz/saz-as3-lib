package saz.dev.format {
	/**
	 * Dateフォーマッタ.
	 * @author saz
	 * @see	http://www.adobe.com/livedocs/flex/3_jp/langref/index.html?mx/formatters/package-detail.html&mx/formatters/class-list.html
	 */
	public class DateFormat{
		
		
		//private static const VALID_PATTERN_CHARS:String = "Y,M,D,A,E,H,J,K,L,N,S";
		private static const VALID_PATTERN_CHARS:String = "YMDAEHJKLNS";
		
		private var $formatString:String;
		
		public function DateFormat() {
			
		}
		
		/**
		 * 日付形式のストリングまたは Date オブジェクトから日付形式のストリングを生成します。
		 * @param	value
		 * @return
		 */
		public function format(value:Object):String {
			
		}
		
		/**
		 * ストリングとしてフォーマットした日付を Date オブジェクトに変換します。
		 * @param	str
		 * @return
		 */
		public function parseDateString(str:String):Date {
			
		}
		
		/**
		 * マスクパターンを表します。
		 */
		public function get formatString():String { return $formatString; }
		
		public function set formatString(value:String):void {
			$formatString = value;
		}
		
		
		
		
		
	}

}