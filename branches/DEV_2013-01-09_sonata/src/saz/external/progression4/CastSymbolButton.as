package saz.external.progression4
{
	import flash.display.*;
	
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
	 * 状態に応じて、各状態用の表示オブジェクトを切り替えるボタン。
	 * @author saz
	 * 
	 */
	public class CastSymbolButton extends CastButton
	{
		
		protected static const STATE_NORMAL:String = "normal";
		protected static const STATE_HOVER:String = "hover";
		protected static const STATE_PRESS:String = "press";
		protected static const STATE_DISABLE:String = "disable";
		
		
		public function get buttonEnabled():Boolean
		{
			return _buttonEnabled;
		}
		public function set buttonEnabled(value:Boolean):void
		{
			_buttonEnabled = value;
			super.mouseEnabled = value;
			setState(value ? STATE_NORMAL : STATE_DISABLE);
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
		
		
		
		public function CastSymbolButton(initObject:Object=null)
		{
			super(initObject);
			
			init();
		}
		
		
		
		
		protected function init():void
		{
			buttonMode = true;
			
			setState(STATE_NORMAL);
		}
		
		
		protected function setState(state:String):void
		{
			if (state == _state) return;
			
			var old:String = _state;
			var res:Boolean = changeSymbol(state);
			if (state == STATE_DISABLE && res == false) alpha = 0.5;
			if (old == STATE_DISABLE) alpha = 1.0;
		}
		
		
		protected function changeSymbol(state:String):Boolean
		{
			var old:String = _state;
			_state = state;
			
			// 古いのを消す
			if (old != STATE_NORMAL)
			{
				var os:DisplayObject = getSymbol(old);
				if (os && os.parent == this) removeChild(os);
			}
			
			// 新しいの表示
			var ns:DisplayObject = getSymbol(state);
			if (ns && ns.parent != this) addChild(ns);
			
			return ns != null;
		}
		
		
		protected function existSymbol(state:String):Boolean
		{
			return getSymbol(state) != null;
		}
		
		
		protected function getSymbol(state:String):DisplayObject
		{
			switch(state)
			{
				case STATE_NORMAL:
					return normal;
				case STATE_HOVER:
					return hover;
				case STATE_PRESS:
					return press;
				case STATE_DISABLE:
					return disable;
			}
			return null;
		}
		
		
		/*protected function atButtonDisable():void
		{
			if (disable) addChild(
			normal.visible = false;
		}
		
		protected function atButtonEnable():void
		{
			normal.visible = true;
		}*/
		
		
		
		/**
		 * IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastAdded():void {
			setState(STATE_NORMAL);
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
			setState(STATE_PRESS);
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastMouseUp():void {
			if (_state != STATE_NORMAL) setState(STATE_HOVER);
		}
		
		/**
		 * ユーザーが CastButton インスタンスにポインティングデバイスを合わせたときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRollOver():void {
			setState(STATE_HOVER);
		}
		
		/**
		 * ユーザーが CastButton インスタンスからポインティングデバイスを離したときに送出されます。
		 * このイベント処理の実行中には、ExecutorObject を使用した非同期処理が行えます。
		 */
		override protected function atCastRollOut():void {
			setState(STATE_NORMAL);
		}
		
	}
}