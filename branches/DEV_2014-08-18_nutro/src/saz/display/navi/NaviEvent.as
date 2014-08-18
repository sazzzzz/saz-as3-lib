package saz.display.navi
{
	import flash.events.Event;
	
	import saz.model.PathId;
	import saz.util.ObjectUtil;
	
	/**
	 * Navi用イベント。
	 * @author saz
	 * 
	 */
	public class NaviEvent extends Event
	{
		
		public static const NAVI_CLICK:String = "naviClick";
		public static const NAVI_ROLL_OVER:String = "naviRollOver";
		public static const NAVI_ROLL_OUT:String = "naviRollOut";
		

		public function get pathId():PathId
		{
			return _pathId;
		}
		private var _pathId:PathId;

		
		public function NaviEvent(type:String, path:PathId)
		{
			super(type, true, false);
			
			_pathId = path;
		}
		
		
		override public function toString():String
		{
			return ObjectUtil.formatToString(this, "NaviEvent", ["pathId"]);
		}
		
	}
}