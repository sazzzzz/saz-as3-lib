package saz.collections {
	import saz.collections.enumerator.*;
	
	/**
	 * Arrayのアイテムを管理する.
	 * Arrayでアイテムの親を実装するときに楽ちん. 
	 * @author saz
	 */
	public class ArrayParentHelper {
		
		/**
		 * 対象とするArrayインスタンス. 
		 */
		public function get target():Array {
			if (_target == null)_target = [];
			return _target;
		}
		
		public function set target(value:Array):void {
			//if (_target == value) return;
			_target = value;
			_initEnumerator();
			_initEnumerable();
		}
		private var _target:Array;
		
		
		/**
		 * 要素の数. target.lengthで参照できるので、別に要らないけど. 
		 */
		public function get count():int {
			return target.length;
		}
		
		/**
		 * ArrayEnumerator
		 */
		public function get enumerator():IEnumerator {
			if (_enumerator == null) _initEnumerator();
			return _enumerator;
		}
		private var _enumerator:IEnumerator;
		
		
		/**
		 * Enumerable
		 */
		public function get enumerable():Enumerable {
			if (_enumerable == null) _initEnumerable();
			return _enumerable;
		}
		private var _enumerable:Enumerable;
		
		
		
		public function ArrayParentHelper(arr:Array = null) {
			if (arr != null) target = arr;
		}
		
		
		/**
		 * 指定プロパティを持つ最初のアイテムを返す. 
		 * @param	value
		 * @param	name
		 * @return
		 */
		public function getItemByProperty(value:*, name:Object = "id"):* {
			return enumerable.detect(function(item:*, index:int):Boolean {
				return item[name] == value;
			});
		}
		
		/**
		 * 指定プロパティを持つ全てのアイテムを配列で返す. 
		 * @param	value
		 * @param	name
		 * @return
		 */
		public function getItemsByProperty(value:*, name:Object = "id"):EnumerableArray {
			return enumerable.select(function(item:*, index:int):Boolean {
				return item[name] == value;
			});
		}
		
		
		private function _initEnumerator():void {
			_enumerator = new ArrayEnumerator(_target);
		}
		
		private function _initEnumerable():void {
			_enumerable = new Enumerable(this.enumerator);
		}
		
		
		
		
		
	}

}