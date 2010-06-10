package saz.util.tagcloud {
	import saz.string.HtmlBuilder;
	import saz.util.ArrayUtil;
	/**
	 * タグクラウド
	 * @author saz
	 * @see	http://kjirou.sakura.ne.jp/mt/2007/09/post_57.html
	 * @see	http://d.hatena.ne.jp/Kiske/20080404/1207310618
	 */
	public class TCMaker {
		
		/**
		 * ベースイベント名。
		 */
		public var eventName:String = "linkEvent";
		/**
		 * ベースクラス名。
		 */
		public var className:String = "lv";
		/**
		 * タグとタグの間の文字列。
		 */
		public var separator:String = " ";
		
		/**
		 * <a>タグ生成メソッド。
		 */
		public var createATag:Function;
		/**
		 * hrefの値を生成するメソッド。
		 */
		public var detectHref:Function;
		/**
		 * class名を生成するメソッド。
		 */
		public var detectClass:Function;
		
		private var $levelCalc:TCLevelCalculator;
		private var $htmlBuild:HtmlBuilder;
		
		/**
		 * コンストラクタ。
		 * @param	levelCalculator	（オプション）TCLevelCalculatorインスタンス。
		 * @example <listing version="3.0" >
		 * import saz.util.tagcloud.*;
		 * const DATS:Array = [{name:"js", count:10}, {name:"ruby", count:5}, {name:"php", count:3}, {name:"html", count:1}];
		 * var dats:Array = new Array();
		 * DATS.forEach(function(item:*, index:int, arr:Array):void{
		 * 	dats.push(new TCData(item.name,item.count));
		 * });
		 * 
		 * var css:StyleSheet = new StyleSheet();
		 * css.setStyle("a",{color:'#ffffff'});
		 * css.setStyle("a:hover",{color:'#cc3333'});
		 * css.setStyle("a:active",{color:'#ff0000'});
		 * for(var lv:int = 0; lv < 25; lv++){
		 * 	css.setStyle(".lv"+lv,{fontSize:""+(lv+12)});
		 * }
		 * 
		 * function clickHandler (e:TextEvent):void {
		 * 	trace(e.type, e.text);
		 * }
		 * 
		 * var tcm:TCMaker = new TCMaker();
		 * tf.styleSheet = css;
		 * tf.addEventListener("link", clickHandler);
		 * 
		 * tf.htmlText = tcm.createHtml(dats);
		 * </listing>
		 */
		public function TCMaker(levelCalculator:TCLevelCalculator=null) {
			$levelCalc = (null==levelCalculator) ? new TCLevelCalculator() : levelCalculator;
			
			$htmlBuild = HtmlBuilder.getInstance();
			createATag = $createATag;
			detectHref = $detectHref;
			detectClass = $detectClass;
		}
		
		/**
		 * 自動でレベルを決定し、HTMLを生成する。
		 * @param	dataList	TCDataの配列。
		 * @return
		 */
		public function createHtml(dataList:/*TCData*/Array):String {
			var countList:Array = ArrayUtil.createPropertyList(dataList, "count");
			detectRange(countList);
			return buildHtml(dataList);
		}
		
		/**
		 * カウント数の配列からレベルを決定
		 * @param	countList
		 */
		public function detectRange(countList:/*Number*/Array):void {
			$levelCalc.detectRange(countList);
		}
		
		/**
		 * HTMLを生成する。事前にレベルの決定が必要。
		 * @param	dataList
		 * @return
		 */
		public function buildHtml(dataList:/*TCData*/Array):String {
			var res:String = "";
			if (0 == $levelCalc.maxCount) {
				// 0
			}else {
				dataList.forEach(function(item:TCData, index:int, arr:Array):void {
					res += $createATag(item, index, $levelCalc.calcLevel(item.count)) + separator;
				});
			}
			return res;
		}
		
		/**
		 * デフォルト<a>タグ生成メソッド。
		 * @param	dat	TCDataインスタンス。
		 * @param	index	配列インデックス。
		 * @param	level	タグクラウドレベル。
		 * @return
		 */
		private function $createATag(dat:TCData, index:int, level:int):String {
			return $htmlBuild.createTag("a", { href:detectHref(dat, index, level), _class:detectClass(dat, index, level) }, dat.name);
			//return $htmlBuild.createTag("a", { href:detectHref(dat, index, level), _class:detectClass(dat, index, level) }, dat.name + separator);
		}
		
		/**
		 * デフォルトhrefの値を生成するメソッド。
		 * @param	dat	TCDataインスタンス。
		 * @param	index	配列インデックス。
		 * @param	level	タグクラウドレベル。
		 * @return
		 */
		private function $detectHref(dat:TCData, index:int, level:int):String {
			return "event:" + eventName + index;
		}
		
		/**
		 * デフォルトclass名を生成するメソッド。
		 * @param	dat	TCDataインスタンス。
		 * @param	index	配列インデックス。
		 * @param	level	タグクラウドレベル。
		 * @return
		 */
		private function $detectClass(dat:TCData, index:int, level:int):String {
			return className + level;
		}
		
	}

}