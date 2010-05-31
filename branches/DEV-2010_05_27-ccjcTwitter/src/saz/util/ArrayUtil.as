package saz.util {
	import saz.IteratorBreakError;
	
	/**
	 * Arrayユーティリティークラス。
	 * @author saz
	 */
	public class ArrayUtil {
		
		/**
		 * 配列から指定した名前のプロパティを抜き出した配列を作る。<br/>
		 * @param	target	対象とする配列
		 * @param	key	プロパティ名。
		 * @return
		 */
		public static function createPropertyList(target:Array, key:String):Array {
			var res:Array = new Array(target.length);
			target.forEach(function(item:*, index:int, arr:Array):void {
				res[index] = item[key];
			});
			return res;
		}
		
		/**
		 * 配列の内容から、検索用索引Objectを作る。プロパティ名を指定できる。<br/>
		 * 配列内の要素が数値型の場合は、TypeErrorが発生。<br/>
		 * makeIndexDataから名前変更。<br/>
		 * @param	taget
		 * @param	key	プロパティ名。デフォルトは"id"。
		 * @return
		 * @example <listing version="3.0" >
		 * 入力：[{id:"001"}, {id:"002"}]
		 * 出力：{001:0, 002:1}
		 * </listing>
		 */
		public static function createIndexData(target:Array, key:String = "id"):Object {
			var res:Object = new Object;
			var value:Object;
			
			target.forEach(function(item:*, index:int, arr:Array):void {
				// Objectでなかったら無視
				if ("object" == typeof(item)) {
					value = item[key];
					if ("number" == typeof(value)) {
						// 数値型だとキーにできないので、エラー
						throw new TypeError("ArrayUtil.createIndexData(): 値が数値型のため、プロパティ名にできません。");
					}
					res[value] = index;
				}
			});
			
			return res;
		}
		
		/**
		 * インデックス0からの積算を計算し、配列で返す。
		 * @param	target	数値の配列。
		 * @return	インデックス1には0-1の積算、インデックス2には0-2の積算。
		 * @example <listing version="3.0" >
		 * [2,2,2,2]
		 * ->[2,4,6,8]
		 * </listing>
		 */
		public static function estimateList(target:Array):Array {
			var res:/*Number*/Array = new Array(target.length);
			res[0] = target[0];
			for (var i:int = 1, len:int = target.length; i < len; i++) {
				res[i] = res[i - 1] + target[i];
			}
			return res;
		}
		
		/**
		 * 指定した値で埋める。
		 * @param	target
		 * @param	value
		 */
		public static function fill(target:Array, value:*):void {
			target.map(function(item:*, index:int, arr:Array):void {
				return value;
			});
		}
		
		/**
		 * 配列から指定されたものを探し、最初に見つかったインデックスを返す。
		 * @param	targe
		 * @param	search
		 * @return	インデックスを返す。見つからなかったら-1を返す。
		 */
		public static function find(target:Array, search:*):int {
			var res:Number = -1;
			target.forEach(function(item:*, index:int, arr:Array):void {
				if ( -1 == res && item == search) res = index;
			});
			return res;
		}
		
		/**
		 * 配列の要素の合計を計算。
		 * @param	target
		 * @return
		 */
		public static function sum(target:Array):Number {
			var res:Number = 0;
			target.forEach(function(item:*, index:int, arr:Array):void {
				res += item;
			});
			return res;
		}
		
		/**
		 * 配列の要素の最小値を返す。Math.min()のエイリアス。
		 * @param	target
		 * @return
		 */
		public static function min(target:Array):Number {
			return Math.min.apply(null, target);
		}
		
		/**
		 * 配列の要素の最大値を返す。Math.max()のエイリアス。
		 * @param	target
		 * @return
		 */
		public static function max(target:Array):Number {
			return Math.max.apply(null, target);
		}
		
		/**
		 * Array内のすべての要素を削除する。
		 * @param	target	対象とする配列
		 */
		public static function removeAll(target:Array):void {
			target.splice(0);
		}
		
		/**
		 * 配列の中から、指定した名前と値を持つ最初の要素を返す
		 * @param	target	対象とする配列
		 * @param	key	探す名前
		 * @param	value	探す値
		 * @return
		 */
		public static function search(target:Array, key:String, value:*):*{
			var res:*= null;
			
			/*each(target, function(item:*, index:int) {
				if (value == item[key]) {
					res = item;
					throw new IteratorBreakError("ArrayUtil.search(): 発見");	//returnじゃ抜けれないよ
				}
			});*/
			
			// forEachはループの途中で抜けれないみたい…。break [label]でもダメ。
			target.forEach(function(item:*, index:int, arr:Array):void {
				//trace(item, index);
				if (null == res && value == item[key]) {
					res = item;
				}
			});
			return res;
		}
		
		/**
		 * Array内のすべての要素に何かする。いわゆるeach。<br/>
		 * ==>Array.forEach()とかあるじゃん！！！これ完全に不要。
		 * @deprecated	Array.forEach()があるので、廃止予定。
		 * @param	target	対象とする配列
		 * @param	iterator
		 */
		public static function each(target:Array, iterator:Function):void {
			try {
				for (var i:Number = 0, l:Number = target.length, item:*; i < l; i++) {
					item = target[i];
					iterator(item, i);
				}
			}catch (e:IteratorBreakError) {
				//ループを抜ける
				return;
			} catch (e:Error) {
				//trace("other error: "+e);
				throw e;	//外側にエラーを投げる
				return;
			}
		}
		
		/**
		 * ソート比較関数 手抜きサンプル。
		 * @param	a	
		 * @param	b	
		 * @return	ソート順により A が B より前に現れる場合は -1<br />
		 * A = B の場合は 0<br />
		 * ソート順により A が B より後に現れる場合は 1<br />
		 */
		public static function sortFunc(a:*, b:*):int {
			return a - b;	// 昇順
			//return b - a;	// 降順
		}
	}
	
}