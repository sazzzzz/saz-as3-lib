package saz.display.pixel {
	import saz.controll.Pool;
	/**
	 * PixelSpriteプール.
	 * @author saz
	 */
	public class PixelSpritePool extends Pool{
		
		static private var $instance:PixelSpritePool = null;
		
		function PixelSpritePool(caller:Function = null) {
			if (PixelSpritePool.getInstance != caller) {
				throw new Error("PixelSpritePoolクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != PixelSpritePool.$instance) {
				throw new Error("PixelSpritePoolインスタンスはひとつしか生成できません。");
			}
		}
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		static public function getInstance():PixelSpritePool {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new PixelSpritePool(arguments.callee);
			}
			return $instance;
		}
		
		
		
		override protected function $initHook(createFnc:Function = null):void {
			atCreate = $atChatCreate;
		}
		
		//override protected function $atCreate(...args):Chat {		//1023: オーバーライドに対応していません。	⇒型が一致してないとダメ.
		private function $atChatCreate(...args):PixelSprite {
			return new PixelSprite(args[0], args[1]);
		}
		
	}

}