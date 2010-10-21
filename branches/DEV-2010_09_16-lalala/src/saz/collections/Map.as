package saz.collections {
	import saz.util.ObjectUtil;
	
	/**
	 * java風Map。機能限定版。
	 * @author saz
	 */
	public class Map {
		
		private var $obj:Object;
		
		/**
		 * TODO	あと、size(), clear(), containsKey(), containsValue(), equals(), isEmpty(), values()ぐらいは実装したい
		 * @see	http://java.sun.com/j2se/1.5.0/ja/docs/ja/api/java/util/HashMap.html
		 * @see	http://codezine.jp/article/detail/2385?p=3
		 */
		function Map() {
			$obj = new Object();
		}
		
		/**
		 * 格納されているキーの一覧を返します.
		 */
		public function get keys():Array {
			return ObjectUtil.propNames($obj);
		}
		
		/**
		 * 要素を取得する。
		 * @param	key
		 * @return
		 */
		public function gets(key:String):* {
			return $obj[key];
		}
		
		/**
		 * 指定した要素を書き換える。
		 * @param	key
		 * @param	value
		 */
		public function put(key:String, value:*):void {
			$obj[key] = value;
		}
		
		/**
		 * putのエイリアス。
		 * @param	key
		 * @param	value
		 */
		public function sets(key:String, value:*):void {
			put(key, value);
		}
		
		/**
		 * 指定した要素を削除する。
		 * @param	key
		 */
		public function remove(key:String):void {
			delete $obj[key];
		}
		
		/**
		 * いい加減に実装。いわゆるeach。
		 * @param	iterator	function(key:String, value:*, index:int):void
		 */
		public function each(iterator:Function):void {
			try {
				var index:int = 0;
				for (var key:String in $obj) {
					iterator(key, $obj[key], index++);
				}
			} catch (e:Error) {
				trace("Map.each( ERROR: "+e);
				return;
			}
		}
		
	}
	
}