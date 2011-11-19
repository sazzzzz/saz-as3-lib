package saz.dev {
	/**
	 * 型つき値保持クラス. <br/>
	 * ValueHolderを型指定したくて作ってみたけど、インターフェースが違うから意味なさそう. 
	 * @author saz
	 */
	public class TypedValueHolder extends ValueHolder {
		
		public function TypedValueHolder(value:*, name:String = "") {
			super(value, name);
		}
		
		
		/**
		 * Booleanを取得する. 
		 */
		public function get asBoolean():Boolean {
			return value as Boolean;
		}
		
		/**
		 * Booleanを設定する. 
		 */
		public function set asBoolean(val:Boolean):void {
			value = val;
		}
		
		
		/**
		 * intを取得する. 
		 */
		public function get asInt():int {
			return value as int;
		}
		
		/**
		 * intを設定する. 
		 */
		public function set asInt(val:int):void {
			value = val;
		}
		
		
		/**
		 * uintを取得する. 
		 */
		public function get asUint():uint {
			return value as uint;
		}
		
		/**
		 * uintを設定する. 
		 */
		public function set asUint(val:uint):void {
			value = val;
		}
		
		
		/**
		 * Numberを取得する. 
		 */
		public function get asNumber():Number {
			return value as Number;
		}
		
		/**
		 * Numberを設定する. 
		 */
		public function set asNumber(val:Number):void {
			value = val;
		}
		
		
		/**
		 * Stringを取得する. 
		 */
		public function get asString():String {
			return value as String;
		}
		
		/**
		 * Stringを設定する. 
		 */
		public function set asString(val:String):void {
			value = val;
		}
		
		
		
		
		
		override public function toString():String {
			return "[TypedValueHolder: " + value + "]";
		}
		
	}

}