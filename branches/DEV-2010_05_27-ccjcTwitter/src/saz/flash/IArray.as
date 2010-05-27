package saz.flash {
	
	/**
	 * Arrayのインターフェース定義
	 * @author saz
	 */
	public interface IArray  {
		function concat(... args:Array):IArray;
		function every(callback:Function, thisObject:*= null):Boolean;
		function filter(callback:Function, thisObject:*= null):IArray;
		function forEach(callback:Function, thisObject:*= null):void;
		function indexOf(searchElement:*, fromIndex:int = 0):int;
		function join(sep:*):String;
		function lastIndexOf(searchElement:*, fromIndex:int = 0x7fffffff):int;
		function map(callback:Function, thisObject:* = null):IArray;
		function pop():*;
		function push(... args):uint;
		function reverse():IArray;
		function shift():*;
		function slice(startIndex:int = 0, endIndex:int = 16777215):IArray;
		function some(callback:Function, thisObject:* = null):Boolean;
		function sort(... args):IArray;
		function sortOn(fieldName:Object, options:Object = null):IArray;
		function splice(startIndex:int, deleteCount:uint, ... values):IArray;
		function toLocaleString():String;
		function toString():String;
		function unshift(... args):uint;
	}
	
}