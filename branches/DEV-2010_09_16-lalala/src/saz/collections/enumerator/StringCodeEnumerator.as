package saz.collections.enumerator {
	/**
	 * Stringの1文字ずつの文字コードを、要素として扱うEnumerator。
	 * @author saz
	 */
	public class StringCodeEnumerator extends Enumerator{
		
		/**
		 * コンストラクタ。
		 * @param	component	対象とするString。
		 * @example <listing version="3.0" >
		 * var s1:String = "Stringの1文字ずつの文字コードを、要素として扱うEnumerator。";
		 * var enum1:StringCodeEnumerator = new StringCodeEnumerator(s1);
		 * trace(enum1.select(function(item:Number, index:int):Boolean{
		 * 	return item<256;
		 * }));
		 * </listing>
		 */
		public function StringCodeEnumerator(component:String) {
			super(component);
		}
		
		/**
		 * @copy	Enumerator#forEach
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			for (var i:int = 0, len:int = String($component).length, item:Number; i < len; i++) {
				item = String($component).charCodeAt(i);
				callback.apply(thisObject, [item, i, String($component)]);
			}
		}
		
	}

}