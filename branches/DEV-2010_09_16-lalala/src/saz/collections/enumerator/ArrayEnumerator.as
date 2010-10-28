package saz.collections {
	/**
	 * Array用Enumerator。
	 * @author saz
	 */
	public class ArrayEnumerator extends Enumerator {
		
		/**
		 * コンストラクタ。
		 * @param	component	対象Arrayインスタンス。
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, true, true];
		 * var enu:Enumerable = new Enumerable(new ArrayEnumerator(arr));
		 * trace(enu.all());
		 * </listing>
		 */
		public function ArrayEnumerator(component:Array) {
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
			for (var i:int = 0, len:int = $component.length, item:*; i < len; i++) {
				item = $component[i];
				callback(item, i, $component);
			}
		}
		
	}

}