package saz.util {
	import flash.display.LoaderInfo;
	import flash.utils.describeType;
	/**
	 * ...
	 * @author saz
	 */
	public class ClassUtil{
		
		
		
		/**
		 * 外部swfから指定した名前のクラスを取り出す.
		 * @param	loaderInfo	対象とするLoaderInfoインスタンス.
		 * @param	className	クラス名.
		 * @return
		 */
		public static function extractClass(loaderInfo:LoaderInfo, className:String):Class {
			return loaderInfo.applicationDomain.getDefinition(className) as Class;
		}
		
		
		/**
		 * 外部swfから指定した名前のクラスをまとめて取り出す.
		 * @param	loaderInfo	対象とするLoaderInfoインスタンス.
		 * @param	className	クラス名のリスト.
		 * @return	クラスのリスト.
		 */
		public static function extractClasses(loaderInfo:LoaderInfo, classNames:Array):/*Class*/Array {
			var res:/*Class*/Array = new Array();
			for each(var p in classNames) {
				res.push(loaderInfo.applicationDomain.getDefinition(p) as Class);
			}
			return res;
		}
		
		
	}

}