package saz.collections {
	/**
	 * IEnumeratorの汎用ラッパクラス。
	 * @author saz
	 */
	public class Enumerator implements IEnumerator{
		
		private var $component:Object;
		private var $methodName:String;
		
		/**
		 * コンストラクタ。
		 * @param	component	対象オブジェクト。
		 * @param	methodName	forEach の代わりとなるメソッドの名前。
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, false, true];
		 * var enu:Enumerable = new Enumerable(new Enumerator(arr, "forEach"));
		 * trace(enu.all());
		 * </listing>
		 */
		public function Enumerator(component:Object, methodName:String) {
			$component = component;
			$methodName = methodName;
		}
		
		
		public function forEach(callback:Function, thisObject:* = null):void {
			//$method(callback, thisObject);	//これじゃダメ。
			$component[$methodName](callback, thisObject);
		}
		
	}

}