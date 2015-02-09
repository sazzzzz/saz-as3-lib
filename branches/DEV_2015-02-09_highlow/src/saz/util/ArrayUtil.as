package saz.util {
	import saz.errors.IteratorBreakError;
	
	/**
	 * Arrayユーティリティークラス。
	 * @author saz
	 */
	public class ArrayUtil {
		
		
		//--------------------------------------
		// 計算系
		//--------------------------------------
		
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
		
		//--------------------------------------
		// 検索系
		//--------------------------------------
		
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
			//trace("ArrayUtil.createIndexData(", arguments);
			var res:Object = new Object;
			var value:*;
			
			target.forEach(function(item:*, index:int, arr:Array):void {
				// Objectでなかったら無視
				if ("object" == typeof(item)) {
					value = item[key];
					//trace(item, index, value);
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
		 * 配列同士の重複チェック。searchのそれぞれの要素と同じものが、targetに含まれるかを調べる。
		 * @param target
		 * @param search
		 * @return {search:x, target:xx}。searchプロパティは、searchの中のどの要素を発見したかを表すインデックス。targetプロパティは、targetのどこで発見したかを表すインデックス。
		 * 
		 */
		public static function findDuplicates(target:Array, search:Array):Object
		{
			var res:Object = {};
			var fidx:int;
			var item:Object;
			for (var i:int = 0, n:int = search.length; i < n; i++) 
			{
				item = search[i];
				fidx = target.indexOf(item);
				if (fidx > -1){
					return {search:i, target:fidx};
				}
			}
			return null;
		}
		
		
		/**
		 * 配列から指定されたものを探し、最初に見つかったインデックスを返す。
		 * @param	target
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
		 * 配列の中から、指定した名前と値を持つ最初の要素を返す
		 * @param	target	対象とする配列
		 * @param	key	探す名前
		 * @param	value	探す値
		 * @return
		 */
		public static function search(target:Array, key:String, value:*):*{
			var res:*= null;
			
			// forEachはループの途中で抜けれないみたい…。break [label]でもダメ。
			target.forEach(function(item:*, index:int, arr:Array):void {
				//trace(item, index);
				if (null == res && value == item[key]) {
					res = item;
				}
			});
			return res;
		}
		
		
		//--------------------------------------
		// 便利系
		//--------------------------------------
		
		
		public static function clone(src:Array):Array{
			/*var res:Array = [];
			copy(src, res);
			return res;*/
			return src.concat();
		}
		
		/**
		 * src配列から、dst配列に要素をコピー.dstに上書きされる.
		 * @param src	コピー元配列.
		 * @param dst	コピー先配列.
		 */
		public static function copy(src:Array, dst:Array):void{
			for (var i:int=0, n:int=src.length; i < n; i++) {
				dst[i]=src[i];
			}
		}
		
		/**
		 * Objectの配列から、指定プロパティのリストを生成. 
		 * @param	target
		 * @param	propName
		 * @return
		 * @example <listing version="3.0" >
		 * // フレームラベル名->フレーム数変換用のキャッシュオブジェクトを生成
		 * var labelCache:Object = ArrayUtil.arrayToObject(ArrayUtil.propertyList(mc.currentLabels, "name"), ArrayUtil.propertyList(mc.currentLabels, "frame"));
		 * </listing>
		 */
		public static function propertyList(target:Array, propName:String):Array {
			var res:Array = new Array(target.length);
			for (var i:int = 0, n:int = target.length; i < n; i++) {
				res[i] = target[i][propName];
			}
			return res;	
		}
		
		/**
		 * Objectの配列から、指定メソッドの結果のリストを生成. 
		 * @param	target
		 * @param	methodName
		 * @param	args	メソッドの引数. nullまたはArray. nullの場合は引数なし. 長さ1の配列なら全て同じ引数を使う. 長さ1以上の配列なら各要素を使用. 
		 * @return	メソッドを実行した結果を格納した配列. 
		 */
		public static function methodList(target:Array, methodName:String, args:Array = null):Array {
			var res:Array = new Array(target.length);
			var i:int, n:int;
			if (args == null) {
				for (i = 0, n = target.length; i < n; i++) {
					res[i] = target[i][methodName]();
				}
			}else if (args.length == 1) {
				for (i = 0, n = target.length; i < n; i++) {
					res[i] = target[i][methodName](args[0]);
				}
			}else {
				for (i = 0, n = target.length; i < n; i++) {
					res[i] = target[i][methodName](args[i]);
				}
			}
			return res;	
		}
		
		
		/**
		 * キーのリストと値のリストから、Objectを生成. （キャッシュ用）
		 * @param	names	キーのリスト. 
		 * @param	values	値のリスト. 
		 * @return	キャッシュ用のObject. 
		 * @example <listing version="3.0" >
		 * // フレームラベル名->フレーム数変換用のキャッシュオブジェクトを生成
		 * var labelCache:Object = ArrayUtil.arrayToObject(ArrayUtil.propertyList(mc.currentLabels, "name"), ArrayUtil.propertyList(mc.currentLabels, "frame"));
		 * </listing>
		 */
		public static function arrayToObject(names:Array, values:Array):Object {
			var res:Object = { };
			for (var i:int = 0, n:int = names.length; i < n; i++) {
				res[names[i]] = values[i];
			}
			return res;
		}
		
		
		
		/**
		 * 配列内の要素をランダムに返す.
		 * @param	target
		 * @return
		 */
		public static function random(target:Array):*{
			return target[Math.floor(Math.random() * target.length)];
		}
		
		/**
		 * 配列から指定した名前のプロパティを抜き出した配列を作る。<br/>
		 * @param	target	対象とする配列。
		 * @param	key	プロパティ名。
		 * @return
		 * @example <listing version="3.0" >
		 * var dataList:Array = [{name:"田中",count:10},{name:"山田",count:1},{name:"太一",count:3}];
		 * var countList:Array = ArrayUtil.createPropertyList(dataList, "count");
		 * trace(countList);
		 * </listing>
		 */
		public static function createPropertyList(target:Array, key:String):Array {
			var res:Array = new Array(target.length);
			target.forEach(function(item:*, index:int, arr:Array):void {
				res[index] = item[key];
			});
			return res;
		}
		
		/**
		 * 指定インデックスで2次元配列に分けて返す。
		 * @param	target	対象とする配列。
		 * @param	count	1つ目の配列の長さ。例えば、長さ４の配列、count=1を指定すると、長さ1,3の配列を返す。
		 * @return	2次元配列。
		 */
		//public static function split(target:Array, count:int = 1):/*Array*/Array {
			//
			//
		//}
		
		/**
		 * いわゆるmap(). 
		 * @param	target	対象配列. 
		 * @param	iterator	イテレータ. funciton(item:*)
		 * @see	http://blog.livedoor.jp/dankogai/archives/50614134.html
		 */
		public static function map(target:Array, iterator:Function):Array {
			var res:Array = [];
			for (var i:int = 0, len:int=target.length; i < len; i++) {
				res[i] = iterator(target[i]);
			}
			return res;
		}
		
		/**
		 * 配列の要素をシャッフルする。
		 * @param	target
		 */
		public static function shuffle(target:Array):void {
			return shuffleFY(target);
		}
		
		/**
		 * 配列の要素をFisher-Yates法でシャッフルする。
		 * 
		 * @param target	対象配列。
		 * @param randomFnc	乱数生成関数を指定。デフォルトではMath.randomを使用。
		 * 
		 * @see	http://blog.livedoor.jp/dankogai/archives/50614134.html
		 */
		public static function shuffleFY(target:Array, randomFnc:Function=null):void {
			
			var rnd:Function = randomFnc || Math.random;
			
			var i:int = target.length;
			var j:int, t:*;
			while (i) {
				/*j = Math.floor(Math.random() * i);*/
				j = Math.floor(rnd() * i);
				t = target[--i];
				target[i] = target[j];
				target[j] = t;
			}
		}
		
		
		/**
		 * 指定した値で埋める。
		 * @param	target
		 * @param	value
		 */
		public static function fill(target:Array, value:*):void {
			// forがいちばん早い
			// for			477
			// forEach		2197
			// join&split	4999
			for (var i:int = 0, n:int = target.length; i < n; i++) {
				target[i] = value;
			}
		}
		
		
		/**
		 * 連番で埋める. 
		 * value <= endValueになったら処理を中断するので、配列の最後の値＝endValueになるとは限らない. 
		 * Rubyの[1..n]みたいに書きたかった.
		 * @param	target	対象とする配列
		 * @param	startValue
		 * @param	endValue	startValue==endValueの場合、1つ目の要素のみ設定される. 
		 * @param	step	増分. startValue<endValueならプラスの値を、startValue>endValueならマイナスの値を指定すること. 0を指定するとエラー. 
		 * @example <listing version="3.0" >
		 * var arr = [];
		 * ArrayUtil.fillSerialInt(arr,1,6);
		 * var factorial:int = new Enumerable().inject(null,function(result:int, item:int):int{
		 * 	return result*item;
		 * });
		 * </listing>
		 * @see	http://www.4gamer.net/games/131/G013104/20110909047/screenshot.html?num=011
		 */
		public static function fillSerialInt(target:Array, startValue:int, endValue:int, step:int = 1):void {
			if (step == 0) throw new ArgumentError("ArrayUtil.fillSerialInt()");
			
			if ((startValue < endValue && step < 0) || (startValue > endValue && step > 0)) step = -step;
			var i:int, value:int;
			if (startValue == endValue) {
				target[0] = startValue;
			}else if (startValue < endValue) {
				for (i = 0, value = startValue; value <= endValue; i++, value += step) {
					target[i] = value;
				}
			}else{
				for (i = 0, value = startValue; value >= endValue; i++, value += step) {
					target[i] = value;
				}
			}
		}
		
		
		
		
		/**
		 * 指定要素を削除する. 
		 * @param	target	対象とする配列
		 * @param	startIndex	削除を開始するインデックス.
		 * @param	count	削除する数.
		 * @return	削除したエレメントを含む配列です.
		 */
		public static function remove(target:Array, startIndex:int, count:uint = 1):Array {
			return target.splice(startIndex, count);
		}
		
		/**
		 * Array内のすべての要素を削除する。
		 * @param	target	対象とする配列
		 */
		public static function removeAll(target:Array):void {
			//target.splice(0);
			// http://www.coltware.com/2009/07/14/flex_array_delete_item/
			target.length = 0;
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