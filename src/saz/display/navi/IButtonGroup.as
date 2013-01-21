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
		function get pathId():PathId;
		function set pathId(value:PathId):void;

		function show():void;
		function hide():void;
		function selectAt(index:int):void;
		function selectByName(name:String):void;
	}
}