package saz.collections {
	import saz.collections.IEnumerator;
	/**
	 * enumerator()メソッドを実装したArrayのサブクラス。Enumerable内部で使用。
	 * @author saz
	 */
	public dynamic class EnumerableArray extends Array implements IEnumeration, IEnumerable {
		
		public function EnumerableArray(...args) {
			// Array クラスの拡張
			// http://help.adobe.com/ja_JP/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b8d829-7fde.html
			var n:uint = args.length 
			if (n == 1 && (args[0] is Number)) {
				var dlen:Number = args[0];
				var ulen:uint = dlen;
				if (ulen != dlen) {
					throw new RangeError("Array index is not a 32-bit unsigned integer ("+dlen+")");
				}
				length = ulen;
			}else {
				length = n;
				for (var i:int=0; i < n; i++) {
					this[i] = args[i];
				}
			}
		}
		
		
		/* INTERFACE saz.collections.IEnumeration */
		
		public function enumerator():IEnumerator{
		//public function enumerator():ArrayEnumerator{
			return new ArrayEnumerator(this);
		}
		
		/* ORIGINAL */
		
		/**
		 * Enumerableインスタンスを返す。
		 * FIXME	暫定的につけてみる。
		 * @return	Enumerableインスタンス。
		 */
		public function enumerable():Enumerable {
			return new Enumerable(enumerator());
		}
		
	}

}