package saz.collections {
	import saz.collections.IArray;
	
	/**
	 * ...
	 * @author saz
	 */
	public class ArrayDecorator extends Array implements IArray {
		
		private var $component:Array;
		
		public function ArrayDecorator(arr:Array) {
			$component = arr;
		}
		
		public function concat (...rest) : Array {
			return $component.unshift.apply(null, rest);
		}
		
		public function every (callback:Function, thisObject:* = null) : Boolean {
			return $component.unshift.apply(null, [callback, thisObject]);
		}
		
		public function filter (callback:Function, thisObject:* = null) : Array {
			return $component.unshift.apply(null, [callback, thisObject]);
		}
		
		public function forEach (callback:Function, thisObject:* = null) : void {
			$component.unshift.apply(null, [callback, thisObject]);
		}
		
		public function indexOf (searchElement:*, fromIndex:* = 0) : int {
			return $component.unshift.apply(null, [searchElement, fromIndex]);
		}
		
		public function join (sep:* = null) : String {
			return $component.unshift.apply(null, [sep]);
		}
		
		public function lastIndexOf (searchElement:*, fromIndex:* = 2147483647) : int {
			return $component.unshift.apply(null, [searchElement, fromIndex]);
		}
		
		public function map (callback:Function, thisObject:* = null) : Array {
			return $component.unshift.apply(null, [callback, thisObject]);
		}
		
		public function pop () : * {
			return $component.unshift.apply(null);
		}
		
		public function push (...rest) : uint {
			return $component.unshift.apply(null, rest);
		}
		
		public function reverse () : Array {
			return $component.unshift.apply(null);
		}
		
		public function shift () : * {
			return $component.unshift.apply(null);
		}
		
		public function slice (A:* = 0, B:* = 4294967295) : Array {
			return $component.unshift.apply(null, [A, B]);
		}
		
		public function some (callback:Function, thisObject:* = null) : Boolean {
			return $component.unshift.apply(null, [callback, thisObject]);
		}
		
		public function sort (...rest) : * {
			return $component.unshift.apply(null, rest);
		}
		
		public function sortOn (names:*, options:* = 0, ...rest) : * {
			return $component.unshift.apply(null, rest);
		}
		
		public function splice (...rest) : * {
			return $component.unshift.apply(null, rest);
		}
		
		public function unshift (...rest) : uint {
			return $component.unshift.apply(null, rest);
		}
		
	}

}