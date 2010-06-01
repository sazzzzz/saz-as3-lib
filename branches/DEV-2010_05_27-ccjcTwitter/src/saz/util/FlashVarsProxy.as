package saz.util {
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author saz
	 */
	public class FlashVarsProxy {
		
		private const $ERR_NOTINIT:String = "初期化されていません。";
		
		public static var isReady:Boolean;
		
		private static var $instance:FlashVarsProxy = null;
		private var $tl:MovieClip;
		
		private var $defParams:Object;
		
		
		/**
		 * 
		 * @param	caller
		 * @example <listing version="3.0" >
		 * if (!FlashVarsProxy.isReady) {
		 * 	FlashVarsProxy.getInstance().init(this);
		 * 	FlashVarsProxy.getInstance().addDefaultParam("configUrl", "./config.xml");
		 * }
		 * </listing>
		 */
		function FlashVarsProxy(caller:Function = null) {
			if (FlashVarsProxy.getInstance != caller) {
				throw new Error("FlashVarsProxyクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != FlashVarsProxy.$instance) {
				throw new Error("FlashVarsProxyインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
			isReady = false;
			if (null == $defParams)$defParams = new Object();
		}
		
		/**
		 * 初期化。
		 * @param	mainTimeline	FlashVarsを持っている、メインタイムラインまたはドキュメントクラス。
		 */
		public function init(mainTimeline:MovieClip):void {
			if (isReady) return;
			$tl = mainTimeline;
			isReady = true;
		}
		
		/**
		 * （主にムービープレビュー用の）デフォルトパラメータをまとめて指定。
		 * @param	obj
		 */
		public function setDefaultParams(obj:Object):void {
			$defParams = obj;
		}
		
		/**
		 * （主にムービープレビュー用の）デフォルトパラメータを追加。
		 * @param	key
		 * @param	value
		 */
		public function addDefaultParam(key:String, value:String):void {
			$defParams[key] = value;
		}
		
		/**
		 * FlashVarsを取得する。
		 * @param	key
		 * @return
		 */
		public function gets(key:String):String {
			if (!isReady) throw new Error($ERR_NOTINIT);
			
			//よく考えたらStringしかない。
			var res:String = $tl.loaderInfo.parameters[key];
			if (null != res) {
				return res;
			}else {
				return $defParams[key];
			}
		}
		
		
		/**
		 * @see	http://feb19.jp/blog/archives/000147.php
		 * @return
		 */
		public static function getInstance():FlashVarsProxy {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new FlashVarsProxy(arguments.callee);
			}
			return $instance;
		}
		
	}
	
}