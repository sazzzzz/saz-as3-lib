package saz.collections {
	/**
	 * RubyなEnumerable.
	 * TODO	ArrayをIEnumeratorに変更する！
	 * @author saz
	 * http://www.ruby-lang.org/ja/man/html/Enumerable.html
	 */
	public class EnumerableModule{
		//private var $component:IEnumerator;
		private var $component:Array;
		
		/**
		 * コンストラクタ。
		 * @param	component	対象のIEnumerator（=forEach()を持っている）
		 */
		//public function EnumerableModule(component:IEnumerator) {
		public function EnumerableModule(component:Array) {
			$component = component;
		}
		
		private function $iterateBoolean(value:Boolean, index:int):Boolean {
			return value;
		}
		
		private function $iterateItem(item:*, index:int):*{
			return item;
		}
		
		/**
		 * すべての要素が真である場合に true を返します。偽である要素が あれば、 false を返します。
		 * @param	iterator	（オプション）評価式。各要素に対してiteratorを実行し、その戻り値によって判定を行う。
		 * iterator(item:*, index:int):Boolean
		 * @return
		 * @example <listing version="3.0" >
		 * var be1 = new EnumerableModule([true,true,true]);
		 * trace(be1);		// true
		 * var be2 = new EnumerableModule([true,false,true]);
		 * trace(be2);		// false
		 * </listing>
		 */
		public function all(iterator:Function = null):Boolean {
			if (null == iterator) iterator = $iterateBoolean;
			var res:Boolean = true;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				//trace(item, ":", iterator(item, index));
				if (false == iterator(item, index)) {
					res = false;
				}
			});
			return res;
		}
		
		/**
		 * すべての要素が偽である場合に false を返します。真である要素 があれば、 true を返しま
		 * @param	iterator	（オプション）評価式。各要素に対してiteratorを実行し、その戻り値によって判定を行う。
		 * iterator(item:*, index:int):Boolean
		 * @return
		 */
		public function any(iterator:Function = null):Boolean {
			if (null == iterator) iterator = $iterateBoolean;
			var res:Boolean = false;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (true == iterator(item, index)) {
					res = true;
				}
			});
			return res;
		}
		
		/**
		 * 各要素に対してブロックを評価した結果を全て含む配列を返します。
		 * @param	iterator	（オプション）評価式。省略した場合は、すべての要素を配列にして返す。
		 * function(item:*, index:int):*
		 * @return
		 */
		public function map(iterator:Function = null):Array {
			if (null == iterator) iterator = $iterateItem;
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, enu:Array):void {
				res.push(iterator(item, IndexedList));
			});
			return res;
		}
		
		/**
		 * 要素に対してブロックを評価した値が真になった最初の要素を返します。 
		 * 真になる要素がひとつも見つからなかったときは null を返します
		 * @param	iterator	評価式。
		 * function(item:*, index:int):*
		 * @return
		 */
		public function detect(iterator:Function):* {
			var res:*= null;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (null == res && true == iterator(item, index)) {
					res = item;
				}
			});
			return res;
		}
		
		/**
		 * 各要素に対してブロックを評価した値が真であった要素を全て含む配列を返します。
		 * 真になる要素がひとつもなかった場合は空の配列を返します。
		 * @param	iterator	評価式。
		 * function(item:*, index:int):*
		 * @return
		 */
		public function select(iterator:Function):Array {
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (true == iterator(item, index)) {
					res.push(item);
				}
			});
			return res;
		}
		
		/**
		 * pattern.test(item) が成立する要素を全て含んだ配列を返し ます。
		 * 評価式とともに呼び出された時には条件の成立した要素に対して それぞれ評価式を実行し、その結果の配列を返します。
		 * マッチする要素 がひとつもなかった場合は空の配列を返します。
		 * @param	pattern
		 * @param	iterator	（オプション）評価式。
		 * function(item:*, index:int):*
		 * @return
		 */
		public function grep(pattern:RegExp, iterator:Function = null):Array {
			if (null == iterator) iterator = $iterateItem;
			var res:Array = new Array();
			$component.forEach(function(item:String, index:int, enu:Array):void {
				if (true == pattern.test(item)) {
					res.push(iterator(item, index));
				}
			});
			return res;
		}
		
		/**
		 * 最初に初期値 init と 最初の要素を引数にiteratorを実行します。2 回目以降のループでは、前のブロックの実行結果と次の要素を引数に順次iteratorを実行します。
		 * そうして最後の要素まで繰り返し、最後のブロックの実行結果を返します。要素が空の場合は init を返します。
		 * 初期値 init にnullを指定した場合は、最初に先頭の要素と 2 番目の要素をブロックに渡します。この場合、要素が 1 つしかなければブロック を実行せずに最初の要素を返します。要素が空なら null を返しま す。
		 * @param	init	（オプション）初期値。
		 * @param	iterator
		 * function(result:*, item:*):*
		 * @return
		 */
		public function inject(init:*, iterator:Function):*{
			var res:*= init;
			if (null != init) {
				$component.forEach(function(item:*, index:int, enu:Array):void {
					res = iterator(res, item);
				});
			}else {
				$component.forEach(function(item:*, index:int, enu:Array):void {
					if (0 == index) {
						res = item;
					}else {
						res = iterator(res, item);
					}
				});
			}
			return res;
		}
		
		/**
		 * value と == の関係にある要素を含むとき真を返します。
		 * @param	value
		 * @return
		 */
		public function member(value:*):Boolean {
			var res:Boolean = false;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (value == item) {
					res = true;
				}
			});
			return res;
		}
		
		/**
		 * 最大の要素を返します。全要素が互いに <=> メソッドで比較できることを仮定しています。
		 * 要素が存在しなければ null を返します。
		 * @param	iterator	（オプション）評価式。指定した場合は、各要素の大小判定を行い、最大の要素を返します。
		 * ブロックの値は、a>b のとき正、a==b のとき 0、a<b のとき負の整数を、期待しています。ブロックが整数以外を返したときは 例外 TypeError が発生します。
		 * function(a:*, b:*):*
		 * @return
		 */
		public function max(compareFunction:Function = null):* {
			if (null == compareFunction) {
				return $max();
			}else {
				return $max2(compareFunction);
			}
		}
		
		private function $max():*{
			var res:* = null;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (0 == index) {
					res = item;
				}else if (res < item) {
					res = item;
				}
			});
			return res;
		}
		
		/**
		 * ブロックの評価結果で各要素の大小判定を行い、最大の要素を返します。 要素が存在しなければ null を返します。
		 * ブロックの値は、a>b のとき正、a==b のとき 0、a<b のとき負の整数を、期待しています。
		 * @param	compareFunction
		 * function(a:*, b:*):*
		 * @return
		 */
		private function $max2(compareFunction:Function):* {
			var res:* = null;
			var comp:int;
			$component.forEach(function(item:*, index:int, enu:Array):void {
				if (0 == index) {
					res = item;
				}else {
					comp = compareFunction(res, item);
					// FIXME	「ブロックが整数以外を返したときは 例外 TypeError が発生します。」実装できてない。
					/*if (comp is int) {
					}else {
						throw new TypeError("EnumerableModule.max: 評価式の戻り値がintではありません。");
					}*/
					if (0 > comp) {
						res = item;
					}
				}
			});
			return res;
		}
		
	}

}