package saz {
	
	/**
	 * ...
	 * @author saz
	 */
	public interface ICore {
		function equals(item:*):Boolean;
		function clone():*;
		function destroy():void;
		function toString():String;
	}
	
}