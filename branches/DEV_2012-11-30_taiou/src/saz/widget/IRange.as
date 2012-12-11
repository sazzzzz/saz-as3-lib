package saz.widget
{
	public interface IRange
	{
		
		function get value():Number;
		function set value(value:Number):void;
		
		function get minimum():Number;
		function set minimum(value:Number):void;
		
		function get maximum():Number;
		function set maximum(value:Number):void;
	}
}