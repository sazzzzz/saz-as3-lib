package saz.display.navi
{
	import saz.model.PathId;
	
	/**
	 * Navi用ボタングループインタフェース。
	 * @author saz
	 * 
	 */
	public interface IButtonGroup
	{
		function get path():String;
		function set path(value:String):void;
		function get pathId():PathId;
//		function set pathId(value:PathId):void;

		function show(callback:Function = null):void;
		function hide(callback:Function = null):void;
		function selectAt(index:int):void;
//		function selectByName(name:String):void;
		function selectByPath(path:String):void;
	}
}