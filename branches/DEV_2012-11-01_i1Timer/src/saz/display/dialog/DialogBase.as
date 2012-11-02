package saz.display.dialog {
	import jp.progression.casts.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.commands.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	import flash.ui.ContextMenu;
	
	/**
	 * ...
	 * @author saz
	 */
	public class DialogBase extends CastSprite {
		
		/**
		 * 新しい DialogBase インスタンスを作成します。
		 */
		public function DialogBase( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
		}
		
		
		//--------------------------------------
		// ASDoc通す用ダミー！！！
		//--------------------------------------
		/*override public function get contextMenu () : ContextMenu {
			return new ContextMenu();
		}
		override public function set contextMenu (value:ContextMenu) : void {
		}*/
		
		
		final protected function $initButton(btn:CastButton, result:String):void {
			btn.addEventListener(CastMouseEvent.CAST_MOUSE_UP, function(e:CastMouseEvent):void {
				close(result);
				
				//クロージャを使ってaddEventListenerしたイベントをremoveEventListenerする。
				//http://level0.kayac.com/2009/09/event_closure.php
				//okButton.removeEventListener(CastMouseEvent.CAST_MOUSE_UP, arguments.callee);
			});
		}
		
		/**
		 * ダイアログを閉じる。
		 * @param	result
		 */
		public function close(result:String):void {
			// 表示を消したいときは、DialogEvent.CLOSEイベントを発行する。
			dispatchEvent(new DialogEvent(DialogEvent.CLOSE, result));
		}
		
		
	}
}
