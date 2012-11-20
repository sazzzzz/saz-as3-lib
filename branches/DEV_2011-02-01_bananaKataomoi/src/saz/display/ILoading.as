package saz.display {
	
	/**
	 * ...
	 * @author saz
	 */
	public interface ILoading {
		
		//function setBytes(bytesLoaded:uint, bytesTotal:uint):void;
		
		function get bytesLoaded():uint;
		function set bytesLoaded(bytes:uint):void;
		
		function get bytesTotal():uint;
		function set bytesTotal(bytes:uint):void;
		
	}
	
}