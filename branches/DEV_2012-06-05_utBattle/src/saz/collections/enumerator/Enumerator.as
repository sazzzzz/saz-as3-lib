package saz.collections.enumerator {
	/**
	 * IEnumerator実装用の、親クラス。サブクラスはforEach()をオーバーライドすること。
	 * @author saz
	 */
	//public class Enumerator implements IEnumerator, IEnumerable {
	public class Enumerator implements IEnumerator {
		// FIXME	突然エラーがでるようになったので、とりあえずインターフェースを外す
		
		protected var $component:*;
		
		/**
		 * コンストラクタ。
		 * @param	component	対象オブジェクト。
		 */
		public function Enumerator(component:*) {
			$component = component;
		}
		
		/**
		 * 各要素について関数を実行します。
		 * @param	callback	各アイテムについて実行する関数です。
		 * function callback(item:*, index:int, collection:Object):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 */
		public function forEach(callback:Function, thisObject:* = null):void {
		}
		
		/**
		 * Enumerableを返す。
		 * @return
		 */
		public function enumerable():Enumerable {
			return new Enumerable(this);
		}
		
		/* INTERFACE saz.collections.enumerator.IEnumerator */
		
		public function equals(item:*):Boolean {
			return (this === item);
		}
		
		public function clone():* {
			return new Enumerator($component);
		}
		
		public function destroy():void {
			$component = null;
		}
		
	}

}