package saz.collections.enumerator {
	/**
	 * Array用逆順Enumerator。
	 * @author saz
	 */
	public class ArrayReverseEnumerator extends Enumerator {
		
		/**
		 * コンストラクタ。
		 * @param	component	対象Arrayインスタンス。
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, true, true];
		 * var enu:Enumerable = new Enumerable(new ArrayReverseEnumerator(arr));
		 * trace(enu.all());
		 * </listing>
		 */
		public function ArrayReverseEnumerator(component:Array) {
			//super(component, "forEach");
			super(component);
		}
		
		/* INTERFACE saz.collections.IEnumerator */
		
		/**
		 * 各要素について関数を実行します。
		 * @param	callback	各アイテムについて実行する関数です。
		 * function callback(item:*, index:int, collection:Object):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			//$component.forEach(callback, thisObject);
			for (var i:int = $component.length - 1, item:*; i >= 0; i--) {
				item = $component[i];
				callback(item, i, $component);
			}
		}
		
	}

}