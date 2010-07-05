package saz.collections {
	/**
	 * IEnumerator インターフェースを持つ Array ラッパ。
	 * @author saz
	 */
	//public dynamic class EnumeratorArray extends Array implements IEnumerator{
	//public class EnumeratorArray implements IEnumerator {
	public class EnumeratorArray extends Enumerator {
		
		
		public function EnumeratorArray(component:Array) {
			super(component, "forEach");
		}
		
		
		
		/*private var $component:Array;
		
		public function EnumeratorArray(component:Array) {
			$component = component;
		}
		
		public function forEach(callback:Function, thisObject:* = null):void{
			$component.forEach(callback, thisObject);
		}*/
		
		/*public function EnumeratorArray(...rest) {
			// http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7ee4.html
			var n:uint = rest.length 
			if (n == 1 && (rest[0] is Number)) {
				trace("syntax 1");
				var dlen:Number = rest[0]; 
				var ulen:uint = dlen; 
				if (ulen != dlen) { 
					throw new RangeError("Array index is not a 32-bit unsigned integer ("+dlen+")"); 
				} 
				length = ulen; 
			} else { 
				trace("syntax 2");
				length = n; 
				for (var i:int=0; i < n; i++) { 
					this[i] = rest[i]  
				} 
			} 
		}*/
		
		/* INTERFACE saz.collections.IEnumerator */
		
		/**
		 * @copy	Array#forEach
		 */
		/*public function forEach(callback:Function, thisObject:* = null):void{
			super.forEach(callback, thisObject);
		}*/
		
	}

}