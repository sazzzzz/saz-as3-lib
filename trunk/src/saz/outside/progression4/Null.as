package saz.outside.progression4 {
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
	 * なにもしないコマンド
	 * @author saz
	 * @example <listing version="3.0" >
	 * addCommand(
	 * 	new Null()	//こう書くためだけのもの
	 *  ,new AddChild(container, page)
	 *  ,new DoTweener(page, {alpha:1.0, time:1.0})
	 * );
	 * </listing>
	 */
	public class Null extends Command {
		
		/**
		 * 新しい Null インスタンスを作成します。
		 */
		public function Null( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( _execute, _interrupt, initObject );
		}
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _execute():void {
			// 
			executeComplete();
		}
		
		/**
		 * 中断されるコマンドの実装です。
		 */
		private function _interrupt():void {
		}
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new Null( this );
		}
	}
}
