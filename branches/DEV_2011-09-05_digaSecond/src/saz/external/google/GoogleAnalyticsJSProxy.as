package saz.external.google {
	import flash.external.ExternalInterface;
	/**
	 * GoogleアナリティクスのJS版プロクシクラス. ...だけど、GoogleAnalyticsProxyのブリッジモードを使うべき（爆）. 
	 * Flash コンテンツが埋め込まれている HTML ページ内で allowScriptAccess を always に設定. （←したほうが多分いい. 未検証. ）
	 * @author saz
	 * @see	http://www.google.com/support/googleanalytics/bin/answer.py?hl=ja&answer=55520
	 */
	public class GoogleAnalyticsJSProxy {
		
		public function get isInit():Boolean {
			return _isInit;
		}
		private var _isInit:Boolean = false;
		
		
		private static var $instance:GoogleAnalyticsJSProxy = null;
		
		/**
		 * コンストラクタ. シングルトンなので直接呼び出さない. 
		 * @param	caller
		 * @example <listing version="3.0" >
		 * if (!GoogleAnalyticsJSProxy.isInit) GoogleAnalyticsJSProxy.getInstance().init();
		 * GoogleAnalyticsJSProxy.getInstance().trackPageview("/purchase_funnel/page1.html");
		 * </listing>
		 */
		public function GoogleAnalyticsJSProxy(caller:Function = null) {
			if (GoogleAnalyticsJSProxy.getInstance != caller) {
				throw new Error("GoogleAnalyticsJSProxyクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != GoogleAnalyticsJSProxy.$instance) {
				throw new Error("GoogleAnalyticsJSProxyインスタンスはひとつしか生成できません。");
			}
			//ここからいろいろ書く
		}
		
		/**
		 * 初期化. ホントは何もしてない. 
		 * @return	JSが使えるかどうかを返す. ムービープレビュー用に、エラーは発生しないので注意. 
		 */
		public function init():Boolean {
			if (_isInit) return;
			_isInit = true;
			
			return ExternalInterface.available;
		}
		
		/**
		 * トラッキング. 
		 * @param	pageName	仮想URL. 
		 */
		public  function trackPageview(pageName:String):void {
			if (!ExternalInterface.available) {
				trace("* GoogleAnalyticsJSProxy.trackPageview(", pageName);
				return;
			}
			
			// http://www.google.com/support/googleanalytics/bin/answer.py?hl=ja&answer=55520
			ExternalInterface.call("pageTracker._trackPageview", pageName);
			
			//ExternalInterface
			//メモ : HTML ページに内に SWF ファイルを埋め込むときには、
			//object タグおよび embed タグの id 属性および name 属性に次の文字が含まれないようにしてください。
			//. - + * / \
			//livedocs.adobe.com/flash/9.0_jp/ActionScriptLangRefV3/flash/external/ExternalInterface.html
		}
		
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():GoogleAnalyticsJSProxy {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new GoogleAnalyticsJSProxy(arguments.callee);
			}
			return $instance;
		}
	}

}