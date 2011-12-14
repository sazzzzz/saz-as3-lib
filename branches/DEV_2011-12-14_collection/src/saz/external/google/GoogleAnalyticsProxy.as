package saz.external.google {
	import flash.display.*;
	import com.google.analytics.*;
	import flash.external.ExternalInterface;
	
	/**
	 * GoogleアナリティクスのAS3版プロクシクラス.
	 * Google Analytics コンポーネントが必要. 
	 * @author saz
	 * @see	http://code.google.com/intl/ja/apis/analytics/docs/tracking/flashTrackingIntro.html
	 * @see	http://code.google.com/intl/ja/apis/analytics/docs/tracking/flashTrackingSetupFlash.html
	 */
	public class GoogleAnalyticsProxy {
		
		/**
		 * AS3モード指定用定数. 
		 */
		public static const MODE_AS3:String = "AS3";
		/**
		 * ブリッジモード指定用定数. 
		 */
		public static const MODE_BRIDGE:String = "Bridge";
		
		
		public static function get isInit():Boolean {
			return _isInit;
		}
		private static var _isInit:Boolean = false;
		
		private var _tracker:GATracker;
		//private var _isDebug:Boolean = false;
		
		
		private static var $instance:GoogleAnalyticsProxy = null;
		
		/**
		 * コンストラクタ. シングルトンなので直接呼び出さない. 
		 * @param	caller
		 * @example <listing version="3.0" >
		 * // AS3モード
		 * if (!GoogleAnalyticsProxy.isInit) GoogleAnalyticsProxy.getInstance().init( this, "UA-12345-22", GoogleAnalyticsProxy.MODE_AS3, false );
		 * GoogleAnalyticsProxy.getInstance().trackPageview("/purchase_funnel/page1.html");
		 * </listing>
		 */
		public function GoogleAnalyticsProxy(caller:Function = null) {
			if (GoogleAnalyticsProxy.getInstance != caller) {
				throw new Error("GoogleAnalyticsProxyクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != GoogleAnalyticsProxy.$instance) {
				throw new Error("GoogleAnalyticsProxyインスタンスはひとつしか生成できません。");
			}
			//ここからいろいろ書く
		}
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():GoogleAnalyticsProxy {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new GoogleAnalyticsProxy(arguments.callee);
			}
			return $instance;
		}
		
		/**
		 * 初期化. 
		 * @param	dsp	なんかDisplayObjectへの参照が必要らしい. 
		 * @param	webPropertyId	ウェブプロパティID（ex.UA-12345-22） または、ブリッジモードでは "window.pageTracker". 
		 * @param	mode	トラッキングモードの指定. AS3モードとブリッジモードがある. "AS3"または"Bridge". 
		 * @param	isDebug	デバッグモード.
		 * @return	初期化できたらtrueを返す. 
		 * 
		 * @example <listing version="3.0" >
		 * // AS3モード
		 * GoogleAnalyticsProxy.getInstance().init( this, "UA-12345-22", GoogleAnalyticsProxy.MODE_AS3, false );
		 * </listing>
		 * @example <listing version="3.0" >
		 * // ブリッジモード 一般的な方法
		 * // Google Analytics トラッキング コード オブジェクトが、pageTracker などの独自の名前でページ上に存在する場合。
		 * GoogleAnalyticsProxy.getInstance().init( this, "window.pageTracker", GoogleAnalyticsProxy.MODE_BRIDGE, false );
		 * </listing>
		 * @example <listing version="3.0" >
		 * // ブリッジモード 別の方法
		 * // ページ上にページ トラッキング オブジェクトをまだ作成していない場合
		 * GoogleAnalyticsProxy.getInstance().init( this, "UA-12345-22", "Bridge", false );
		 * </listing>
		 * トラッキングモードについては、「Adobe Flash 向け Google Analytics トラッキング - Google アナリティクス - Google Code」参照
		 * @see	http://code.google.com/intl/ja/apis/analytics/docs/tracking/flashTrackingIntro.html
		 */
		public function init(dsp:DisplayObject, webPropertyId:String, mode:String = "AS3", isDebug:Boolean = false):Boolean {
			if (_isInit) return false;
			if (mode == MODE_BRIDGE && !ExternalInterface.available) return false;
			
			_isInit = true;
			//_isDebug = isDebug;
			try{
				_tracker = new GATracker(dsp, webPropertyId, mode, isDebug);
			}catch (e:Error) {
				trace(e);
			}
			return true;
		}
		
		/**
		 * トラッキング. 
		 * @param	pageName	仮想URL. 
		 */
		public  function trackPageview(pageName:String):void {
			if (_tracker == null) return;
			_tracker.trackPageview(pageName);
		}
		
			
		
		
	}

}