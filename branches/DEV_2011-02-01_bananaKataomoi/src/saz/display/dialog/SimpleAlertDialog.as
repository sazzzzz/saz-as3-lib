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
	
	/**
	 * ダイアログサンプル. OKボタンを持つ. 
	 * @author saz
	 */
	public class SimpleAlertDialog extends DialogBase {
		
		public var okButton:CastButton;
		
		/**
		 * 新しい SimpleAlertDialog インスタンスを作成します。
		 */
		public function SimpleAlertDialog( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			// 初期化。
			alpha = 0;
			// ボタンを初期化。
			$initButton(okButton, DialogResult.OK);
		}
		
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			// 表示する時の処理を記述します。
			addCommand(
				new DoTweener(this, { time:1.0, alpha:1.0, transition:"linear" } )
			);
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRemoved():void {
			// 消す時の処理を記述します。
			//var scope:SimpleAlertDialog = this;
			addCommand(
				new DoTweener(this, { time:1.0, alpha:0.0, transition:"linear" } )
			);
		}
	}
}
