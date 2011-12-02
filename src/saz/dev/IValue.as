package saz.dev {
	import flash.events.IEventDispatcher;
	
	/**
	 * ValueHolder用インターフェース.
	 * @author saz
	 */
	public interface IValue extends IEventDispatcher {
		
		function get name():String;
		/**
		 * @copy	ValueHolder#get value
		 */
		function get value():*;
		/**
		 * @copy	ValueHolder#set value
		 */
		function set value(val:*):void;
	}
	
}