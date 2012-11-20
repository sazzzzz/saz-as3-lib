package saz.collections {
	import saz.util.ObjectUtil;
	
	/**
	 * リスト。<br />
	 * 仕様はC++のまね。書籍「オブジェクト指向における再利用のためのデザインパターン」巻末より。<br />
	 * @author saz
	 */
	public class List implements IList {
		
		private var $arr:Array;
		
		/**
		 * コンストラクタ。<br />
		 * @param	size	サイズを指定する。
		 * 
		 * シンタックス1： エレメント数 0 個の新しい List インスタンスを作成します。<br />
		 * @example <listing version="3.0" >
		 * var myList:List = new List();
		 * </listing>
		 * シンタックス2： エレメント数 4 個の新しい List インスタンスを作成します。<br />
		 * @example <listing version="3.0" >
		 * var myList:List = new List(4);
		 * var myList:List = new List(new Array(4));	//これでもOK。
		 * </listing>
		 * シンタックス3： 初期値を指定して、新しい List インスタンスを作成します。<br />
		 * @example <listing version="3.0" >
		 * var myList:List = new List([0,0]);
		 * </listing>
		 * @deprecated	引数に数字を指定するパターンは廃止。
		 */
		//public function List(arr:Array = null) {
		public function List(...rest) {
			var arg:*= rest[0];
			if (arg is int) {
				$arr = new Array(arg);
			}else if (arg is Array) {
				$arr = arg;
			}else {
				$arr = new Array();
			}
		}
		/*public function List(arr:Array = null) {
			$arr = (null==arr) ? new Array() : arr;
		}*/
		
		/**
		 * シンタックス1： エレメント数 0 個の新しい List インスタンスを作成します。<br />
		 * @example <listing version="3.0" >
		 * var myList:List = new List();
		 * </listing>
		 * シンタックス2： エレメント数 4 個の新しい List インスタンスを作成します。<br />
		 * @example <listing version="3.0" >
		 * var myList:List = new List(4);
		 * </listing>
		 */
		/*public function List(size:int = 0) {
			$arr = new Array(size);
		}*/
		
		/**
		 * Arrayインスタンスを返す。
		 * げえ！イケてねえ。
		 * @return
		 */
		public function getArray():Array { return $arr; }
		
		//
		// 取得
		//
		
		/**
		 * リスト内のオブジェクト数を返す。
		 * @return
		 */
		public function count():int {
			return $arr.length;
		}
		
		/**
		 * 指定したインデックスの位置にあるオブジェクトを返す。
		 * @param	index	0から始まる整数値。
		 * @return
		 */
		public function gets(index:int):*{
			return $arr[index];
		}
		
		/**
		 * リスト内の最初のオブジェクトを返す。
		 * @return
		 */
		public function first():*{
			return $arr[0];
		}
		
		/**
		 * リスト内の最後のオブジェクトを返す。
		 * @return
		 */
		public function last():*{
			return $arr[$arr.length - 1];
		}
		
		/**
		 * 指定インデックスの位置にあるオブジェクトを置き換える。
		 * @param	index	0から始まる整数値。
		 * @param	item
		 */
		public function sets(index:int, item:*):void {
			$arr[index] = item;
		}
		
		//
		// 追加
		//
		
		/**
		 * リストの最後に追加。
		 * @param	item
		 */
		public function append(item:*):void {
			$arr.push(item);
		}
		
		/**
		 * リストの最初に追加。
		 * @param	item
		 */
		public function prepend(item:*):void {
			$arr.unshift(item);
		}
		
		//
		// 削除
		//
		
		/**
		 * 与えられた要素をリストから削除する。
		 * @param	item
		 */
		public function remove(item:*):void {
			for (var i:int = 0, len:int = count(), cur:*; i < len; i++) {
				cur = gets(i);
				if (item == cur) {
					$arr.splice(i, 1);
					i--;
				}
			}
		}
		
		/**
		 * リストの最初の要素を削除する。
		 */
		public function removeFirst():void {
			$arr.shift();
		}
		
		/**
		 * リストの最後の要素を削除する。
		 */
		public function removeLast():void {
			$arr.pop();
		}
		
		/**
		 * リストの全ての要素を削除する。
		 */
		public function removeAll():void {
			do {
				$arr.pop();
			}while ($arr.length > 0)
		}
		
		
		//
		// スタックインタフェース
		//
		
		/**
		 * （リストをスタックと見たときの）トップ要素を返す。
		 * @return
		 */
		public function top():*{
			return $arr[$arr.length - 1];
		}
		
		/**
		 * スタックに要素をプッシュする。
		 * @param	item
		 */
		public function push(item:*):void {
			$arr.push(item);
		}
		
		/**
		 * スタックから要素をポップする。
		 * @return
		 */
		public function pop():*{
			return $arr.pop();
		}
		
		
		
		/**
		 * 複製する。
		 * @return
		 */
		public function clone():* {
			var res:List = new List();
			for (var i:int = 0, len:int = count(), cur:*; i < len; i++) {
				cur = gets(i);
				res.append(cur);
			}
			return res;
		}
		
		/**
		 * デストラクタ。
		 */
		public function destroy():void {
			for (var i:int = 0, len:int = count(), cur:*; i < len; i++) {
				$arr[i] = null;
			}
			$arr = null;
		}
		
		public function toString():String {
			//return String($arr);
			//return ObjectUtil.dump($arr);
			//return "[saz.collections.List]";
			return getArray().toString();
		}
		
	}
	
}