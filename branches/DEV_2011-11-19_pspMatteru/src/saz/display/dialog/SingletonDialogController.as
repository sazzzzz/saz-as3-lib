package saz.display.dialog {
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	
	/**
	 * DialogControllerのシングルトンバージョン.
	 * @author saz
	 * 
	 * @example <listing version="3.0" >
	 * SingletonDialogController.getInstance().init(sprite);
	 * //背景用Sprite
	 * SingletonDialogController.getInstance().background = new RectDialogBackground({
	 * 	fillRect:new Rectangle(0,0,stage.stageWidth,stage.stageHeight)
	 * 	,time:1/4
	 * 	,maxAlpha:0.5
	 * });
	 * //アラートダイアログを登録
	 * var alert:CastSprite = new AlertDialog();
	 * alert.addEventListener(DialogEvent.CLOSE,function(e:DialogEvent):void{
	 * 	trace("dia1 CLOSE", e);
	 * });
	 * SingletonDialogController.getInstance().add(alert,"alert");
	 * SingletonDialogController.getInstance().show("alert");
	 * </listing>
	 */
	public class SingletonDialogController extends DialogController {
		
		private static var $instance:SingletonDialogController = null;
		
		public function SingletonDialogController(caller:Function = null) {
			if (SingletonDialogController.getInstance != caller) {
				throw new Error("SingletonDialogControllerクラスはシングルトンクラスです。getInstance()メソッドを使ってインスタンス化してください。");
			}
			if (null != SingletonDialogController.$instance) {
				throw new Error("SingletonDialogControllerインスタンスはひとつしか生成できません。");
			}
			//ここからいろいろ書く
		}
		
		
		
		/**
		 * インスタンスを生成する。
		 * @return
		 */
		public static function getInstance():SingletonDialogController {
			//インスタンスが未作成の場合、インスタンスを作成。
			if (null == $instance) {
				$instance = new SingletonDialogController(arguments.callee);
			}
			return $instance;
		}
		
	}

}