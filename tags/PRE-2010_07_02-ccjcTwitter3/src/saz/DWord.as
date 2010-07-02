package saz {
	
	/**
	 * ダブルワード。ビット操作用クラス。<br/>
	 * 演算ができない。ローテートができない。<br/>
	 * @see	http://www.wdic.org/w/TECH/ビット演算
	 * @see	http://www1.cts.ne.jp/~clab/hsample/Bit/Bit2.html
	 * @see	http://docs.sun.com/app/docs/doc/820-1201/6ncsv9nl6?l=ja&a=view
	 * @author saz
	 */
	//public class DWord extends Number {
	public class DWord {
		
		/**
		 * 最小値
		 */
		public static var MIN:Number = 0;
		/**
		 * 最大値
		 */
		public static var MAX:Number = Math.pow(2, 32);
		/**
		 * ビット桁数
		 */
		public var length:Number = 32;
		
		private var $value:Number = 0;
		
		
		
		/**
		 * コンストラクタ
		 * @param	num	小数点以下切り捨て。0～4294967295(0xFFFFFFFF)に丸め。
		 */
		function DWord(num:Number) {
			setValue(num);
		}
		
		/**
		 * ビットパターン表示を返す。
		 * @return
		 */
		public function toString():String {
			//trace("toString(");
			var rs:String = "";
			for (var i:Number = 0, l:Number = length; i < l; i++) {
				rs = (getBit(i)?"1":"0") + rs;
			}
			return rs;
		}
		
		/**
		 * 値を返す。
		 * @return
		 */
		public function getValue():Number {
			return $value;
		}
		
		/*public function valueOf():Number {
			return getValue();
		}*/
		
		/**
		 * 値をセット。
		 * @param	value
		 */
		public function setValue(num:Number):void {
			num = Math.floor(num);
			if (num > DWord.MAX) num = DWord.MAX;
			if (num < DWord.MIN) num = DWord.MIN;
			//super(num);
			$value = num;
		}
		
		
		/**
		 * 指定ビットを検査し、1であればtrue、0であればfalseを返す。
		 * @param	bitnum	ビット指定。0～
		 * @return	1であればtrue、0であればfalseを返す。
		 */
		public function getBit(bitnum:Number):Boolean {
			var rs:Number = $value & getMask(bitnum);
			return (rs != 0);
		}
		
		/**
		 * ビットをセットする。
		 * @param	bitnum	ビット指定。0～
		 * @param	state	立てるときはtrue、クリアするときはfalseを指定。
		 */
		public function setBit(bitnum:Number, state:Boolean):void {
			//trace("setBit(" + arguments);
			//trace(getBitPattern($value));
			//trace(getBitPattern($value));
			if (state) {
				// 立てる
				$value = $value | getMask(bitnum);
			}else {
				// クリア
				$value = $value ^ getMask(bitnum);		// XOR
			}
		}
		
		/**
		 * 左シフト
		 * @param	bits
		 */
		public function lshift(bits:Number):void {
			$value = $value << bits;
		}
		
		/**
		 * 右シフト（符号なし）
		 * @param	bits
		 */
		public function rshift(bits:Number):void {
			$value = $value >>> bits;
		}
		
		/**
		 * マスク用Numberを返す。
		 * @param	bits
		 * @return
		 */
		private function getMask(bitnum:Number):Number {
			//trace(getBitPattern(Math.pow(2, bitnum)));
			return Math.pow(2, bitnum);
		}
		
		/**
		 * （テスト用）ビットパターンを返す。
		 * @param	num
		 * @return
		 */
		public static function getBitPattern(num:Number):String {
			//trace("getBitPattern(" + arguments);
			var rs:String = "";
			for (var i:Number = 0, l:Number = 32; i < l; i++) {
				rs = (((num & Math.pow(2, i)) != 0) ? "1" : "0") + rs;
			}
			return rs;
		}
		
	}
	
}