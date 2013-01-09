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
	 * イベントリスナで実装してるので、サブクラスではat...メソッドが自由に使える。
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
		
		
		public function destroy():void
		{
			_sm.removeEventListener(WatchEvent.CHANGE, _sm_change);
			
			removeEventListener(CastEvent.CAST_ADDED, _castAdded);
			removeEventListener(CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown);
			removeEventListener(CastMouseEvent.CAST_MOUSE_UP, _castMouseUp);
			removeEventListener(CastMouseEvent.CAST_ROLL_OVER, _castRollOver);
			removeEventListener(CastMouseEvent.CAST_ROLL_OUT, _castRollOut);
		}
		
		
		protected function init():void
		{
			buttonMode = true;
			
			_sm = new ButtonStateMachine();
			_sm.addEventListener(WatchEvent.CHANGE, _sm_change);
			
			addEventListener(CastEvent.CAST_ADDED, _castAdded);
			addEventListener(CastMouseEvent.CAST_MOUSE_DOWN, _castMouseDown);
			addEventListener(CastMouseEvent.CAST_MOUSE_UP, _castMouseUp);
			addEventListener(CastMouseEvent.CAST_ROLL_OVER, _castRollOver);
			addEventListener(CastMouseEvent.CAST_ROLL_OUT, _castRollOut);
			
			changeSymbol(normal);
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
		
		//--------------------------------------
		// listeners
		//--------------------------------------
		
		protected function _sm_change(event:WatchEvent):void
		{
			changeSymbol(getSymbol(event.newValue));
		}		
		
		
		protected function _castAdded(event:CastEvent):void
		{
			_sm.pressing = false;
			_sm.hovering = false;
		}
		
		protected function _castMouseDown(event:CastMouseEvent):void
		{
			_sm.pressing = true;
		}
		
		protected function _castMouseUp(event:CastMouseEvent):void
		{
			_sm.pressing = false;
		}
		
		protected function _castRollOver(event:CastMouseEvent):void
		{
			_sm.hovering = true;
		}
		
		protected function _castRollOut(event:CastMouseEvent):void
		{
			_sm.hovering = false;
		}
		
		
		
	}
}