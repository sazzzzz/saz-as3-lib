package saz.collections {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * ...
	 * @author saz
	 * @see	http://www.techscore.com/tech/DesignPattern/Decorator.html
	 * @see	http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/flash/utils/Proxy.html#includeExamplesSummary
	 * @see	http://kozy.heteml.jp/l4l/2008/06/as3proxy.html
	 */
	public class IndexedList implements IList extends Proxy {
		
		private var $list:IList;
		private var $indexMan:ArrayIndexManager;
		
		/**
		 * 
		 * @param	list
		 */
		public function IndexedList(list:IList=new IList()) {
			$list = list;
			$indexMan = new ArrayIndexManager($list.array);
		}
		
		//
		// メソッド
		//
		override flash_proxy function callProperty(methodName:*, ... args):*{
			var res:*;
			switch(methodName.toString()) {
				case 'sets':			// 指定インデックスの位置にあるオブジェクトを置き換える。
				case 'append':			// リストの最後に追加。
				case 'prepend':			// リストの最初に追加。
				case 'remove':			// 与えられた要素をリストから削除する。
				case 'removeFirst':		// リストの最初の要素を削除する。
				case 'removeLast':		// リストの最後の要素を削除する。
				case 'removeAll':		// リストの全ての要素を削除する。
				case 'push':			// スタックに要素をプッシュする。
				case 'pop':				// スタックから要素をポップする。
					break;
				default:
					break;
			}
			res = _item[methodName].apply(_item, args);
			return res;
		}
		
		//
		// プロパティ
		//
		override flash_proxy function getProperty(name:*):*{
			return _item[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void{
			_item[name] = value;
		}
		
	}
	
}