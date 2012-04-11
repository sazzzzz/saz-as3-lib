package saz.collections {
	import flash.utils.Dictionary;
	/**
	 * Set暫定版.
	 * @author saz
	 * @deprecated	IdCollectionのために作ったけど、使ってない. このままでは存在意味ない. 
	 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/Set.html
	 * @see	http://codezine.jp/article/detail/2385?p=4
	 */
	public class TemporarySet {
		
		private var  _count:int = 0;
		private var _items:Dictionary;
		
		public function TemporarySet() {
			_items = new Dictionary();
		}
		
		/**
		 * 指定された要素がセット内になかった場合、セットに追加します. 
		 * @param	item
		 * @return	追加に成功したら（登録されていなければ）true、失敗ならfalse. 
		 */
		public function add(item:*):Boolean {
			if (_items[item] != null) return false;
			
			_items[item] = _count;
			_count++;
			return true;
		}
		
		/**
		 * 指定された要素がセット内にあった場合、セットから削除します. 
		 * @param	item
		 * @return	削除に成功したら（既に登録済みなら）true、失敗ならfalse. 
		 */
		public function remove(item:*):Boolean {
			if (_items[item] == null) return false;
			
			_items[item] = null;
			_count--;
			return true;
		}
		
		/**
		 * 配列に変換. 
		 * 順番は保証されない. 
		 * @return
		 */
		public function toArray():Array {
			var res:Array = [];
			for (var key:* in _items) {
				res.push(key);
			}
			return res;
		}
		
	}

}