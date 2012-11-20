package saz.external.progression4 {
	import flash.net.URLRequest;
	
	import jp.progression.casts.*;
	import jp.progression.commands.*;
	import jp.progression.commands.display.*;
	import jp.progression.commands.lists.*;
	import jp.progression.commands.managers.*;
	import jp.progression.commands.media.*;
	import jp.progression.commands.net.*;
	import jp.progression.commands.tweens.*;
	import jp.progression.data.*;
	import jp.progression.events.*;
	import jp.progression.scenes.*;
	
	/**
	 * サウンドをロード＆再生するコマンド. <br/>
	 * 必要ならロードしてロード完了を待ってから、サウンドを再生. getResourceByIdで見つかればロードせずに再生. 
	 * @author saz
	 */
	public class LoadPlaySound extends SerialList {
		
		public var url:String = "";
		
		/**
		 * 新しい LoadPlaySound インスタンスを作成します。
		 */
		public function LoadPlaySound( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			// 実行したいコマンド群を登録します。
			addCommand(
				function():void {
					if (null == getResourceById(url)) {
						this.parent.insertCommand(new LoadSound(new URLRequest(url)));
					}
				},
				function():void {
					getResourceById(url).toSound().play();
				}
			);
		}
		
		/**
		 * インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。
		 */
		override public function clone():Command {
			return new LoadPlaySound( this );
		}
	}
}
