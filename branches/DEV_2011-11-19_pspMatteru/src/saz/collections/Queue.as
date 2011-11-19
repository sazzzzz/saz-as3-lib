package saz.collections {
	/**
	 * キュー.
	 * @author saz
	 */
	public dynamic class Queue extends Array{
		
		/**
		 * コンストラクタ.
		 * @param	...args
		 * @copy	Array#Array
		 */
		public function Queue(...args) {
			// http://help.adobe.com/ja_JP/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b8d829-7fde.html
			var n:uint = args.length 
			if (n == 1 && (args[0] is Number)) {
				var dlen:Number = args[0]; 
				var ulen:uint = dlen; 
				if (ulen != dlen) { 
					throw new RangeError("Array index is not a 32-bit unsigned integer ("+dlen+")"); 
				} 
				length = ulen; 
			} else { 
				length = n; 
				for (var i:int=0; i < n; i++) { 
					this[i] = args[i]  
				} 
			} 
			
			enque = push;
			deque = shift;
		} 
		
		/**
		 * 要素を1つ追加する.
		 * @copy	Array#push
		 */
		public var enque:Function;
		
		/**
		 * 要素を1つ取り出す.
		 * @copy	Array#shift
		 */
		public var deque:Function;
		
		/*public function enque(item:*):uint {
			return super.push(item);
		}
		
		public function deque():* {
			return super.shift();
		}*/
		
		/**
		 * 空かどうか.
		 */
		public function get isEmpty():Boolean {
			return (0 == length);
		}
		
		/**
		 * 最初の要素.
		 */
		public function get first():*{
			return this[0];
		}
		
		/**
		 * 最後の要素.
		 */
		public function get last():*{
			return this[length - 1];
		}
		
	}

}