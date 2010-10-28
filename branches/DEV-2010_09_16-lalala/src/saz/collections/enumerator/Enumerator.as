package saz.collections {
	/**
	 * IEnumerator実装用の、親クラス。サブクラスはforEach()をオーバーライドすること。
	 * @author saz
	 */
	public class Enumerator implements IEnumerator, IEnumerable {
		
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
		
	}

}