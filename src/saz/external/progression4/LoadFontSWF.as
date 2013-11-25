package saz.external.progression4
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;
	
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	
	/**
	 * フォントを埋め込んだSWFをロードし、グローバルフォントリストに登録する。
	 * @author saz
	 */
	public class LoadFontSWF extends SerialList {
		
		/**
		 * フォントを埋め込んだSWFのURL。
		 */
		public var url:String = "";
		
		/**
		 * フォントのリンケージ名のリスト。
		 */
		public var linkageNames:Array;
		
		
		private var loader:Loader;
		private var context:LoaderContext;
		
		
		/**
		 * 新しい LoadFontSWF インスタンスを作成します。
		 * 埋め込みフォントを使用する時は、TextFormat.fontにFont.fontNameを指定する。
		 * 
		 * @param initObject
		 * 
		 */
		public function LoadFontSWF( swfUrl:String, linkages:Array, initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			url = swfUrl;
			linkageNames = linkages;
			
			
			/*loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);*/
			context = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			
			addCommand(
				new LoadSWF(new URLRequest(url), null, {context:context})
				,function():void
				{
					registFonts(linkageNames);
				}
			);
		}
		
		private function registFonts(names:Array):void
		{
			names.forEach(function(item:String, index:int, arr:Array):void
			{
				var FontClass:Class = ApplicationDomain.currentDomain.getDefinition(item) as Class;
				Font.registerFont(FontClass);
			});
		}
		
		
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new LoadFontSWF( this );
		}
	}
}
