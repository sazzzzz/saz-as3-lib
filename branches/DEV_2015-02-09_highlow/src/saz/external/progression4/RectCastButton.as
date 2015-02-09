package saz.external.progression4 {
	import flash.display.Graphics;
	import flash.events.Event;
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
	 * 四角いボタン.
	 * @author saz
	 */
	public class RectCastButton extends CastButton {
		
		public var drawX:Number = 0.0;
		public var drawY:Number = 0.0;
		public var drawW:Number = 100.0;
		public var drawH:Number = 100.0;
		public var drawColor:uint = 0x000000;
		public var drawAlpha:Number = 1.0;
		
		protected var _isDrawn:Boolean = false;
		
		/**
		 * 新しい RectCastButton インスタンスを作成します。
		 */
		public function RectCastButton( initObject:Object = null ) {
			// 親クラスを初期化します。
			super( initObject );
			
			addEventListener(Event.ADDED_TO_STAGE, _addedToStage);
		}
		
		
		
		//--------------------------------------
		// ASDoc通す用ダミー！！！
		//--------------------------------------
		/*override public function get contextMenu () : ContextMenu {
			return new ContextMenu();
		}
		override public function set contextMenu (value:ContextMenu) : void {
		}*/
		
		
		
		private function _addedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStage);
			_draw();
		}
		
		private function _draw():void {
			if (_isDrawn) return;
			_isDrawn = true;
			var g:Graphics = graphics;
			g.beginFill(drawColor, drawAlpha);
			g.drawRect(drawX, drawY, drawW, drawH);
		}
		
		
	}
}
