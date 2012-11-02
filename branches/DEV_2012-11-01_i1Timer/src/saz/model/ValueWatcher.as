package saz.model {
	import flash.events.EventDispatcher;
	import saz.events.WatchEvent;
	/**
	 * ValueHolderをウォッチする. ValueBindingUtil用.
	 * @author saz
	 */
	public class ValueWatcher extends EventDispatcher implements IValue {
		
		
		/* INTERFACE saz.model.IValue */
		
		public function get name():String {
			return _target.name;
		}
		
		public function get value():* {
			return _target.value;
		}
		
		public function set value(val:*):void {
			_target.value = val;
		}
		
		
		
		/* ORIGINAL */
		
		/**
		 * ウォッチ対象のValueHolderインスタンス. 
		 */
		public function get target():IValue {
			return _target;
		}
		
		public function set target(value:IValue):void {
			if (_target && null != _handler) _target.removeEventListener(WatchEvent.UPDATE, _handler);
			_target = value;
			if (_target && null != _handler) _target.addEventListener(WatchEvent.UPDATE, _handler);
		}
		private var _target:IValue;
		
		
		/**
		 * コールバック関数. valueを書き換えようとしたとき呼ばれる. <br/>
		 * 仕様はAS2のObject.watchと同じ. <br/>
		 * function (name:String, oldVal:*, newVal:*, userData:Object):void
		 */
		public function get handler():Function {
			return _handler;
		}
		
		public function set handler(value:Function):void {
			if (_target && null != _handler) _target.removeEventListener(WatchEvent.UPDATE, _handler);
			_handler = value;
			if (_target && null != _handler) _target.addEventListener(WatchEvent.UPDATE, _handler);
		}
		private var _handler:Function;
		
		/**
		 * ユーザー定義データ. callbackに引数で渡される. 
		 */
		public var data:Object;
		
		
		
		
		
		
		
		public function ValueWatcher(targetValue:IValue, changeHandler:Function, userData:Object = null) {
			target = targetValue;
			handler = changeHandler;
			data = userData;
		}
		
	}

}