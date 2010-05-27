package saz.collections {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * 索引つきリスト。<br/>
	 * ていうか、索引のキャッシュ管理を自動化するのって無理じゃね？要素がObjectだったら、その中身へのアクセスはわからん？
	 * @author saz
	 * @see	http://www.techscore.com/tech/DesignPattern/Decorator.html
	 * @see	http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/flash/utils/Proxy.html#includeExamplesSummary
	 * @see	http://kozy.heteml.jp/l4l/2008/06/as3proxy.html
	 */
	//dynamic public class IndexedList implements IList extends Proxy {		// Proxyにimplements使えないみたい。
	dynamic public class IndexedList extends Proxy {
		
		private var $list:List;
		private var $indexMan:ArrayIndexManager;
		
		/**
		 * 
		 * @param	list
		 */
		public function IndexedList(list:List = null) {
			$list = (null == list) ? new List() : list;
			$indexMan = new ArrayIndexManager($list.getArray());
		}
		
		public function search(key:String, value:*):*{
			return $indexMan.search(key, value);
		}
		
		//
		// メソッド
		//
		override flash_proxy function callProperty(methodName:*, ... args):*{
			var res:*;
			switch(methodName.toString()) {
				case 'clone':
					res = new IndexedList($list.clone());
					break;
				//要素が変更される可能性のあるオペレーション。
				case 'sets':			// 指定インデックスの位置にあるオブジェクトを置き換える。
				case 'append':			// リストの最後に追加。
				case 'prepend':			// リストの最初に追加。
				case 'remove':			// 与えられた要素をリストから削除する。
				case 'removeFirst':		// リストの最初の要素を削除する。
				case 'removeLast':		// リストの最後の要素を削除する。
				case 'removeAll':		// リストの全ての要素を削除する。
				case 'push':			// スタックに要素をプッシュする。
				case 'pop':				// スタックから要素をポップする。
					$indexMan.indexFlush();
					res = $list[methodName].apply($list, args);
					break;
				default:
					res = $list[methodName].apply($list, args);
					break;
			}
			return res;
		}
		
		//
		// プロパティ
		//
		override flash_proxy function getProperty(name:*):*{
			return $list[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void{
			$indexMan.indexFlush();
			$list[name] = value;
		}
		
	}
	
}