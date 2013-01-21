package saz.display.navi
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import saz.model.PathId;

	/**
	 * Navi用ユーティリティ
	 * @author saz
	 * 
	 */
	public class NaviUtil
	{
		
		// initButton用リスナ格納オブジェクト
		protected static function get buttons():Dictionary
		{
			if (_buttons == null) _buttons = new Dictionary();
			return _buttons;
		}
		private static var _buttons:Dictionary;

		
		/**
		 * 指定されたbuttonに、NaviEventを発行するようにセット。
		 * @param button
		 * @param path
		 * 
		 */
		public static function initButton(button:INaviButton, path:PathId = null):void
		{
			if (buttons[button] != null) return;
			if (path == null && button.pathId == null) return;
			
			path ||= button.pathId;
			var click:Function = function(e:MouseEvent):void
			{
				button.dispatchEvent(new NaviEvent(NaviEvent.NAVI_CLICK, path));
			};
			var rollOver:Function = function(e:MouseEvent):void
			{
				button.dispatchEvent(new NaviEvent(NaviEvent.NAVI_ROLL_OVER, path));
			};
			var rollOut:Function = function(e:MouseEvent):void
			{
				button.dispatchEvent(new NaviEvent(NaviEvent.NAVI_ROLL_OUT, path));
			};
			
			button.addEventListener(MouseEvent.CLICK, click);
			button.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			button.addEventListener(MouseEvent.ROLL_OUT, rollOut);
			
			
			var entry:Object = {
				button:button,
				click:click,
				rollOver:rollOver,
				rollOut:rollOut
			};
			buttons[button] = entry;
		}
		
		/**
		 * 指定buttonのイベントリスナを解除。
		 * @param button
		 * 
		 */
		public static function finButton(button:INaviButton):void
		{
			if (buttons[button] == null) return;
			
			var entry:Object = buttons[button];
			button.removeEventListener(MouseEvent.CLICK, entry.click);
			button.removeEventListener(MouseEvent.ROLL_OVER, entry.rollOver);
			button.removeEventListener(MouseEvent.ROLL_OUT, entry.rollOut);
		}
		
		
		
		
		
		
		
		
	}
}