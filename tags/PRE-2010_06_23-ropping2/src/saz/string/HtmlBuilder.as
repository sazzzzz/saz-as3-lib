package saz.string {
	/**
	 * HTMLタグを生成する。
	 * @author saz
	 * @see	http://www.kanzaki.com/docs/html/xhtml1.html
	 */
	public class HtmlBuilder{
		
		/**
		 * HTMLモード。modeに設定する。
		 */
		public static const MODE_HTML:String = "html";
		/**
		 * XHMLモード。modeに設定する。
		 */
		public static const MODE_XHTML:String = "xhtml";
		
		/**
		 * クオート記号。
		 */
		public var quoter:String = '"';
		
		private var $mode:String = MODE_HTML;
		
		private var $emptyTagEnd:String = ">";
		
		private static var $instance:HtmlBuilder = null;
		
		function HtmlBuilder(caller:Function = null) {
			if (HtmlBuilder.getInstance != caller) {
				throw new Error("HtmlBuilderクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != HtmlBuilder.$instance) {
				throw new Error("HtmlBuilderインスタンスはひとつしか生成できません。");
			}
		}
		
		/**
		 * HTMLモードを返す。MODE_HTML|MODE_XHTML。
		 */
		public function get mode():String { return $mode; }
		
		/**
		 * HTMLモードを設定する。MODE_HTML|MODE_XHTML。
		 */
		public function set mode(value:String):void {
			$mode = value;
			switch(value) {
				case MODE_HTML:
					$emptyTagEnd = ">";
					break;
				case MODE_XHTML:
					// 4. 空要素のタグは />で閉じる
					// また、HTMLのimg要素やbr要素のように、内容モデルを持たない空要素（HTMLでは開始タグしか使わないもの）は、
					// XMLにおいては < br / > という具合に、タグを閉じるときに / > を使わなければなりません（空要素タグと呼ばれています）。
					// ただし、この書式ではHTMLブラウザがタグを正しく認識できない可能性があるので、 / の前にスペースを置いて、 
					// <br /> のように記述します。
					$emptyTagEnd = " />";
					break;
				default:
					$emptyTagEnd = ">";
			}
		}
		
		/**
		 * HTMLタグを生成する。
		 * @param	text	タグに囲まれているテキスト。
		 * @param	name	タグ名。
		 * @param	attributes	属性を表すObject。キー名がASで使えない名前のときは、最初に"_"をつける。class -> _class。
		 * @return
		 * @example <listing version="3.0" >
		 * import saz.string.*;
		 * var hb:HtmlBuilder = HtmlBuilder.getInstance();
		 * var atts:Object={
		 * 	href:"index.html", _class:"class1"
		 * };
		 * trace(hb.createTag("TEST", "a", atts));
		 * trace(hb.createTag(null, "a", atts));
		 * </listing>
		 */
		public function createTag(name:String, attributes:Object = null, text:String = null):String {
			if (null == text) {
				return emptyTag(name, attributes);
			}else {
				return startTag(name, attributes) + text + endTag(name);
			}
		}
		
		/**
		 * 空要素タグを生成。
		 * @param	name	タグ名。
		 * @param	attributes	属性を表すObject。
		 * @return
		 */
		public function emptyTag(name:String, attributes:Object):String {
			return "<" + name + buildAttributes(attributes) + $emptyTagEnd;
		}
		
		/**
		 * 開始タグを生成。
		 * @param	name	タグ名。
		 * @param	attributes	属性を表すObject。
		 * @return
		 */
		public function startTag(name:String, attributes:Object):String {
				return "<" + name + buildAttributes(attributes) + ">";
		}
		
		/**
		 * 終了タグを生成。
		 * @param	name	タグ名。
		 * @return
		 */
		public function endTag(name:String):String {
				return "</" + name + ">";
		}
		
		
		/**
		 * 属性オブジェクトを展開。
		 * @param	attributes	属性を表すObject。
		 * @return
		 */
		public function buildAttributes(attributes:Object):String {
			var res:String = "";
			for (var element:String in attributes) {
				res += buildAttribute(element, attributes[element]);
			}
			return res;
		}
		
		/**
		 * 属性文字列を生成。
		 * @param	name
		 * @param	value
		 * @return
		 */
		public function buildAttribute(name:String, value:*):String {
			// 名前が"_"で始まるものは、1文字目を削除。
			return " " + (("_" == name.substr(0, 1)) ? name.substr(1) : name) + "=" + quoter + value + quoter;
		}
		
		/**
		 * インスタンスを作成。
		 * @return
		 */
		public static function getInstance():HtmlBuilder {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new HtmlBuilder(arguments.callee);
			}
			return $instance;
		}
		
	}

}