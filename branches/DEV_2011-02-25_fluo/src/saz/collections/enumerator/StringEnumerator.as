package saz.collections.enumerator {
	/**
	 * Stringの1文字ずつを、要素として扱うEnumerator。
	 * @author saz
	 */
	public class StringEnumerator extends Enumerator{
		
		/**
		 * コンストラクタ。
		 * @param	component	対象とするString。
		 * @example <listing version="3.0" >
		 * var s1:String = "Stringの1文字ずつを要素として扱うEnumerator。";
		 * var enum1:StringEnumerator = new StringEnumerator(s1);
		 * enum1.forEach(function(item:String, index:int, collection:String):void{
		 * 	trace(item);
		 * });
		 * </listing>
		 */
		public function StringEnumerator(component:String) {
			super(component);
		}
		
		/**
		 * 各要素について関数を実行します。
		 * @param	callback	各アイテムについて実行する関数です。
		 * function callback(item:*, index:int, collection:Object):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			for (var i:int = 0, len:int = String($component).length, item:String; i < len; i++) {
				item = String($component).substr(i, 1);
				callback.apply(thisObject, [item, i, String($component)]);
			}
		}
	}

}