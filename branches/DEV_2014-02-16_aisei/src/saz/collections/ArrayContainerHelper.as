package saz.collections
{
	
	import saz.collections.enumerator.*;
	import saz.util.ArrayUtil;
	import saz.util.ObjectUtil;
	
	public class ArrayContainerHelper
	{
		
		
		/**
		 * 要素の数. 
		 */
		public function get count():int {
			return _entries.length;
		}
		
		/**
		 * アイテムに対するEnumerable。
		 */
		public function get enumerable():Enumerable {
			_itemEnum ||= new Enumerable(new EntryItemEnumerator(_entries));
			return _itemEnum;
		}
		private var _itemEnum:Enumerable;
		
		
		/**
		 * EntryのEnumerable
		 */
		private function get entryEnumerable():Enumerable {
			_enum ||= new Enumerable(_entries);
			return _enum;
		}
		private var _enum:Enumerable;
		
		private var _entries:Array = [];
		
		
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
		
		public function addItemAt(item:Object, index:int, name:String = ""):Boolean
		{
			throwNotImplement();
			return false;
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
		
		/**
		 * 
		 * @param index
		 * @return 指定された位置に以前あった要素。
		 * 
		 */
		public function removeAt(index:int):Object
		{
			if (index < 0 || count - 1 < index) throw new ArgumentError("指定インデックスが範囲外です。");
			return _entries.splice(index, 1)[0];
		}
		
		/**
		 * 
		 * @param name
		 * @return 指定された位置に以前あった要素。
		 * 
		 */
		public function removeByName(name:String):Object
		{
			return removeAt(indexOf(getItemByName(name)));
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
			var entry:Entry;
			for (var i:int = 0, n:int = _entries.length; i < n; i++) 
			{
				entry = _getEntryAt(i);
				if (entry.item == item) return i;
			}
			return -1;
		}
		
		
		/**
		 * Arrayに内容をコピーして返す。
		 * @return 
		 * 
		 */
		public function toArray():Array
		{
			var res:Array = [];
			for (var i:int = 0; i < count; i++) 
			{
				res.push(getItemAt(i));
			}
			return res;
		}
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		private function _getEntryAt(index:int):Entry
		{
			return _entries[index] as Entry;
		}
		
		private function _getIndexByName(name:String):int
		{
			var entry:Entry;
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
			return entryEnumerable.detect(function(entry:Entry, index:int):Boolean
			{
				return entry.name == name;
			});
		}
		
		private function _createEntry(item:Object, name:String):Entry
		{
			return new Entry(item, name);
		}
		
		private function throwNotImplement():void
		{
			throw new Error("未実装です。^^;");
		}
		
		public function _dump():void
		{
			trace(ObjectUtil.toObjectString(_entries));
		}
		
		
	}
}


/**
 * エントリ。
 * @author saz
 * 
 */
class Entry {
	
	public var item:Object;
	public var name:String = "";
	
	public function Entry(entryItem:Object, entryName:String)
	{
		item = entryItem;
		name = entryName;
	}
	
	public function toString():String
	{
		return ["[Entry", "item="+item, "name="+name].join(" ") + "]";
	}
}

/**
 * エントリのitemをイテレートするためのクラス。
 * @author saz
 * 
 */
class EntryItemEnumerator {

	public var entries:Array;
	
	public function EntryItemEnumerator(entrieArray:Array)
	{
		entries = entrieArray;
	}

	public function forEach(iterator:Function, thisObject:* = null):void {
		entries.forEach(function(item:Entry, index:int, arr:Array):void
		{
			// FIXME:	仮実装
			iterator(item.item, index, arr);
		});
	}

}