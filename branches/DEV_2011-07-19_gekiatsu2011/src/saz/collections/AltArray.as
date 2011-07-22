package saz.collections {
	/**
	 * Arrayヘルパ.
	 * メソッドがわかりやすい. 負のインデックスが使える.
	 * @author saz
	 */
	public class AltArray {
		
		/**
		 * 配列インデックスの最大値.
		 * @see	Array#lastIndexOf
		 */
		static public const MAX_INDEX:uint = 0x7fffffff;
		
		/**
		 * 対象とする配列. 途中で変えても、たぶん大丈夫よ.
		 */
		public var array:Array;
		
		/**
		 * コンストラクタ.
		 * @param	arr	対象とする配列を指定.
		 */
		public function AltArray(arr:Array) {
			array = arr;
		}
		
		
		//--------------------------------------
		// get/set
		//--------------------------------------
		
		/**
		 * 最初の要素を返す.
		 */
		public function get first():*{
			return array[0];
		}
		
		/**
		 * 最後の要素を返す.
		 */
		public function get last():*{
			return array[array.length - 1];
		}
		
		/**
		 * 配列が空かどうか.
		 */
		public function get isEmpty():Boolean{
			return 0 == array.length;
		}
		
		
		//--------------------------------------
		// method
		//--------------------------------------
		
		
		/* add */
		
		/**
		 * 配列の最後に、指定要素を追加.
		 * @param	element	追加する要素.
		 */
		public function add(element:*):void {
			array.push(element);
		}
		
		/**
		 * インデックスで指定した要素の直前に、指定要素を挿入.
		 * @param	element	挿入する要素.
		 * @param	index	挿入を開始する配列エレメントのインデックスを示す整数です。負の整数を使用すると、配列の末尾を基準として位置を指定できます。たとえば、-1 は配列の最後のエレメントです。
		 */
		public function addAt(element:*, index:int):void {
			array.splice($pos(index), 0, element);
		}
		
		/**
		 * 配列の最後に、elementsのすべての要素を追加.
		 * @param	elements	追加する要素を含む配列.
		 */
		public function addAll(elements:Array):void {
			array.push.apply(null, elements);
		}
		
		/**
		 * インデックスで指定した要素の直前に、elementsのすべての要素を追加.
		 * @param	elements	追加する要素を含む配列.
		 * @param	index		挿入位置. @see	#addAt
		 * @see	#addAt
		 */
		public function addAllAt(elements:Array, index:int):void {
			array.splice.apply(null, [$pos(index), 0].concat(elements));
		}
		
		
		/* remove */
		
		/**
		 * 指定要素を削除. Array.indexOfを使用して配列内を検索し、最初に見つかった要素を削除します. 
		 * @param	element		配列内で検索するアイテムです。
		 * @param	fromIndex	アイテムの検索を開始する配列内の場所です。
		 * @return	元の配列から削除されたエレメントを含む配列です。
		 * @see	#addAt
		 */
		public function remove(element:*, fromIndex:int = 0):Array {
			return removeAt(array.indexOf(element, $pos(fromIndex)), 1);
		}
		
		/**
		 * インデックスで指定した要素を削除.
		 * @param	index	削除を開始する配列エレメントのインデックスを示す整数です。	
		 * @param	count	削除するエレメント数を示す整数です。
		 * 指定位置から最後までを削除したい場合は、MAX_INDEXを指定すればOK。
		 * @return	元の配列から削除されたエレメントを含む配列です。
		 * @see	#addAt
		 */
		public function removeAt(index:int, count:uint = 1):Array {
			return array.splice($pos(index), count);
		}
		
		
		/**
		 * 配列からすべての要素を削除.
		 */
		public function clear():void {
			array.length = 0;
		}
		
		
		/* fill */
		
		/**
		 * 指定要素で配列内を埋める.
		 * @param	element	セットする値。
		 * @param	start	開始位置のインデックス。
		 * @param	length	セットする個数。
		 * @see	#addAt
		 */
		public function fill(element:* = null, start:int = 0, length:uint = MAX_INDEX):void {
			start = $posClip(start);
			$fill(element, start, $clip(start + length));
		}
		
		/**
		 * 指定要素で配列内を埋める.
		 * @param	element	セットする値。
		 * @param	start	開始位置のインデックス。
		 * @param	end		終了位置のインデックス。
		 * @see	#addAt
		 */
		public function fillAt(element:* = null, start:int = 0, end:int = 16777215):void {
			$fill(element, $posClip(start), $posClip(end));
		}
		
		
		/* get/set */
		
		/**
		 * 指定した位置にある要素を返す.
		 * @param	index	インデックス。
		 * @return
		 * @see	#addAt
		 */
		public function gets(index:int):*{
			return array[$pos(index)];
		}
		
		/**
		 * 指定した位置にある要素を置き換える.
		 * @param	element	置き換える値。
		 * @param	index	位置を指定するインデックス。
		 * @see	#addAt
		 */
		public function sets(element:*, index:int):void {
			array[$pos(index)] = element;
		}
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		/**
		 * 負のインデックスを、正インデックスに変換して返す.
		 * @param	index
		 * @return
		 */
		private function $pos(index:int):uint {
			return (index < 0) ? array.length + index : index;
		}
		
		/**
		 * 正インデックスを、範囲内にクリップ.
		 * @param	posIndex
		 * @return
		 */
		private function $clip(posIndex:uint):uint {
			return Math.max(0, Math.min(posIndex, array.length - 1));
		}
		
		/**
		 * インデックスを正に変換した上、範囲内にクリップ.
		 * @param	index
		 * @return
		 */
		private function $posClip(index:int):uint {
			return Math.max(0, Math.min($pos(index), array.length - 1));
		}
		
		/**
		 * fill本体. 引数チェックなし.
		 * @param	element
		 * @param	start
		 * @param	end
		 */
		private function $fill(element:*, start:uint, end:uint):void {
			for (var i:int = start; i <= end; i++) {
				array[i] = element;
			}
		}
		
	}

}