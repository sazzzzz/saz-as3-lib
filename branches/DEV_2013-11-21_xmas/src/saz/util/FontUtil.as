package saz.util
{
	import flash.display.Loader;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;

	public class FontUtil
	{
		
		/**
		 * 埋め込みフォントのfontNameを配列で返す。
		 * 埋め込みフォントを使用する時は、TextFormat.fontにFont.fontNameを指定する。
		 * @return 
		 */
		public static function embeddedFontNameList():Array
		{
			var res:Array = [];
			Font.enumerateFonts(false).forEach(function(item:Font, index:int, arr:Array):void
			{
				/*trace(item.fontName, item.fontStyle, item.fontType);*/
				res.push(item.fontName);
			});
			return res;
		}
		
		/**
		 * フォントSWFロード用にLoaderContextを生成する。
		 * @return 
		 * 
		 * @example サンプルコード:
		 * <listing version="3.0">
		 * loader.load(new URLRequest("fonts_en.swf"), FontUtil.createLoaderContext());
		 * </listing>
		 */
		public static function createLoaderContext():LoaderContext
		{
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			return context;
		}
		
		/**
		 * 配列で指定したリンケージ名のフォントを、グローバルフォントリストに登録します。
		 * 
		 * @param linkageNames
		 * @param domain
		 */
		public static function registerFontsByNames(linkageNames:Array, domain:ApplicationDomain):void
		{
			linkageNames.forEach(function(item:String, index:int, arr:Array):void
			{
				registerFontByName(item, domain);
			});
		}
		
		/**
		 * 指定したリンケージ名のフォントを、グローバルフォントリストに登録します。
		 * 
		 * @param linkageName	リンケージ名。
		 * @param domain	
		 */
		public static function registerFontByName(linkageName:String, domain:ApplicationDomain):void
		{
			var FontClass:Class = ApplicationDomain.currentDomain.getDefinition(linkageName) as Class;
			Font.registerFont(linkageName);
		}
		
	}
}