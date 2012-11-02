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
	 * DialogController用ベタ背景. サイズ固定タイプ. 
	 * 要Progression4. 
	 * @author saz
	 */
	public class RectDialogBackground extends DialogBackgroundBase {
		
		/**
		 * 描画範囲. 指定しない場合は、最初にAddChildしたときのステージサイズ. 
		 */
		public var fillRect:Rectangle;
		
		/**
		 * 新しい RectDialogBackground インスタンスを作成します。
		 */
		public function RectDialogBackground( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
		}
		
		
		//--------------------------------------
		// オーバーライド
		//--------------------------------------
		
		override protected function init():void {
			if (!fillRect) fillRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		override protected function draw():void {
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0);
			g.drawRect(fillRect.x, fillRect.y, fillRect.width, fillRect.height);
		}
		
		override protected function clear():void {
			graphics.clear();
		}
		
	}
}
