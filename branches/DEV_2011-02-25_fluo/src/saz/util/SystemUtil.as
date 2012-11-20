package saz.util {
	import flash.system.Capabilities;
	
	/**
	 * システム系ユーティリティークラス。暫定。
	 * @author saz
	 */
	public class SystemUtil {
		
		/**
		 * ブラウザで実行中かどうか。
		 * @return	ブラウザで実行中ならtrue。
		 */
		static public function isBrowser():Boolean {
			return ( Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn" );
		}
		
	}
	
}