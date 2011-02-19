package saz.display.dialog {
	import flash.display.Graphics;
	import flash.geom.Rectangle;
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
	 * DialogController用ベタ背景
	 * @author saz
	 */
	public class SimpleDialogBackground extends CastSprite {
		
		public var fillRect:Rectangle;
		public var time:Number = 1 / 4;
		public var maxAlpha:Number = 0.5;
		
		/**
		 * 新しい SimpleDialogBackground インスタンスを作成します。
		 */
		public function SimpleDialogBackground( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			if (!fillRect) fillRect = new Rectangle(0, 0, 100, 100);
			
			alpha = 0.0;
			cacheAsBitmap = true;
		}
		
		protected function $draw():void {
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0);
			g.drawRect(fillRect.x, fillRect.y, fillRect.width, fillRect.height);
		}
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			$draw();
			addCommand(
				new DoTweener(this, { time:time, alpha:maxAlpha, transition:"linear" } )
			);
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRemoved():void {
			addCommand(
				new DoTweener(this, { time:time, alpha:0.0, transition:"linear" } )
				,new Func(function():void {
					graphics.clear();
				})
			);
		}
	}
}
