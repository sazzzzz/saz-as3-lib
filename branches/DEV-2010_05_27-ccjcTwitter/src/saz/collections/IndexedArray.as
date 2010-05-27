package saz.collections {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import saz.flash.IArray;
	
	/**
	 * 索引つきArray
	 * @author saz
	 * @deprecated	つくりかけたけど、要素の変更を完全にはキャッチできないので、廃止する。==>できなくはない。arr[0]でのアクセスも補足できる。
	 * @see	http://www.techscore.com/tech/DesignPattern/Decorator.html
	 * @see	http://livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/flash/utils/Proxy.html#includeExamplesSummary
	 * @see	http://kozy.heteml.jp/l4l/2008/06/as3proxy.html
	 */
	//dynamic class IndexedArray extends Proxy implements IArray {		// implements IArray がコンパイルエラーに…当たり前か。
	dynamic public class IndexedArray extends Proxy {
		
		private var $item:Array;
		
		public function IndexedArray(arr:Array = null) {
			$item = (null==arr) ? new Array() : arr;
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):*{
			var res:*;
			switch(methodName.toString()) {
				// Arrayインスタンスを返すもの。＝IndexedArrayインスタンスを返すように、変更する必要があるもの
				case 'concat':			// パラメータで指定されたエレメントを配列内のエレメントと連結して、新しい配列を作成します。
				case 'filter':			// 
				case 'map':				// 
				case 'reverse':			// 
				case 'slice':			// 
				case 'sort':			// 
				case 'sortOn':			// 
				case 'splice':			// 
					res = new IndexedArray($item[methodName].apply($item, args));
					break;
				// 配列の内容が変更される可能性があるもの
				case 'every':			// 
				case 'XXX':			// 
				case 'XXX':			// 
				case 'XXX':		// 
				case 'XXX':		// 
				case 'XXX':		// 
				case 'XXX':			// 
				case 'XXX':				// 
					res = $item[methodName].apply($item, args);
					break;
				default:
					res = $item[methodName].apply($item, args);
					break;
			}
			return res;
		}
		
		override flash_proxy function getProperty(name:*):*{
			trace("IndexedArray.getProperty(" + arguments);
			return $item[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void {
			trace("IndexedArray.setProperty(" + arguments);
			$item[name] = value;
		}
	}
	
}