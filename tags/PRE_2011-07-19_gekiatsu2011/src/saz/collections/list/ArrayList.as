package saz.collections.list {
	import saz.collections.enumerator.*;
	import saz.ICore;
	/**
	 * IListを実装した配列.
	 * @author saz
	 */
	public dynamic class ArrayList extends Array implements IList, IEnumerator, IEnumeration, ICore {
		
		private var _enumerator:IEnumerator;
		
		/**
		 * コンストラクタ. 
		 * @param	...args	要素の数、または元になるArrayインスタンス. 
		 */
		/*public function ArrayList(arr:Array = null) {
			if (arr != null) {
				for (var i:int = 0, n:int = arr.length; i < n; i++) {
					this[i] = arr[i];
				}
			}
		}*/
		public function ArrayList(...args) {
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
				for (var i:int = 0; i < n; i++) {
					this[i] = args[i]
				}
			}
		}
		
		/* INTERFACE saz.collections.list.IList */
		
		/**
		 * @inheritDoc
		 */
		public function get count():int {
			return length;
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		public function get(index:int):* {
			// パフォーマンスのため、エラーチェックなし
			//_testIndex(index);
			return this[index];
		}
		
		/**
		 * @inheritDoc
		 */
		public function set(index:int, item:*):void {
			this[index] = item;
		}
		
		
		
		
		/**
		 * @inheritDoc
		 */
		public function add(item:*):void {
			super.push(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function insert(index:int, item:*):void {
			_testIndex(index);
			super.splice(index, 0, item);
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		public function remove(item:*):Boolean {
			var i:int = super.indexOf(item);
			removeAt(i);
			return i > -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAt(index:int):void {
			_testIndex(index);
			super.splice(index, 1);
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear():void {
			super.length = 0;
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:*):Boolean {
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf(item:*):int {
			/*for (var i:int = 0, n:int = length, c:*; i < n; i++) {
				c = this[i];
				if (c == item) return i;
			}
			return -1;*/
			return super.indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function copyTo(arr:Array, arrIndex:int = 0):void {
			for (var i:int = 0, n:int = count, a:int = arrIndex; i < n; i++, a++) {
				arr[a] = super[i];
			}
		}
		
		
		
		
		
		
		/* ORIGINAL */
		
		public function first():* {
			return super[0];
		}
		
		public function last():* {
			return super[super.length - 1];
		}
		
		public function lastIndexOf(item:*):int {
			/*for (var i:int = length - 1, c:*; i >= 0; i--) {
				c = this[i];
				if (c == item) return i;
			}
			return -1;*/
			return super.lastIndexOf(item);
		}
		
		
		public function toArray():Array {
			var res:Array = new Array(count);
			for (var i:int = 0, n:int = length, c:*; i < n; i++) {
				c = this[i];
				res[i] = c;
			}
			return res;
		}
		
		public function getRange(index:int, rangeCount:int):IList {
			_testIndex(index);
			_testCount(index, rangeCount);
			
			var arr:Array = super.slice(index, index + rangeCount);
			return new ArrayList(arr);
		}
		
		// FIXME	以下未実装
		
		public function addRange(enum:IEnumerator):void {
			
		}
		
		public function insertRange(index:int, enum:IEnumerator):void {
			_testIndex(index);
			
		}
		
		public function removeRange(index:int, rangeCount:int):void {
			_testIndex(index);
			_testCount(index, rangeCount);
			
		}
		
		public function removeAll(match:Function):int {
			return 0;
		}
		
		
		
		
		
		/* INTERFACE saz.collections.enumerator.IEnumerator */
		
		public function forEach(callback:Function, thisObject:* = null):void {
			
		}
		
		/* INTERFACE saz.collections.enumerator.IEnumeration */
		
		public function enumerator():IEnumerator {
			if (_enumerator == null) _enumerator = new ArrayEnumerator(this);
			return _enumerator;
		}
		
		/* INTERFACE saz.ICore */
		
		public function equals(item:*):Boolean {
			return true;
		}
		
		public function clone():*{
			return new ArrayList();
		}
		
		public function destroy():void {
			
		}
		
		public function toString():String {
			//return super.toString();			// Array にメソッド toString が見つかりません。
			return super.join(",");
		}
		
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		private function _testIndex(index:int):void {
			if (index < 0) throw new ArgumentError("indexが0未満です。");
			if (this.count < index) throw new ArgumentError("indexが有効範囲を示していません。");
		}
		
		private function _testCount(index:int, rangeCount:int):void {
			if (rangeCount < 0) throw new ArgumentError("rangeCountが0未満です。");
			if (this.count < index + rangeCount) throw new ArgumentError("rangeCountが有効範囲を示していません。");
		}
		
		
		
	}

}