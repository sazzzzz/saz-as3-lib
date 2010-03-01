package saz.util {
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author saz
	 */
	public class FlashVarsProxy {
		
		
		private static var $instance:FlashVarsProxy = null;
		private var $tl:MovieClip;
		
		function FlashVarsProxy(caller:Function = null) {
			if (FlashVarsProxy.getInstance != caller) {
				throw new Error("FlashVarsProxyクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != FlashVarsProxy.$instance) {
				throw new Error("FlashVarsProxyインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
		}
		
		public function init(tl:MovieClip):void {
			$tl = tl;
		}
		
		public function gets(key:String):* {
			return $tl.loaderInfo.parameters[key];
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