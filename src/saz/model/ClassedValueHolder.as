package saz.model {
	import flash.events.IEventDispatcher;
	/**
	 * 型指定あり値保持クラス.
	 * @author saz
	 */
	//public class ClassedValueHolder extends ValueHolder {
	public class ClassedValueHolder extends ValueHolder implements IValue, IEventDispatcher {
		
		/**
		 * 型として指定されたクラス. 
		 */
		private var _class:Class;
		
		/**
		 * コンストラクタ. 
		 * @param	val	初期値. 
		 * @param	valClass	型として指定するクラス. インスタンスではなく、クラスを指定すること. （String, Booleanなど）
		 * @param	valueName	名前. イベント発行時にWatchEvent.keyとして使われる. 
		 * @example <listing version="3.0" >
		 * var str3:ValueHolder = new ClassedValueHolder("A", String, "str3");
		 * str3.addEventListener(WatchEvent.UPDATE, valOnUpdate);
		 * str3.addEventListener(WatchEvent.CHANGE, valOnChange);
		 * str3.value = "A";
		 * str3.value = "B";
		 * str3.value = 0;			// 型が違います
		 * </listing>
		 */
		public function ClassedValueHolder(val:*, valClass:Class, valueName:String = "") {
			_class = valClass;			// superよりこっちが先
			super(val, valueName);
		}
		
		
		/**
		 * @copy	ValueHolder#get value
		 */
		override public function get value():* {
			return super.value as _class;
		}
		
		/**
		 * @copy	ValueHolder#set value
		 */
		override public function set value(val:*):void {
			if (!(val is _class)) throw new ArgumentError("ClassedValueHolder.value: 型が違います");
			super.value = val;
		}
		
	}

}