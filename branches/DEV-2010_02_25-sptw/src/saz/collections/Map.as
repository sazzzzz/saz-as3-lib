package saz.collections {
	
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
		
		public function gets(key:String):* {
			return $obj[key];
		}
		
		public function put(key:String, value:*):void {
			$obj[key] = value;
		}
		
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