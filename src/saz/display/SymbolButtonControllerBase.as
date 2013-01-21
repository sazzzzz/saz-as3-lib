package saz.display
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
		
		
		protected var _state:String = "";
		protected var _default:Object;
		protected var entries:Object = {};
		
		public function SymbolButtonControllerBase()
		{
			super();
		}
		
		
		/**
		 * 状態が登録ずみかどうか。
		 * @param state
		 * @return 
		 * 
		 */
		public function containState(state:String):Boolean
		{
			return entries[state] != null;
		}
		
		/**
		 * 状態を返す。
		 * @return 
		 * 
		 */
		public function getState():String
		{
			return _state;
		}
		
		/**
		 * 状態を設定。
		 * @param state
		 * 
		 */
		public function setState(state:String):void
		{
			if (_state == state) return;
			
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
		 * @param state
		 * @param display
		 * 
		 */
		public function registState(state:String, display:DisplayObject):void
		{
			entries[state] = {
				state:state,
				display:display
			};
			if (_default == null) _default = entries[state];
		}
		
		
		//--------------------------------------
		// for subclass
		//--------------------------------------
		
		
		protected function atEnterState(state:String, display:DisplayObject):void {}
		protected function atLeaveState(state:String, display:DisplayObject):void {}
		
		
	}
}