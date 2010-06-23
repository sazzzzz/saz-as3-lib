package saz.collections {
	
	/**
	 * Enumeratorインターフェース。
	 * @author saz
	 * @example <listing version="3.0" >
	 * list.forEach(function(item:*, index:int, enu:IEnumerator):void{
	 * 	trace(item,index);
	 * });
	 * </listing>
	 */
	public interface IEnumerator {
		/**
		 * 各要素について関数を実行します。
		 * @param	callback	各アイテムについて実行する関数です。この関数を呼び出すには、次のように、アイテムの値、アイテムのインデックス、およびIEnumeratorインスタンスの3つの引数を使用します。
		 * function callback(item:*, index:int, enum:IEnumerator):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 */
		function forEach(callback:Function, thisObject:*= null):void;
	}
	
}