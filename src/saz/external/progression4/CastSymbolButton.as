package saz.external.progression4
{
	import flash.display.*;
	import flash.events.Event;
	
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
	
	import saz.display.ButtonStateMachine;
	import saz.events.WatchEvent;
	

	/**
	 * 状態に応じて、各状態用の表示オブジェクトを切り替えるボタン。
	 * @author saz
	 * 
	 */
	public class CastSymbolButton extends CastButton
	{
		
		
		public function get buttonEnabled():Boolean
		{
			return _buttonEnabled;
		}
		public function set buttonEnabled(value:Boolean):void
		{
			_buttonEnabled = value;
			super.mouseEnabled = value;
			
			if (disable)
			{
				changeSymbol(value ? normal : disable);
				alpha = 1.0;
			}else{
				alpha = value ? 1.0 : 0.5;
			}
		}
		private var _buttonEnabled:Boolean = true;

		
		/**
		 * 通常時シンボル。
		 */
		public var normal:DisplayObject;
		/**
		 * ホバー時シンボル。
		 */
		public var hover:DisplayObject;
		/**
		 * プレス時シンボル。
		 */
		public var press:DisplayObject;
		
		/**
		 * buttonEnabled=false時シンボル。
		 */
		public var disable:DisplayObject;
		
		
		protected var _state:String = "";
		
		protected var _symbol:DisplayObject;
		protected var _sm:ButtonStateMachine;
		
		
		public function CastSymbolButton(initObject:Object=null)
		{
			super(initObject);
			
			init();
		}
		
		
		
		
		protected function init():void
		{
			buttonMode = true;
			
			_sm = new ButtonStateMachine();
			_sm.addEventListener(WatchEvent.CHANGE, _sm_change);
			
			changeSymbol(normal);
		}
		
		protected function _sm_change(event:WatchEvent):void
		{
			changeSymbol(getSymbol(event.newValue));
		}		
		
		
		
		protected function changeSymbol(disp:DisplayObject):void
		{
			if (disp == null) return;
			
			var old:DisplayObject = _symbol;
			_symbol = disp;
			
			if (old && old.parent == this) removeChild(old);
			if (disp && disp.parent != this) addChild(disp);
		}
		
		
		protected function existSymbol(state:String):Boolean
		{
			return getSymbol(state) != null;
		}
		
		
		protected function getSymbol(state:String):DisplayObject
		{
			switch(state)
			{
				case ButtonStateMachine.STATE_NORMAL:
					return normal;
				case ButtonStateMachine.STATE_HOVER:
					return hover;
				case ButtonStateMachine.STATE_PRESS:
					return press;
			}
			return null;
		}
		
		
		
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			_sm.pressing = false;
			_sm.hovering = false;
		}
		
		/**
		 * IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRemoved():void {
		}
		
		/**
		 * Flash Player ウィンドウの CastButton インスタンスの上でユーザーがポインティングデバイスのボタンを押すと送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastMouseDown():void {
			_sm.pressing = true;
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastMouseUp():void {
			_sm.pressing = false;
		}
		
		/**
		 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRollOver():void {
			_sm.hovering = true;
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRollOut():void {
			_sm.hovering = false;
		}
		
	}
}