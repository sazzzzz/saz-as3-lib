package saz.collections.enumerator {
	/**
	 * Object用Enumerator。
	 * @author saz
	 */
	public class ObjectEnumerator extends Enumerator{
		
		/**
		 * コンストラクタ。
		 * @param	component	対象とするObjectインスタンス。
		 * @example <listing version="3.0" >
		 * var obj:Object = {a:"foo", b:"bar"};
		 * var enum:ObjectEnumerator = new ObjectEnumerator(obj);
		 * </listing>
		 */
		public function ObjectEnumerator(component:Object) {
			super(component);
		}
		
		
		/**
		 * 各要素について関数を実行します。
		 * @param	callback	各アイテムについて実行する関数です。
		 * function callback(item:*, index:int, collection:Object):void;
		 * @param	thisObject	関数の this として使用するオブジェクトです。
		 * 
		 * @example <listing version="3.0" >
		 * var obj:Object = {a:"foo", b:"bar"};
		 * var enum:ObjectEnumerator = new ObjectEnumerator(obj);
		 * enum.forEach(function(item:*, index:int, collection:Object):void{
		 * 	trace(item);
		 * });
		 * </listing>
		 */
		override public function forEach(callback:Function, thisObject:* = null):void {
			var i:int = -1;
			for each(var item:* in $component) {
				i++;
				callback.apply(thisObject, [item, i, $component]);
			}
		}
		
		/*
		// for,for in,for each,forEach速度比較
		// http://wonderfl.net/c/fx0A
		
		Array for:25
		Array for in:763
		Array for each:11		// for eachはやい！
		Array forEach1:17
		Array forEach2:34
		5
		Vector for:25
		Vector for in:286
		Vector for each:11
		Vector forEach1:16
		Vector forEach2:34
		5
		*/
		
	}

}