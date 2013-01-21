package saz.display
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import saz.util.ObjectUtil;
	
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
			super.mouseEnabled = value;
			
			if (disable)
			{
				_symbolController.setState(STATE_DISABLE);
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
			
			addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			addEventListener(MouseEvent.ROLL_OUT, _rollOut);
			
			_symbolController = new SymbolButtonController(this);
			if (normal) _symbolController.registState(STATE_NORMAL, normal);
			if (hover) _symbolController.registState(STATE_HOVER, hover);
			if (press) _symbolController.registState(STATE_PRESS, press);
			if (disable) _symbolController.registState(STATE_DISABLE, disable);
			
			_symbolController.setState(STATE_NORMAL);
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _added);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			removeEventListener(MouseEvent.ROLL_OVER, _rollOver);
			removeEventListener(MouseEvent.ROLL_OUT, _rollOut);
		}
		
		
		
		//--------------------------------------
		// listeners
		//--------------------------------------
		
		
		
		protected function _added(event:Event):void
		{
			init();
		}
		
		
		protected function _mouseDown(event:MouseEvent):void
		{
			_symbolController.setState(STATE_PRESS);
		}
		
		protected function _mouseUp(event:MouseEvent):void
		{
			_symbolController.setState(STATE_HOVER);
		}
		
		protected function _rollOver(event:MouseEvent):void
		{
			_symbolController.setState(STATE_HOVER);
		}
		
		protected function _rollOut(event:MouseEvent):void
		{
			_symbolController.setState(STATE_NORMAL);
		}
	}
}