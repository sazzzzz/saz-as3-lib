package saz.collections
{
	import saz.collections.enumerator.Enumerator;
	import saz.collections.enumerator.ObjectEnumerator;
	import saz.util.ObjectUtil;

	/**
	 * レジストリ. オブジェクトやサービスを検索するために使う、エントリポイントとなるクラスです. 
	 * @author saz
	 * @see	http://d.hatena.ne.jp/asakichy/20120925/1348524654
	 * 
	 */
	public class Registry
	{
		
		private static var _items:Object = {};
		
		private static var _enumerator:Enumerator;
		public static function get enumerator():Enumerator
		{
			if (_enumerator == null) _enumerator = new ObjectEnumerator(_items);
			return _enumerator;
		}

		
		/**
		 * アイテムを登録. 
		 * @param item
		 * @param id
		 * 
		 */
		public static function addItem(item:Object, id:String):void
		{
			// TODO	重複チェックが必要！
			_items[id] = item;
		}
		
		/**
		 * アイテムを取得. 
		 * @param id
		 * @return 
		 * 
		 */
		public static function getItem(id:String):Object
		{
			return _items[id];
		}
		
		/**
		 * 登録済みかどうか. 
		 * @param id
		 * @return 
		 * 
		 */
		public static function exist(id:String):Boolean
		{
			return (_items[id] != null);
		}
		
		/**
		 * クリア. 
		 * 
		 */
		public static function clear():void
		{
			ObjectUtil.clear(_items);
		}
		
		
	}
}