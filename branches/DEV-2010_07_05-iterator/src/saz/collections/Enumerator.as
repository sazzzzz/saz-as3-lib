package saz.collections {
	/**
	 * IEnumeratorの汎用ラッパクラス。
	 * @author saz
	 */
	public class Enumerator implements IEnumerator{
		
		private var $component:Object;
		private var $methodName:String;
		
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