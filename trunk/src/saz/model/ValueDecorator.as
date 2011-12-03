package saz.model {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import saz.events.WatchEvent;
	import saz.util.ObjectUtil;
	
	/**
	 * ValueHolderをdecorateし、主に値変更に対する制限手段を提供する.<br/>
	 * これがDecoratorパターンか. 
	 * @author saz
	 * @see	http://help.adobe.com/ja_JP/AS2LCR/Flash_10.0/help.html?content=00001438.html
	 * @see	http://fumiononaka.com/TechNotes/Flash/FN0310001.html
	 */
	public class ValueDecorator extends EventDispatcher implements IValue, IEventDispatcher {
		
		/**
		 * ウォッチ対象のValueHolderインスタンス. 
		 */
		//public function get target():IValue {
			//return _target;
		//}
		//private var _target:IValue;
		public var target:IValue;
		
		/**
		 * コールバック関数. valueを書き換えようとしたとき呼ばれる. <br/>
		 * 仕様はAS2のObject.watchと同じ. <br/>
		 * function (name:String, oldVal:*, newVal:*, userData:Object):* { return newVal; }
		 */
		public var callback:Function;
		
		/**
		 * ユーザー定義データ. callbackに引数で渡される. 
		 */
		public var data:Object;
		
		
		/* INTERFACE saz.dev.IValue */
		
		/**
		 * 名前. target.nameを返す. 
		 */
		public function get name():String {
			return target.name;
		}
		
		/**
		 * 値を取得する. 
		 */
		public function get value():* {
			return target.value;
		}
		
		/**
		 * 値を設定する. 
		 */
		public function set value(val:*):void {
			target.value = callback(target.name, target.value, val, data);
		}
		
		
		/**
		 * コンストラクタ. 
		 * @param	targetValue	ウォッチ対象のValueHolderインスタンス. 
		 * @param	callbackFnc	コールバック関数.
		 * @param	userData	ユーザー定義データ. 
		 * @example <listing version="3.0" >
		 * var str1:IValue = new ValueHolder("A", "str1");
		 * str1.value = "B";
		 * str1.value = 0;
		 * var w1:ValueDecorator = new ValueDecorator(str1, function(name:String, oldVal:*, newVal:*, userData:Object):* {
		 * 	// Stringだけに制限
		 * 	if (typeof newVal == userData) return newVal;
		 * 	return oldVal;
		 * }, "string");
		 * w1.value = "B";
		 * w1.value = 0;
		 * </listing>
		 */
		public function ValueDecorator(targetValue:IValue, callbackFnc:Function, userData:Object = null) {
			super();
			
			target = targetValue;
			var self:ValueDecorator = this;
			EventDispatcher(target).addEventListener(WatchEvent.UPDATE, function(e:WatchEvent):void {
				self.dispatchEvent(e);
			});
			EventDispatcher(target).addEventListener(WatchEvent.CHANGE, function(e:WatchEvent):void {
				self.dispatchEvent(e);
			});
			callback = callbackFnc;
			if (userData != null) data = userData;
		}
		
		
		
		
		
		
		/* flash.events.EventDispatcher */
		
		override public function toString():String {
			return ObjectUtil.formatToString(this, "ValueDecorator", "value", "name");
		}
		
	}

}