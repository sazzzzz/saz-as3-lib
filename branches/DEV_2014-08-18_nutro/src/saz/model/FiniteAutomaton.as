package saz.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import saz.events.WatchEvent;
	
	/**
	 * いわゆるステートマシーン。
	 * @author saz
	 * 
	 * @see	http://www.ibm.com/developerworks/jp/web/library/wa-objectorientedjs/
	 */
	public class FiniteAutomaton extends EventDispatcher
	{
		

		public function get state():String
		{
			return _state;
		}
		private var _state:String = "";

		
		public function FiniteAutomaton(current:String = "")
		{
			super();
			
			if (current != "") transition(current);
		}
		
		/**
		 * 状態を遷移させる。
		 * @param name
		 * 
		 */
		public function transition(name:String):void
		{
			if (name == _state) return;
			
			var old:String = _state;
			_state = name;
			dispatchEvent(new WatchEvent(WatchEvent.CHANGE, "state", old, name));
		}
	}
}