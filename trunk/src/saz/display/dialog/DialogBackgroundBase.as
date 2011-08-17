package saz.display.dialog {
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
	 * DialogController用背景ベースクラス.
	 * 要Progression4. 
	 * @author saz
	 */
	public class DialogBackgroundBase extends CastSprite {
		
		/**
		 * フェードin/outする時間. 
		 */
		public var time:Number = 1 / 4;
		/**
		 * 表示時のアルファ値. 
		 */
		public var maxAlpha:Number = 0.5;
		/**
		 * フェードin/outする時のイージング.
		 */
		public var transition:String = "linear";
		
		private var $inited:Boolean = false;
		
		/**
		 * 新しい DialogBackgroundBase インスタンスを作成します。
		 */
		public function DialogBackgroundBase( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
		}
		
		private function $init():void {
			$inited = true;
			
			alpha = 0.0;
			cacheAsBitmap = true;
			
			init();
		}
		
		//--------------------------------------
		// オーバーライド用
		//--------------------------------------
		
		protected function init():void { }
		protected function draw():void { }
		protected function clear():void { }
		protected function castAddedHook():void { }
		protected function castRemovedHook():void { }
		
		
		
		
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			if (!$inited)$init();
			
			castAddedHook();
			addCommand(
				new Func(function():void {
					draw();
				})
				,new DoTweener(this, { time:time, alpha:maxAlpha, transition:transition } )
			);
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRemoved():void {
			castRemovedHook();
			addCommand(
				new DoTweener(this, { time:time, alpha:0.0, transition:transition } )
				,new Func(function():void {
					clear();
				})
			);
		}
	}
}
