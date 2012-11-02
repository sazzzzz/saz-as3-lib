package saz.collections.list {
	import saz.util.ArrayUtil;

	/**
	 * キュー.
	 * TODO	サイズ指定をできるようにする？
	 * TODO	ジェネリック型の利用.（http://www.atmarkit.co.jp/fjava/rensai4/java5eclipse19/java5eclipse19_1.html）
	 * TODO	Array.shift()操作によるパフォーマンス問題.
	 * @author saz
	 */
	public class Queue implements IQueue {

		private var _items:Array=[];

		public function get count():* {
			return _items.length;
		}


		/**
		 *
		 * @param items	初期値。指定した場合、値をコピーする。
		 */
		public function Queue(items:Array=null) {
			//コピー
			if (items is Array) {
				/*for (var i:int=0, n:int=items.length; i < n; i++) {
					_items[i]=items[i];
				}*/
				ArrayUtil.copy(items, _items);
			}
		}

		/**
		 * 先頭にあるオブジェクトを削除せずに返します.
		 * @return	先頭にあるオブジェクト.
		 */
		public function peek():* {
			return _items[0];
		}

		/**
		 * 末尾にオブジェクトを追加します.
		 * @param	item	追加するオブジェクト.
		 */
		public function enqueue(item:*):void {
			_items.push(item);
		}

		/**
		 * 先頭にあるオブジェクトを削除し、返します.
		 * @return	先頭から削除されたオブジェクト.
		 */
		public function dequeue():* {
			return _items.shift();
		}




		/**
		 * すべての要素を削除します。
		 */
		public function clear():void {
			_items.length=0;
		}


		public function $dump():String {
			return _items.join(", ");
		}
	}
}
