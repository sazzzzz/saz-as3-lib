package saz.collections
{
	
	import saz.collections.enumerator.*;
	import saz.util.ObjectUtil;
	
	public class ArrayContainerHelper
	{
		
		
		/**
		 * 要素の数. 
		 */
		public function get count():int {
			return _entries.length;
		}
		
		
		/*public function get collection():Array
		{
			return _entries;
		}*/
		private var _entries:Array = [];
		
		/**
		 * Enumerable
		 */
		public function get enumerable():Enumerable {
			enum ||= new Enumerable(_entries);
			return enum;
		}
		private var enum:Enumerable;
		
		
		public function ArrayContainerHelper()
		{
		}
		
		
		
		/**
		 * 指定した要素をリストの最後に追加する。
		 * 名前指定した場合、同じ名前が使われていた場合は追加できない。
		 * @param item
		 * @param name
		 * @return 
		 * 
		 */
		public function addItem(item:Object, name:String = ""):Boolean
		{
			if (name != "" && _getIndexByName(name) > -1) return false;
			_entries.push(_createEntry(item, name));
			return true;
		}
		
		public function addItemAt(item:Object, index:int, name:String = ""):void
		{
			throwError();
		}
		
		/**
		 * 指定した要素を1つ削除する。
		 * @param item
		 * @return 
		 * 
		 */
		public function removeItem(item:Object):int
		{
			var index:int = indexOf(item);
			if (-1 < index) removeAt(index);
			return index;
		}
		
		public function removeAt(index:int):void
		{
			if (index < 0 || count - 1 < index) throw new ArgumentError("指定インデックスが範囲外です。");
			_entries.splice(index, 1);
		}
		
		public function removeAll():void
		{
			_entries.length = 0;
		}
		
		
		public function getItemAt(index:int):Object
		{
			return _getEntryAt(index).item;
		}
		
		public function getItemByName(name:String):Object
		{
			if (name == "") return null;
			
			var entry:Object = _getEntryByName(name);
			return entry ? entry.item : null;
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
			return (indexOf(item) > -1)
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
		
		
		
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		private function _getEntryAt(index:int):Object
		{
			return _entries[index];
		}
		
		private function _getIndexByName(name:String):int
		{
			/*var res:int = -1;
			_entries.forEach(function(item:Object, index:int, arr:Array):void
			{
				if (item.name == name) res = index;
			});*/
			
			var entry:Object;
			for (var i:int = 0, n:int = _entries.length; i < n; i++) 
			{
				entry = _getEntryAt(i);
				if (entry.name == name)
				{
					return i;
				}
			}
			return -1;
		}
		
		
		private function _getEntryByName(name:String):Object
		{
			return enumerable.detect(function(entry:Object, index:int):Boolean
			{
				return entry.name == name;
			});
		}
		
		private function _createEntry(item:Object, name:String):Object
		{
			return {
				item:item
				,name:name
			};
		}
		
		private function throwError():void
		{
			throw new Error("未実装です。^^;");
		}
		
		public function _dump():void
		{
			trace(ObjectUtil.toObjectString(_entries));
		}
		
		
	}
}