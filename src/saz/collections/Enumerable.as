package saz.collections {
	/**
	 * Enumeratorに対して、便利なメソッドを提供する。RubyなEnumerable。
	 * @author saz
	 * @see	http://www.ruby-lang.org/ja/man/html/Enumerable.html
	 * @see	http://www.s2factory.co.jp/tech/prototype/prototype.js.html#Reference.Enumerable
	 * TODO	未実装：maxBy(), minBy(), sort(), sortBy()
	 */
	public class Enumerable implements IEnumerator {
		
		private var $component:IEnumerator;
		
		/**
		 * コンストラクタ。
		 * @param	component	対象のIEnumerator（=forEach()を持っている）
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, true, true];
		 * var enu:Enumerable = new Enumerable(new ArrayEnumerator(arr));
		 * trace(enu.all());
		 * </listing>
		 */
		public function Enumerable(component:IEnumerator) {
			$component = component;
			
			//エイリアス
			collect = map;
			find = detect;
			findAll = select;
			includes = member;
		}
		
		/**
		 * obj オブジェクトについて、 forEach の代わりに method という 名前のメソッドを使って繰り返すオブジェクトを生成して返す。
		 * @param	obj	対象とするオブジェクト。
		 * @param	methodName	forEach の代わりとなるメソッドの名前。
		 * @return
		 * @example <listing version="3.0" >
		 * var arr:Array = [true, false, true];
		 * var enu:Enumerable = Enumerable.enumerator(arr, "forEach");
		 * trace(enu.all());
		 * </listing>
		 */
		// Ruby Enumerable::Enumerator.new のマネ。
		// http://www.ruby-lang.org/ja/man/html/Enumerable_Enumerator.html
		static public function enumerator(obj:Object, methodName:String = "forEach"):Enumerable {
			return new Enumerable(new Enumerator(obj, methodName));
		}
		
		
		
		
		//--------------------------------------
		// ALIAS
		//--------------------------------------
		
		/**
		 * mapと同じ。
		 * @param	iterator
		 * @return
		 */
		//public function collect(iterator:Function = null):Array { return []; }
		public var collect:Function;
		
		/**
		 * detectと同じ。
		 * @param	iterator
		 * @return
		 */
		//public function find(iterator:Function):* { return 0; }
		public var find:Function;
		
		/**
		 * selectと同じ。
		 * @param	iterator
		 * @return
		 */
		//public function findAll(iterator:Function):Array { return[]; }
		public var findAll:Function;
		
		/**
		 * memberと同じ。（本来は"include"だが予約されていて使えない）
		 * @param	value
		 * @return
		 */
		//public function include(value:*):Boolean { return false; }
		public var includes:Function;
		
		/**
		 * entriesと同じ。
		 * @return
		 */
		public var toArray:Function;
		
		
		
		
		
		
		//--------------------------------------
		// PRIVATE COMMON
		//--------------------------------------
		
		/**
		 * 要素自体を返す。
		 * @param	item
		 * @param	index
		 * @return
		 */
		private function $iterateItem(item:*, index:int):*{
			return item;
		}
		
		/**
		 * 要素自体をBooleanにして返す。
		 * @param	item
		 * @param	index
		 * @return
		 * 0	Boolean(0)	false
		 * NaN	Boolean(NaN)	false
		 * 数値 (0 でも NaN でもない)	Boolean(4)	true
		 * 空のストリング	Boolean("")	false
		 * 空ではないストリング	Boolean("6")	true
		 * null	Boolean(null)	false
		 * undefined	Boolean(undefined)	false
		 * Object クラスのインスタンス	Boolean(new Object())	true
		 * 引数なし	Boolean()	false
		 * @see	http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/package.html#Boolean()
		 */
		private function $iterateBoolean(item:Boolean, index:int):Boolean {
			return Boolean(item);
		}
		
		
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		
		// なんかの役に立つかと思って、これ自身もIEnumerator型にしてみる。
		/**
		 * 配列内の各アイテムについて関数を実行します。
		 * @param	iterator
		 * @param	thisObject = null
		 */
		public function forEach(iterator:Function, thisObject = null):void {
			$component.forEach(iterator, thisObject);
		}
		
		/**
		 * 「すべて」の要素が、テストをパスするかどうかをチェックする。
		 * すべての要素が真である場合に true を返します。偽である要素が あれば、 false を返します。
		 * @param	iterator	（オプション）評価式。各要素に対してiteratorを実行し、その戻り値によって判定を行う。
		 * function(item:*, index:int):Boolean
		 * @return
		 * @example <listing version="3.0" >
		 * var be1 = new Enumerable([true,true,true]);
		 * trace(be1);		// true
		 * var be2 = new Enumerable([true,false,true]);
		 * trace(be2);		// false
		 * </listing>
		 */
		public function all(iterator:Function = null):Boolean {
			if (null == iterator) iterator = $iterateBoolean;
			var res:Boolean = true;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				if (false == iterator(item, index)) {
					res = false;
				}
			});
			return res;
		}
		
		/**
		 * 「いずれか」の要素が、テストをパスするかどうかをチェックする。
		 * すべての要素が偽である場合に false を返します。真である要素 があれば、 true を返します。
		 * @param	iterator	（オプション）評価式。各要素に対してiteratorを実行し、その戻り値によって判定を行う。
		 * function(item:*, index:int):Boolean
		 * @return
		 */
		public function any(iterator:Function = null):Boolean {
			if (null == iterator) iterator = $iterateBoolean;
			var res:Boolean = false;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				if (true == iterator(item, index)) {
					res = true;
				}
			});
			return res;
		}
		
		
		/**
		 * 各要素に対してブロックを評価した結果を全て含む配列を返します。
		 * @param	iterator	評価式。
		 * function(item:*, index:int):*
		 * @return
		 */
		public function map(iterator:Function):Array {
			//if (null == iterator) iterator = $iterateItem;
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, collection:Object):void {
				res.push(iterator(item, IndexedList));
			});
			return res;
		}
		
		
		/**
		 * 要素に対してブロックを評価した値が真になった最初の要素を返します。 
		 * 真になる要素がひとつも見つからなかったときは null を返します
		 * @param	iterator	評価式。
		 * function(item:*, index:int):Boolean
		 * @return
		 */
		public function detect(iterator:Function):* {
			var res:*= null;
			$component.forEach(function(item:*, index:int, collection:Object):void {
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
		 * function(item:*, index:int):Boolean
		 * @return
		 */
		public function select(iterator:Function):Array {
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, collection:Object):void {
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
			$component.forEach(function(item:String, index:int, collection:Object):void {
				if (true == pattern.test(item)) {
					res.push(iterator(item, index));
				}
			});
			return res;
		}
		
		/**
		 * 最初に初期値 init と 最初の要素を引数にiteratorを実行します。
		 * 2 回目以降のループでは、前のブロックの実行結果と次の要素を引数に順次iteratorを実行します。
		 * そうして最後の要素まで繰り返し、最後のブロックの実行結果を返します。要素が空の場合は init を返します。
		 * 初期値 init にnullを指定した場合は、最初に先頭の要素と 2 番目の要素をブロックに渡します。
		 * この場合、要素が 1 つしかなければブロックを実行せずに最初の要素を返します。要素が空なら null を返します。
		 * @param	init	（オプション）初期値。
		 * @param	iterator
		 * function(result:*, item:*):*
		 * @return
		 */
		public function inject(init:*, iterator:Function):*{
			if (null != init) {
				return $injectWithInit(init, iterator);
			}else {
				return $injectNoInit(iterator);
			}
		}
		
		/**
		 * inject()サブ。initが指定されたとき。
		 * @param	init
		 * @param	iterator
		 * @return
		 */
		private function $injectWithInit(init:*, iterator:Function):*{
			var res:*= init;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				res = iterator(res, item);
			});
			return res;
		}
		
		/**
		 * inject()サブ。initがnullだったとき。
		 * @param	iterator
		 * @return
		 */
		//private function $injectNoInit(init:*, iterator:Function):*{
		private function $injectNoInit(iterator:Function):*{
			var res:*= null;
			// 最初の1回用
			var firstFunc:Function = function(item:*, index:int, collection:Object):void {
				res = item;
				func = mainFunc;
			};
			// 2回目以降用
			var mainFunc:Function = function(item:*, index:int, collection:Object):void {
				res = iterator(res, item);
			};
			var func:Function = firstFunc;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				func(item, index, collection);
			});
			return res;
		}
		
		
		
		/**
		 * value と == の関係にある要素を含むとき真を返します。
		 * @param	value
		 * @return
		 */
		public function member(value:*):Boolean {
			var res:Boolean = false;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				if (value == item) {
					res = true;
				}
			});
			return res;
		}
		
		/**
		 * 最大の要素を返します。全要素が互いに <=> メソッドで比較できることを仮定しています。要素が存在しなければ null を返します。
		 * compareFunctionを指定した場合は、compareFunctionによって大小判定を行います。
		 * @param	compareFunction	（オプション）評価式。指定した場合は、各要素の大小判定を行い、最大の要素を返します。
		 * 戻り値は、a>b のとき正、a==b のとき 0、a<b のとき負の整数を、期待しています。
		 * 未実装⇒ブロックが整数以外を返したときは 例外 TypeError が発生します。
		 * function(a:*, b:*):int
		 * @return
		 */
		public function max(compareFunction:Function = null):* {
			if (null == compareFunction) {
				return $max();
			}else {
				return $maxWithFunc(compareFunction);
			}
		}
		
		/**
		 * max()サブ。iteratorが省略されたとき。
		 * @return
		 */
		private function $max():*{
			var res:* = null;
			// 最初の1回用
			var firstFunc:Function = function(item:*, index:int, collection:Object):void {
				res = item;
				func = mainFunc;
			};
			// 2回目以降用
			var mainFunc:Function = function(item:*, index:int, collection:Object):void {
				if (res < item) res = item;
			};
			var func:Function = firstFunc;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				func(item, index, collection);
			});
			return res;
		}
		
		/**
		 * max()サブ。iteratorが指定されたとき。
		 * ブロックの評価結果で各要素の大小判定を行い、最大の要素を返します。 要素が存在しなければ null を返します。
		 * ブロックの値は、a>b のとき正、a==b のとき 0、a<b のとき負の整数を、期待しています。
		 * @param	compareFunction
		 * function(a:*, b:*):int
		 * @return
		 */
		private function $maxWithFunc(compareFunction:Function):* {
			var res:* = null;
			var comp:int;
			// 最初の1回用
			var firstFunc:Function = function(item:*, index:int, collection:Object):void {
				res = item;
				func = mainFunc;
			};
			// 2回目以降用
			var mainFunc:Function = function(item:*, index:int, collection:Object):void {
				// a>b のとき正、a==b のとき 0、a<b のとき負の整数
				comp = compareFunction(res, item);
				// FIXME	「ブロックが整数以外を返したときは 例外 TypeError が発生します。」実装できてない。
				//if (comp is int) {
				//}else {
					//throw new TypeError("Enumerable.max: 評価式の戻り値がintではありません。");
				//}
				if (0 > comp) {
					res = item;
				}
			};
			var func:Function = firstFunc;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				func(item, index, collection);
			});
			return res;
		}
		
		// TODO	maxBy()よくわからないので未実装
		//public function maxBy(compareFunction:Function):*
		
		/**
		 * 最小の要素を返します。全要素が互いに <=> メソッドで比較でき ることを仮定しています。要素が存在しなければ null を返します。
		 * compareFunctionを指定した場合は、compareFunctionによって大小判定を行います。
		 * @param	compareFunction	（オプション）評価式。指定した場合は、各要素の大小判定を行い、最小の要素を返します。
		 * 戻り値は、a>b のとき正、a==b のとき 0、a<b のとき負の整数を、期待しています。
		 * 未実装⇒ブロックが整数以外を返したときは 例外 TypeError が発生します。
		 * function(a:*, b:*):int
		 * @return
		 */
		public function min(compareFunction:Function = null):* {
			if (null == compareFunction) {
				return $min();
			}else {
				return $minWithFunc(compareFunction);
			}
		}
		
		/**
		 * 評価式なしで最小値を返します。
		 * @return
		 */
		private function $min():*{
			var res:* = null;
			// 最初の1回用
			var firstFunc:Function = function(item:*, index:int, collection:Object):void {
				res = item;
				func = mainFunc;
			};
			// 2回目以降用
			var mainFunc:Function = function(item:*, index:int, collection:Object):void {
				if (res > item) res = item;
			};
			var func:Function = firstFunc;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				func(item, index, collection);
			});
			return res;
		}
		
		/**
		 * 評価式ありで、最小値を返します。
		 * @param	compareFunction
		 * function(a:*, b:*):int
		 * @return
		 */
		private function $minWithFunc(compareFunction:Function):* {
			var res:* = null;
			var comp:int;
			// 最初の1回用
			var firstFunc:Function = function(item:*, index:int, collection:Object):void {
				res = item;
				func = mainFunc;
			};
			// 2回目以降用
			var mainFunc:Function = function(item:*, index:int, collection:Object):void {
				//trace("mainFunc(", arguments);
				// a>b のとき正、a==b のとき 0、a<b のとき負の整数
				comp = compareFunction(res, item);
				// FIXME	「ブロックが整数以外を返したときは 例外 TypeError が発生します。」実装できてない。
				//if (comp is int) {
				//}else {
					//throw new TypeError("Enumerable.max: 評価式の戻り値がintではありません。");
				//}
				if (0 < comp) {
					res = item;
				}
			};
			var func:Function = firstFunc;
			$component.forEach(function(item:*, index:int, collection:Object):void {
				func(item, index, collection);
			});
			return res;
		}
		
		
		// TODO	minBy()よくわからないので未実装
		//public function minBy(compareFunction:Function):*
		
		
		/**
		 * 各要素に対して評価式の戻り値が真であった要素からなる配列と 偽であった要素からなる配列からなる配列を返します。
		 * @param	iterator	評価式。
		 * function(item:*, index:int):Boolean
		 * @return	真であった要素からなる配列と、偽であった要素からなる配列からなる2次元配列
		 */
		public function partition(iterator:Function):Array {
			var trueRes:Array = new Array();
			var falseRes:Array = new Array();
			$component.forEach(function(item:*, index:int, collection:Object):void {
				if (iterator(item, index)) {
					trueRes.push(item);
				}else {
					falseRes.push(item);
				}
			});
			return [trueRes, falseRes];
		}
		
		/**
		 * 各要素に対してブロックを評価し、その値が偽であった要素を集めた新しい配列を返します。
		 * select()、findAll()の逆。
		 * @param	iterator	評価式。
		 * function(item:*, index:int):Boolean
		 * @return
		 */
		public function reject(iterator:Function):Array {
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, collection:Object):void {
				if (false == iterator(item, index)) {
					res.push(item);
				}
			});
			return res;
		}
		
		// TODO	sort(),sortBy()大変そうなので未実装
		//public function sort(compareFunction:Function):Array
		//public function sortBy(iterator:Function):Array
		
		/**
		 * 全ての要素を含む配列を返します。つまり配列化する。
		 * @return
		 */
		public function entries():Array {
			var res:Array = new Array();
			$component.forEach(function(item:*, index:int, collection:Object):void {
				res.push(item);
			});
			return res;
		}
		
		
		/**
		 * 現在の集合に与えられた集合をマージする。 
		 * このマージ操作は現在の集合と同じ要素数の新しい配列を返し、返される配列の各要素はマージされる集合の各々から同じ index のものを集めたものの配列 (以下 sub-array と表記) となる。
		 * transform 関数が指定された場合、各 sub-array は返される前にその関数を使って変換される。（要は各 sub-array にmap(transform)する。）
		 * @param	collection1[, collection2 [, ... collectionN ]]	
		 * @param	transform	
		 * function(item:*, index:int):*
		 * @return
		 * @example <listing version="3.0" >
		 * zip(collection1[, collection2 [, ... collectionN [,transform]]])
		 * </listing>
		 * @example <listing version="3.0" >
		 * trace(new Enumerable([1,2,3]).zip([4,5,6], [7,8,9]));	// "[ [1,4,7],[2,5,8],[3,6,9] ]" を返す。
		 * </listing>
		 * @example <listing version="3.0" >
		 * // ベクトルの内積
		 * var va=[1,3];
		 * var vb=[3,4];
		 * var enu:Enumerable = Enumerable.enumerator(va);
		 * var r = Enumerable.enumerator(enu.zip(vb)).inject(0,function(s:Number,v:Array):*{return s+v[0]*v[1]});
		 * </listing>
		 * @see	http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/18848
		 * @see	http://634.ayumu-baby.com/pukiwiki/index.php?JavaScript/Prototype/Enumerable#z93ac035
		 */
		public function zip(...rest:Array):* {
			var res:Array = new Array();
			var arrs:Array;
			var last:* = rest[rest.length - 1];
			if (last is Function) {
				// 関数あり
				arrs = rest.slice(0, rest.length - 1);
				$component.forEach(function(item:*, index:int, collection:Object):void {
					res.push([item].concat($zipArrays(index, arrs)));
				});
				return res.map(last, null);
			}else {
				// 関数なし
				arrs = rest;
				$component.forEach(function(item:*, index:int, collection:Object):void {
					res.push([item].concat($zipArrays(index, arrs)));
				});
				return res;
			}
		}
		
		/**
		 * 2次元配列から指定インデックスの要素だけ抜き出した配列を返す。
		 * @param	index
		 * @param	arrs
		 * @return
		 */
		private function $zipArrays(index:int, arrs:Array):Array {
			var res:Array = new Array();
			arrs.forEach(function(item:*, i:int, arr:Array):void {
				res.push(item[index]);
			});
			return res;
		}
		
	}

}