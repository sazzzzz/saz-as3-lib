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
		static public const KEY:String = "key";
		
		
		static private var $instance:MyWatchMap = null;
		
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
		 * データ初期化. シングルトンだと、インスタンスが残る場合がある. 外部からこれを呼び出したほうが確実. 
		 */
		public function initParams():void {
			super.put(KEY, null);
			//super.remove(KEY, null);
		}
		
		/**
		 * シングルトン。
		 * @return
		 */
		static public function getInstance():MyWatchMap {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new MyWatchMap(arguments.callee);
			}
			return $instance;
		}
		
	}
	
}