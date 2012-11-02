package {
	
	/**
	 * ...
	 * @author saz
	 */
	public class Singleton {
		
		/**
		 * AS3ではstaticメンバは継承されないので、Singletonをサブクラス化しても無意味なのだ。
		 * @see	http://fumiononaka.com/TechNotes/Flash/FN0612002.html
		 * @see	http://help.adobe.com/ja_JP/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7fcd.html
		 */
		
		static private var $instance:Singleton = null;
		
		function Singleton(caller:Function = null) {
			if (Singleton.getInstance != caller) {
				throw new Error("Singletonクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != Singleton.$instance) {
				throw new Error("Singletonインスタンスはひとつしか生成できません。");
			}
			
			//ここからいろいろ書く
			
		}
		
		// AS2とAS3でSingletonクラスを作る（http://feb19.jp/blog/archives/000147.php
		// 実は、var wm = new Singleton(Singleton.getInstance); で初期化できちゃうよ
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		static public function getInstance():Singleton {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new Singleton(arguments.callee);
			}
			return $instance;
		}
		
	}
	
}