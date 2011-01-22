package saz.util {
	import flash.display.LoaderInfo;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * テキスト用ユーティリティークラス.
	 * @author saz
	 */
	public class TextUtil {
		
		/**
		 * TextFormatのプロパティ名リスト. textFormatToString用.
		 */
		public static const TEXTFORMAT_PROPS:Array = ["align", "blockIndent", "bold", "bullet", "color", "font", "indent", "italic", "kerning", "leading", "leftMargin", "letterSpacing", "rightMargin", "size", "tabStops", "target", "underline", "url"];
		
		static private var $fonts:Object;
		
		
		/**
		 * TextFieldからTextFormatをコピーして、別のTextFieldに適用する.
		 * 具体的には、srcからgetTextFormat()して、targetのsetTextFormat()とdefaultTextFormatに指定.
		 * @param	src	TextFormatを取り出すTextField.
		 * @param	target	TextFormatを適用する先. 省略した場合は、srcに適用する.
		 */
		public static function attachTextFormat(src:TextField, target:TextField = null):void {
			var fmt:TextFormat = src.getTextFormat();
			if (!target) target = src;
			target.setTextFormat(fmt);
			target.defaultTextFormat = fmt;
		}
		
		
		
		/**
		 * 登録したフォントインスタンスを返す.
		 * @param	name	
		 * @return
		 * @see	#registerExternalFont
		 */
		static public function getFont(name:String):Font {
			return ($fonts) ? $fonts[name] : null;
		}
		
		/**
		 * フォントインスタンスを登録する.
		 * @param	font	
		 * @param	name	
		 * @see	#registerExternalFont
		 */
		static public function setFont(font:Font, name:String = ""):void {
			if ("" == name) name = font.fontName;
			if (!$fonts)$fonts = new Object();
			$fonts[name] = font;
		}
		
		
		
		/**
		 * 外部swfから指定した名前のフォントクラスを取り出し、グローバルフォントに登録する.
		 * 読み込む側の、FlashIDE上にそのフォントを指定したダイナミックテキストがあるとNG.
		 * @param	loaderInfo	LoaderのLoaderInfoインスタンス.
		 * @param	fontName	フォントクラス名.
		 * @return
		 * @example <listing version="3.0" >
		 * import saz.util.*;
		 * //フォントクラスの参照
		 * var MaruFolkHFont:Class;
		 * var fontLoader = new Loader();
		 * fontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fontLoader_complete2);
		 * fontLoader.load(new URLRequest("../bin-debug/fonts.swf"));
		 * 
		 * function fontLoader_complete2 (e) {
		 * 	//読み込んだswfからフォントの参照を取得する
		 * 	MaruFolkHFont = TextUtil.registerExternalFont(fontLoader.contentLoaderInfo,"MaruFolkH");
		 * 	//フォントのインスタンスを作り、TextUtilに登録
		 * 	TextUtil.setFont(new MaruFolkHFont(),"MaruFolkH");
		 * 	
		 * 	//テキストを表示する
		 * 	var tf = new TextFormat();
		 * 	tf.font = TextUtil.getFont("MaruFolkH").fontName;	//fontNameで指定
		 * 	dspText.embedFonts = true;
		 * 	dspText.setTextFormat(tf);
		 * 	dspText.defaultTextFormat = tf;
		 * }
		 * </listing>
		 * @see	http://www.adobe.com/jp/newsletters/edge/october2009/articles/article2/
		 * @see	http://loftimg.jp/blog/actionscript/post-13.php
		 */
		static public function registerExternalFont(loaderInfo:LoaderInfo, fontName:String):Class {
			//var FontClass:Class = loaderInfo.applicationDomain.getDefinition(fontName) as Class;
			//var FontClass:Class = DisplayUtil.getExternalClass(loaderInfo, fontName);
			var FontClass:Class = ClassUtil.extractClass(loaderInfo, fontName);
			Font.registerFont(FontClass);
			return FontClass;
		}
		
		
		/**
		 * TextFormatのプロパティ一覧をStringにして返す. ObjectUtil.propertiesToString形式
		 * @param	target
		 * @return
		 */
		public static function textFormatToString(target:TextFormat):String {
			return ObjectUtil.propertiesToString(target, TEXTFORMAT_PROPS);
		}
		
	}

}