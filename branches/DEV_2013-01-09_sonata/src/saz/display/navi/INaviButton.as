package saz.display.navi
{
	import saz.model.PathId;

	public interface INaviButton
	{
		function get pathId():PathId;
		function set pathId(value:PathId):void;
		
		function select():void;
		function unselect():void;
	}
}