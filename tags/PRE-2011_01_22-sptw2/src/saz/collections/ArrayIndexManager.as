package saz.collections {
	import saz.util.ArrayUtil;
	import saz.util.ObjectUtil;
	
	/**
	 * 配列の索引管理。<br/>
	 * 索引リセットを忘れると危険なので、このクラスを素で使わないように。これと対象Arrayを内包するクラスを作って利用するとか。<br/>
	 * @author saz
	 */
	public class ArrayIndexManager extends Array {
		
		private var $target:Array;
		/**
		 * 索引の消去が必要かどうか。
		 */
		private var $needFlush:Boolean = false;
		private var $indexDatas:Object;
		
		/**
		 * 動作方針：
		 * なるべく軽く。余計な処理をしないように。
		 * 索引データは必要になった時に、使う直前に作成。
		 * 不要になった索引データの削除もギリギリまで行わない。
		 */
		public function ArrayIndexManager(target:Array) {
			$target = target;
			$indexDatas = new Object();
			
			super();
		}
		
		
		/**
		 * 索引をリセットする。配列の要素に変化があったら呼ぶように。
		 */
		public function indexFlush():void {
			$needFlush = true;
		}
		
		/**
		 * 配列の中から、指定キーと値をもつ要素を返す。
		 * @param	key
		 * @param	value
		 * @return	指定キーと値をもつ要素を返す。見つからない場合はnullを返す。
		 */
		public function search(key:String, value:*):*{
			//trace("ArrayIndexManager.search(" + arguments);
			//trace(ObjectUtil.dump(getIndexData(key)));
			return $target[getIndexData(key)[value]];
		}
		
		/**
		 * 指定キー名の索引データを返す。<br/>
		 * @example <listing version="3.0" >
		 * 入力：[{id:"001"}, {id:"002"}]
		 * 出力：{001:0, 002:1}
		 * </listing>
		 * @param	key
		 * @return
		 */
		public function getIndexData(key:String):Object {
			var res:Object;
			
			if (true == $needFlush) {
				//索引データをフラッシュ
				$needFlush = false;
				$clearIndexData();
				res = $createIndexData(key);
				$indexDatas[key] = res;
				return res;
			}else if (null == $indexDatas[key]) {
				//索引データがまだないので作る
				res = $createIndexData(key);
				$indexDatas[key] = res;
				return res;
			}else {
				return $indexDatas[key];
			}
		}
		
		/**
		 * 管理対象のArrayインスタンスを返す。
		 */
		public function get target():Array { return $target; }
		
		
		
		/**
		 * 索引をクリア。
		 */
		private function $clearIndexData():void {
			ObjectUtil.removeAll($indexDatas);
		}
		
		/**
		 * 索引を作って返す。
		 * @param	key
		 * @return
		 */
		private function $createIndexData(key:String):Object {
			//$indexDatas[key] = ArrayUtil.createIndexData($target, key);
			return ArrayUtil.createIndexData($target, key);
		}
		
		//--------------------------------------
		// 以下、Arrayインターフェースを実装しようとしたけど、ここに作るべきじゃない。
		// ExArrayとか別のクラスとして実装すべき。
		//--------------------------------------
		
		/*public function concat(... args:Array):Array {
			return $target.concat.apply(null, args);
		}
		public function every(callback:Function, thisObject:*= null):Boolean {
			return $target.every(callback, thisObject);
		}
		public function filter(callback:Function, thisObject:*= null):Array {
			return $target.filter(callback, thisObject);
		}
		public function forEach(callback:Function, thisObject:*= null):void {
			indexFlush();
			$target.forEach(callback, thisObject);
		}
		public */
		
		
	}
	
}