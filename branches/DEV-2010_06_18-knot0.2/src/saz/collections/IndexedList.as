package saz.collections {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * 索引つきリスト。<br/>
	 * Decoratorパターン。<br/>
	 * @author saz
	 * @see	http://www.techscore.com/tech/DesignPattern/Decorator.html
	 * @see	http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/flash/utils/Proxy.html#includeExamplesSummary
	 * @see	http://kozy.heteml.jp/l4l/2008/06/as3proxy.html
	 */
	dynamic public class IndexedList implements IList  {
		
		private var $list:IList;
		private var $indexMan:ArrayIndexManager;
		
		/**
		 * 
		 * @param	list
		 */
		public function IndexedList(list:IList = null) {
			$list = (null == list) ? new List() : list;
			$indexMan = new ArrayIndexManager($list.getArray());
		}
		
		
		/**
		 * キー名と値から、要素を探す。
		 * @param	key
		 * @param	value
		 * @return
		 */
		public function search(key:String, value:*):*{
			return $indexMan.search(key, value);
		}
		// グチ	このメソッドが実装したかっただけなのに、えらい回り道した。なんか失敗してる気がするし…
		
		
		public function getArray():Array { return $list.getArray(); }
		
		//
		// 取得
		//
		
		/**
		 * リスト内のオブジェクト数を返す。
		 * @return
		 */
		public function count():int {
			return $list.count();
		}
		
		/**
		 * 指定したインデックスの位置にあるオブジェクトを返す。
		 * @param	index	0から始まる整数値。
		 * @return
		 */
		public function gets(index:int):*{
			return $list.gets(index);
		}
		
		/**
		 * リスト内の最初のオブジェクトを返す。
		 * @return
		 */
		public function first():*{
			return $list.first();
		}
		
		/**
		 * リスト内の最後のオブジェクトを返す。
		 * @return
		 */
		public function last():*{
			return $list.last();
		}
		
		/**
		 * 指定インデックスの位置にあるオブジェクトを置き換える。
		 * @param	index	0から始まる整数値。
		 * @param	item
		 */
		public function sets(index:int, item:*):void {
			//trace("IndexedList.sets(" + arguments);
			$indexMan.indexFlush();
			$list.sets(index, item);
		}
		
		//
		// 追加
		//
		
		/**
		 * リストの最後に追加。
		 * @param	item
		 */
		public function append(item:*):void {
			$indexMan.indexFlush();
			$list.append(item);
		}
		
		/**
		 * リストの最初に追加。
		 * @param	item
		 */
		public function prepend(item:*):void {
			$indexMan.indexFlush();
			$list.prepend(item);
		}
		
		//
		// 削除
		//
		
		/**
		 * 与えられた要素をリストから削除する。
		 * @param	item
		 */
		public function remove(item:*):void {
			$indexMan.indexFlush();
			$list.remove(item);
		}
		
		/**
		 * リストの最初の要素を削除する。
		 */
		public function removeFirst():void {
			$indexMan.indexFlush();
			$list.removeFirst();
		}
		
		/**
		 * リストの最後の要素を削除する。
		 */
		public function removeLast():void {
			$indexMan.indexFlush();
			$list.removeLast();
		}
		
		/**
		 * リストの全ての要素を削除する。
		 */
		public function removeAll():void {
			$indexMan.indexFlush();
			$list.removeAll();
		}
		
		
		//
		// スタックインタフェース
		//
		
		/**
		 * （リストをスタックと見たときの）トップ要素を返す。
		 * @return
		 */
		public function top():*{
			return $list.top();
		}
		
		/**
		 * スタックに要素をプッシュする。
		 * @param	item
		 */
		public function push(item:*):void {
			$indexMan.indexFlush();
			$list.push(item);
		}
		
		/**
		 * スタックから要素をポップする。
		 * @return
		 */
		public function pop():*{
			$indexMan.indexFlush();
			return $list.pop();
		}
		
		
		
		/**
		 * 複製する。
		 * @return
		 */
		public function clone():* {
			return new IndexedList($list.clone());
		}
		
		/**
		 * デストラクタ。
		 */
		public function destroy():void {
			$indexMan = null;
			$list.destroy();
		}
		
		public function toString():String {
			return $list.toString();
		}
		
	}
	
}