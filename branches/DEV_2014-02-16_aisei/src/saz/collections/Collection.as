package saz.collections
{
	public class Collection
	{
		
		/**
		 * 要素の数. 
		 */
		public function get count():int {
			return helper.count;
		}
		
		/**
		 * アイテムに対するEnumerable。
		 */
		public function get enumerable():Enumerable {
			return helper.enumerable;
		}
		
		private var helper:ArrayContainerHelper;
		
		public function Collection()
		{
			helper ||= new ArrayContainerHelper();
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
			return helper.addItem(item, name);
		}
		
		public function addItemAt(item:Object, index:int, name:String = ""):Boolean
		{
			return helper.addItemAt(item, index, name);
		}
		
		/**
		 * 指定した要素を1つ削除する。
		 * @param item
		 * @return 
		 * 
		 */
		public function removeItem(item:Object):int
		{
			return helper.removeItem(item);
		}
		
		/**
		 * 
		 * @param index
		 * @return 指定された位置に以前あった要素。
		 * 
		 */
		public function removeAt(index:int):Object
		{
			return helper.removeAt(index);
		}
		
		/**
		 * 
		 * @param name
		 * @return 指定された位置に以前あった要素。
		 * 
		 */
		public function removeByName(name:String):Object
		{
			return helper.removeByName(name);
		}
		
		public function removeAll():void
		{
			helper.removeAll();
		}
		
		
		public function getItemAt(index:int):Object
		{
			return helper.getItemAt(index);
		}
		
		public function getItemByName(name:String):Object
		{
			return helper.getItemByName(name);
		}
		
		
		
		
		
		
		
		/**
		 * アイテムが含まれているかどうか。
		 * @param item
		 * @return 
		 * 
		 */
		public function contains(item:Object):Boolean
		{
			return helper.contains(item);
		}
		
		
		/**
		 * アイテムを探し、インデックスを返す。
		 * @param item
		 * @return 
		 * 
		 */
		public function indexOf(item:Object):int
		{
			return helper.indexOf(item);
		}
		
		
		/**
		 * Arrayに内容をコピーして返す。
		 * @return 
		 * 
		 */
		public function toArray():Array
		{
			return helper.toArray();
		}
		
	}
}