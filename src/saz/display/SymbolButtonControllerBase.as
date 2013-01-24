package saz.display
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import saz.display.ButtonStateMachine;
	import saz.events.WatchEvent;
	import saz.util.ObjectUtil;
	
	/**
	 * SymbolButtonコントローラ。
	 * @author saz
	 * 
	 */
	public class SymbolButtonControllerBase extends EventDispatcher
	{
		
		/**
		 * setStateが有効かどうか。
		 */
		public var setEnabled:Boolean = true;
		
		protected var _state:String = "";
		protected var _default:Object;
		protected var entries:Object = {};
		
		public function SymbolButtonControllerBase()
		{
			super();
		}
		
		
		/**
		 * 状態が登録ずみかどうか。
		 * @param state	状態。
		 * @return 
		 * 
		 */
		public function containState(state:String):Boolean
		{
			return entries[state] != null;
		}
		
		/**
		 * 現在の状態を返す。
		 * @return 
		 * 
		 */
		public function getState():String
		{
			return _state;
		}
		
		/**
		 * 現在の状態を変更する（状態を設定する）。
		 * @param state	状態。
		 * 
		 */
		public function setState(state:String):void
		{
			if (setEnabled == false || _state == state) return;
			
			var oe:Object = entries[_state];
			var ns:String = state;
			var ne:Object = entries[state];
			// 登録されてなければデフォルトとして扱う。
			if (ne == null)
			{
				ns = _default.state;
				ne = _default;
			}
			
			if (oe != null) atLeaveState(oe.state, oe.display);
			_state = ns;
			atEnterState(ne.state, ne.display);
		}
		
		/**
		 * 状態を登録する。stateが登録済みの場合は、上書きされる。最初に登録されたものがデフォルトとして扱われる。
		 * @param state	状態。
		 * @param display	対応するDisplayObject。
		 * @return stateが登録されてなければtrue、登録済みで上書きしたらfalse。
		 * 
		 */
		public function registState(state:String, display:DisplayObject):Boolean
		{
			var ret:Boolean = !containState(state);
			var entry:Object = {
				state:state,
				display:display
			};
			entries[state] = entry;
			
			// はじめてならデフォルトとして登録。
			if (_default == null) _default = entry;
			return ret;
		}
		
		
		
		
		
		
		/**
		 * イベントと状態を結びつける。
		 * @param dispatcher	イベント発生源オブジェクト。
		 * @param eventType	イベントの種類。
		 * @param state	状態。
		 * 
		 */
		public function attachEvent(dispatcher:IEventDispatcher, eventType:String, state:String):void
		{
			if (containState(state) == false) return;
			
			var entry:Object = entries[state];
			var self:SymbolButtonControllerBase = this;
			var handler:Function = function(event:Event):void
			{
				self.setState(state);
			};
			dispatcher.addEventListener(eventType, handler);
			entry[detectHandlerName(dispatcher, eventType)] = handler;
		}
		
		/**
		 * attachEventを解除。
		 * @param dispatcher	イベント発生源オブジェクト。
		 * @param eventType	イベントの種類。
		 * @param state	状態。
		 * 
		 */
		public function detachEvent(dispatcher:IEventDispatcher, eventType:String, state:String):void
		{
			var entry:Object = entries[state];
			var hname:String = detectHandlerName(dispatcher, eventType);
			if (entry == null || entry[hname] == null) return;
			
			dispatcher.removeEventListener(eventType, entry[hname]);
			entry[hname] = null;
		}
		
		
		// イベントハンドラ名を決める…こんな実装で大丈夫か？
		protected function detectHandlerName(dispatcher:IEventDispatcher, eventType:String):String
		{
			var dis:String = "";
			if (dispatcher["name"] != null)
			{
				dis += dispatcher["name"];
			} else if (dispatcher["toString"] is Function)
			{
				dis += dispatcher["toString"]();
			} else {
				dis += "object";
			}
			
			return dis + "_" + eventType;
		}
		
		
		
		//--------------------------------------
		// for subclass
		//--------------------------------------
		
		
		protected function atEnterState(state:String, display:DisplayObject):void {}
		protected function atLeaveState(state:String, display:DisplayObject):void {}
		
		
	}
}