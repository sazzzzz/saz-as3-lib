package saz.external.progression4 {
	import flash.net.URLRequest;
	import jp.progression.commands.net.LoadScene;
	import jp.progression.scenes.SceneLoader;
	
	/**
	 * 外部swfを読み込んでシーンを連結.
	 * @author saz
	 */
	public class ClassSceneLoader extends SceneLoader {
		
		/**
		 * SWFのURL. 
		 */
		public var url:String = "";
		
		/**
		 * コンストラクタ. 
		 * @param	name	シーン名. 
		 * @param	initObject
		 * 
		 * @example <listing version="3.0" >
		 * var scene1:SceneLoader = new ClassSceneLoader("scene1", {url:"scene1.swf"} );
		 * addScene(scene1);
		 * </listing>
		 */
		public function ClassSceneLoader(name:String = null, initObject:Object = null) {
			super(name, initObject);
		}
		
		/**
		 * シーンが読み込まれるときの処理. 
		 */
		override protected function atScenePreLoad():void {
			addCommand(
				// swfを読み込んで、シーンを連結する
				new LoadScene(new URLRequest(url), this)
			);
		}
		
		override protected function atScenePostUnload():void {
			//読み込んだシーンを破棄;
			unload();
		}
		
	}

}