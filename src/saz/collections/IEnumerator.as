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
		 * 順番は保障されません。
		 * 実行中に要素を追加したり、削除したりしてはいけません。
		 * @param	callback	各アイテムについて実行する関数です。この関数を呼び出すには、次のように、アイテムの値、アイテムのインデックス、およびIEnumeratorインスタンスの3つの引数を使用します。
		 * function callback(item:*, index:int, collection:Object):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 */
		function forEach(callback:Function, thisObject:*= null):void;
		
		/**
		 * Enumerableインスタンスを返す。
		 * FIXME	暫定的につけてみる。
		 * @return
		 */
		//function enumerable():Enumerable;
	}
	
}