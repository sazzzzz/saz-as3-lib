package saz.collections {
	import saz.collections.IArray;
	
	/**
	 * ...
	 * @author saz
	 */
	//public class ArrayDecorator extends Array implements IArray {
	public dynamic class ArrayDecorator extends Array {
		
		private var $component:Array;
		
		public function ArrayDecorator(arr:Array) {
			$component = arr;
		}
		
		public function concat (...rest) : ArrayDecorator {
			return $component.concat.apply(null, rest);
		}
		
		public function every (callback:Function, thisObject:* = null) : Boolean {
			return $component.every.apply(null, [callback, thisObject]);
		}
		
		public function filter (callback:Function, thisObject:* = null) : ArrayDecorator {
			return $component.filter.apply(null, [callback, thisObject]);
		}
		
		public function forEach (callback:Function, thisObject:* = null) : void {
			$component.forEach.apply(null, [callback, thisObject]);
		}
		
		public function indexOf (searchElement:*, fromIndex:* = 0) : int {
			return $component.indexOf.apply(null, [searchElement, fromIndex]);
		}
		
		public function join (sep:* = null) : String {
			return $component.join.apply(null, [sep]);
		}
		
		public function lastIndexOf (searchElement:*, fromIndex:* = 2147483647) : int {
			return $component.lastIndexOf.apply(null, [searchElement, fromIndex]);
		}
		
		public function map (callback:Function, thisObject:* = null) : ArrayDecorator {
			return $component.map.apply(null, [callback, thisObject]);
		}
		
		public function pop () : * {
			return $component.pop.apply(null);
		}
		
		public function push (...rest) : uint {
			return $component.push.apply(null, rest);
		}
		
		public function reverse () : ArrayDecorator {
			return $component.reverse.apply(null);
		}
		
		public function shift () : * {
			return $component.shift.apply(null);
		}
		
		public function slice (A:* = 0, B:* = 4294967295) : ArrayDecorator {
			return $component.slice.apply(null, [A, B]);
		}
		
		public function some (callback:Function, thisObject:* = null) : Boolean {
			return $component.some.apply(null, [callback, thisObject]);
		}
		
		public function sort (...rest) : * {
			return $component.sort.apply(null, rest);
		}
		
		public function sortOn (names:*, options:* = 0, ...rest) : * {
			return $component.sortOn.apply(null, rest);
		}
		
		public function splice (...rest) : * {
			return $component.splice.apply(null, rest);
		}
		
		public function unshift (...rest) : uint {
			return $component.unshift.apply(null, rest);
		}
		
		
		public function toString():String {
			return $component.toString();
		}
		
		//--------------------------------------
		// get set
		//--------------------------------------
		
		/*override public function get length():uint { return $component.length; }
		
		override public function set length(value:uint):void {
			$component.length = value;
		}*/
		
	}

}