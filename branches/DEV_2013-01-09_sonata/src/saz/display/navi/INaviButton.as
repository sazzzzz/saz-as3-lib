package saz.display.navi
{
	import flash.events.IEventDispatcher;
	
	import saz.model.PathId;

	/**
	 * Navi用ボタンインタフェース。
	 * @author saz
	 * 
	 */
	public interface INaviButton extends IEventDispatcher
	{
		function get pathId():PathId;
		function set pathId(value:PathId):void;
		function get selected():Boolean;
		
		function select():void;
		function unselect():void;
	}
}