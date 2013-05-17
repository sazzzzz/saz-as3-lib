package saz.display
{
	import flash.display.*;
	
	import jp.progression.commands.Func;

	public class SymbolButtonController extends SymbolButtonControllerBase
	{
		
		
		/**
		 * 対象とするボタン。
		 */
		public var target:DisplayObjectContainer;
		

		public var onEnterState:Function;
		public var onLeaveState:Function;
		
		
		
		public function SymbolButtonController(button:DisplayObjectContainer)
		{
			super();
			
			target = button;
			init();
		}
		
		
		protected function init():void
		{
			onEnterState ||= function(state:String, display:DisplayObject):void
			{
				if (display && display.parent != target) target.addChild(display);
			};
			onLeaveState ||= function(state:String, display:DisplayObject):void
			{
				if (display && display.parent == target) target.removeChild(display);
			};
		}
		
		
		override protected function atEnterState(state:String, display:DisplayObject):void
		{
			onEnterState(state, display);
		}
		
		override protected function atLeaveState(state:String, display:DisplayObject):void
		{
			onLeaveState(state, display);
		}
		
		
	}
}