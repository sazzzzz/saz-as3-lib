package saz.collections {
	
	/**
	 * ...
	 * @author saz
	 */
	public interface IObject  {
		
		function hasOwnProperty(name:String):Boolean;
		function isPrototypeOf(theClass:Object):Boolean;
		function propertyIsEnumerable(name:String):Boolean;
		function setPropertyIsEnumerable(name:String, isEnum:Boolean = true):void;
		function toString():String;
		function valueOf():Object;
		
	}
	
}