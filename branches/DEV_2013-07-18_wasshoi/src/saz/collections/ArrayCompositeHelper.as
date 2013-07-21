package saz.collections
{
	import saz.collections.enumerator.*;
	import saz.util.ObjectUtil;
	
	
	/**
	 * Compositeパターンのコア。
	 * @author saz
	 * 
	 */
	public class ArrayCompositeHelper
	{
		
		
		
		/**
		 * 要素の数. target.lengthで参照できるので、別に要らないけど. 
		 */
		public function get count():int {
			return _entries.length;
		}
		

		public function get collection():Array
		{
			return _entries;
		}
		private var _entries:Array = [];
		
		/**
		 * Enumerable
		 */
		public function get enumerable():Enumerable {
			_initEnumerable();
			return _enumerable;
		}
		private var _enumerable:Enumerable;
		
		
		public function ArrayCompositeHelper()
		{
		}
		
		
		
		/**
		 * 追加する。登録済みアイテムの場合は、古いエントリは消される。
		 * @param item
		 * @param name
		 * @param data
		 * @return 
		 * 
		 */
		public function add(item:Object, name:String = "", data:Object = null):int
		{
			remove(item);
			return _entries.push(_createEntry(item, name, data));
		}
		
		public function remove(item:Object):int
		{
			var index:int = indexOf(item);
			if (-1 < index) _entries.splice(indexOf(item), 1);
			return index;
		}
		
		
		
		public function getChildAt(index:int):Object
		{
			return _getEntryAt(index).item;
		}
		
		public function getChildByName(name:String):Object
		{
			if (name == "") return null;
			return _getEntryByName(name).item;
		}
		
		
		public function getDataAt(index:int):Object
		{
			return _getEntryAt(index).data;
		}
		public function getDataByName(name:String):Object
		{
			return _getEntryByName(name).data;
		}
		
		
		/**
		 * アイテムが含まれているかどうか。
		 * @param item
		 * @return 
		 * 
		 */
		public function contains(item:Object):Boolean
		{
			/*return enumerable.any(function(entry:Object, index:int):Boolean
			{
				return entry.item == item;
			});*/
			return indexOf(item) != -1;
		}
		
		
		/**
		 * アイテムを探し、インデックスを返す。
		 * @param item
		 * @return 
		 * 
		 */
		public function indexOf(item:Object):int
		{
			var entry:Object;
			for (var i:int = 0, n:int = _entries.length; i < n; i++) 
			{
				entry = _getEntryAt(i);
				if (entry.item == item) return i;
			}
			return -1;
		}
		
		
		public function dump():void
		{
			ObjectUtil.traceObject(_entries);
		}
		
		
		private function _getEntry(item:Object):Object
		{
			return enumerable.detect(function(entry:Object, index:int):Boolean
			{
				return entry.item == item;
			});
		}
		
		private function _getEntryAt(index:int):Object
		{
			return _entries[index];
		}
		
		private function _getEntryByName(name:String):Object
		{
			return enumerable.detect(function(entry:Object, index:int):Boolean
			{
				return entry.name == name;
			});
		}
		
		
		private function _createEntry(item:Object, name:String, data:Object = null):Object
		{
			return {
				item:item
				,name:name
				,data:data
			};
		}
		
		
		
		private function _initEnumerable():void {
			if (_enumerable != null) return;
			_enumerable = new Enumerable(_entries);
		}
		
	}
}