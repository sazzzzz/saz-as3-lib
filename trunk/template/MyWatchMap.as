package  {
	import saz.collections.WatchMap;
	
	/**
	 * メインデータ
	 * @author saz
	 */
	public class MyWatchMap extends WatchMap {
		
		/**
		 * プロパティサンプル
		 */
		public static const KEY:String = "key";
		
		
		private static var $instance:MyWatchMap = null;
		
		function MyWatchMap(caller:Function = null) {
			if (MyWatchMap.getInstance != caller) {
				throw new Error("MyWatchMapクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != MyWatchMap.$instance) {
				throw new Error("MyWatchMapインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
			initParams();
		}
		
		
		
		/**
		 * データ初期化。
		 */
		public function initParams():void {
			super.put(KEY, null);
		}
		
		/**
		 * シングルトン。
		 * @return
		 */
		public static function getInstance():MyWatchMap {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new MyWatchMap(arguments.callee);
			}
			return $instance;
		}
		
	}
	
}