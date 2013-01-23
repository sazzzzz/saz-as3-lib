package saz.display
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import saz.util.ObjectUtil;
	
	/**
	 * 状態に応じて、各状態用の表示オブジェクトを切り替えるボタン。
	 * @author saz
	 * 
	 */
	public class SymbolButton extends Sprite
	{
		
		protected static const STATE_NORMAL:String = "stateNormal";
		protected static const STATE_HOVER:String = "stateHover";
		protected static const STATE_PRESS:String = "statePress";
		protected static const STATE_DISABLE:String = "stateDisable";
		
		
		/**
		 * 通常時シンボル。
		 */
		public var normal:DisplayObject;
		/**
		 * ホバー時シンボル。
		 */
		public var hover:DisplayObject;
		/**
		 * プレス時シンボル。
		 */
		public var press:DisplayObject;
		
		/**
		 * buttonEnabled=false時シンボル。
		 */
		public var disable:DisplayObject;
		
		
		
		public function get buttonEnabled():Boolean
		{
			return _buttonEnabled;
		}
		public function set buttonEnabled(value:Boolean):void
		{
			_buttonEnabled = value;
			super.mouseEnabled = super.mouseChildren = value;
			
			if (disable)
			{
				_symbolController.setState(value ? STATE_NORMAL : STATE_DISABLE);
				alpha = 1.0;
			}else{
				alpha = value ? 1.0 : 0.5;
			}
		}
		private var _buttonEnabled:Boolean = true;
		
		
		private var _inited:Boolean = false;
		private var _symbolController:SymbolButtonController;
		
		
		public function SymbolButton(initObject:Object=null)
		{
			super();
			
			if (initObject != null) ObjectUtil.setProperties(this, initObject);
			addEventListener(Event.ADDED_TO_STAGE, _added);
		}
		
		
		
		public function init():void
		{
			if (_inited) return;
			_inited = true;
			
			buttonMode = true;
			
			_symbolController = new SymbolButtonController(this);
			if (normal) _symbolController.registState(STATE_NORMAL, normal);
			if (hover) _symbolController.registState(STATE_HOVER, hover);
			if (press) _symbolController.registState(STATE_PRESS, press);
			if (disable) _symbolController.registState(STATE_DISABLE, disable);
			
			_symbolController.attachEvent(this, MouseEvent.MOUSE_DOWN, STATE_PRESS);
			_symbolController.attachEvent(this, MouseEvent.MOUSE_UP, STATE_HOVER);
			_symbolController.attachEvent(this, MouseEvent.ROLL_OVER, STATE_HOVER);
			_symbolController.attachEvent(this, MouseEvent.ROLL_OUT, STATE_NORMAL);
			
			_symbolController.setState(STATE_NORMAL);
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _added);
			
			_symbolController.detachEvent(this, MouseEvent.MOUSE_DOWN, STATE_PRESS);
			_symbolController.detachEvent(this, MouseEvent.MOUSE_UP, STATE_HOVER);
			_symbolController.detachEvent(this, MouseEvent.ROLL_OVER, STATE_HOVER);
			_symbolController.detachEvent(this, MouseEvent.ROLL_OUT, STATE_NORMAL);
		}
		
		
		
		//--------------------------------------
		// listeners
		//--------------------------------------
		
		
		
		protected function _added(event:Event):void
		{
			init();
		}
		
		
	}
}