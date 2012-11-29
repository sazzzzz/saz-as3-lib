package {
	
	import com.omniture.AppMeasurement;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * SiteCatalystProxy. というかただのサンプルだな...
	 * @author saz
	 */
	public class SiteCatalystProxy {
		
		public function get isInit():Boolean {
			return _isInit;
		}
		private var _isInit:Boolean = false;
		
		private var _isDebug:Boolean = false;
		
		/**
		 * AppMeasurementインスタンス. 
		 */
		public function get s():AppMeasurement {
			//if (_s == null)_s = _createAppMeasurement();
			return _s;
		}
		private var _s:AppMeasurement;
		
		
		private static var $instance:SiteCatalystProxy = null;
		
		/**
		 * コンストラクタだけどシングルトンなのでgetInstance()を使え. 
		 * @example <listing version="3.0" >
		 * if (!SiteCatalystProxy.getInstance().isInit) SiteCatalystProxy.getInstance().init(stage);
		 * </listing>
		 */
		public function SiteCatalystProxy(caller:Function = null) {
			if (SiteCatalystProxy.getInstance != caller) {
				throw new Error("SiteCatalystProxyクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != SiteCatalystProxy.$instance) {
				throw new Error("SiteCatalystProxyインスタンスはひとつしか生成できません。");
			}
			//ここからいろいろ書く
		}
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():SiteCatalystProxy {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new SiteCatalystProxy(arguments.callee);
			}
			return $instance;
		}
		
		public function init(dsp:DisplayObjectContainer, isDebug:Boolean = false):void {
			if (_isInit) return;
			
			_isInit = true;
			_isDebug = isDebug;
			_s = _createAppMeasurement(dsp);
		}
		
		public  function track(pageName:String):void {
			s.pageName = pageName;
			s.track();
		}
		
			
		private function _createAppMeasurement(dsp:DisplayObjectContainer):AppMeasurement {
			
			var s:AppMeasurement = new AppMeasurement();
			/* Uncomment for Flex and comment out addChild(s); */
			/* rawChildren.addChild(s); */
			//addChild(s);
			dsp.addChild(s);															// MOD

			/* Specify the Report Suite ID(s) to track here */
			s.account = "sonysceijpplaystationcom";
			/* Turn on and configure debugging here */
			//s.debugTracking = true;
			//s.trackLocal = true;
			s.debugTracking = _isDebug;													// MOD
			s.trackLocal = _isDebug;													// MOD
			
			/* You may add or alter any code config here */
			s.pageName = "psp gekiatsu 2011";											// MOD
			s.pageURL = "http://www.jp.playstation.com/psp/gekiatsu2011/index.html";	// MOD
			s.charSet = "UTF-8";
			s.currencyCode = "JPY";
			s.cookieDomainPeriods = 2;

			/* Turn on and configure ClickMap tracking here */
			s.trackClickMap = true;
			s.movieID = "";

			/* WARNING: Changing any of the below variables will cause drastic changes
			to how your visitor data is collected.  Changes should only be made
			when instructed to do so by your account manager.*/
			s.visitorNamespace = "sonyscei";
			s.trackingServer = "sonyscei.112.2o7.net";
			
			return s;
		}
		
		
	}

}