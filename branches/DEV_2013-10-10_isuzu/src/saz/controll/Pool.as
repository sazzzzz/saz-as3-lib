package saz.controll {
	import saz.util.ArrayUtil;
	import saz.util.ObjectUtil;

	/**
	 * インスタンスプール.
	 * @author saz
	 */
	public class Pool {
		
		
		/**
		 * プールされている数.
		 */
		public function get length():uint {
			return _insides.length;
		}
		
		/**
		 * コンストラクタに渡す、共通の引数.
		 */
		public function get params():Array { return _args; }
		
		public function set params(value:Array):void {
			_args = value;
		}
		protected var _args:Array;
		
		
		/**
		 * インスタンス生成用メソッド.
		 */
		public var onCreate:Function;
		
		protected var _insides:Array;
		protected var _outsides:Array;
		
		
		public function Pool(createFnc:Function = null) {
			_insides = [];
			_outsides = [];
			onCreate = (null != createFnc) ? createFnc : createHook;
			
			initHook(createFnc);
		}
		
		//--------------------------------------
		// public
		//--------------------------------------
		
		
		/**
		 * インスタンスを取得. プールされてれば、プールから取り出す. なければ作る. 
		 * コンストラクタに引数を渡したい場合は、共通引数argsを指定できる。
		 * @return	インスタンス.
		 */
		public function getItem():Object {
			if (_insides.length == 0) {
				return addOutside();
			}else {
				return getFromInside();
			}
			__testDuplicates();
		}
		/*public function getItem():* {
			if (_insides.length > 0) {
				return _insides.pop();
			}else {
				return onCreate.apply(null, _args);
			}
		}*/
		
		/**
		 * インスタンスを返す.
		 * @param	item	返すインスタンス.
		 */
		public function backItem(item:Object):void {
			if (null == item) throw new ArgumentError("Pool#backItem: null以外を指定してください。");
			outsideToInside(item);
			backHook(item);
			__testDuplicates();
		}
		/*public function backItem(item:Object):void {
			if (null == item) throw new ArgumentError("Pool#backItem: null以外を指定してください。");
			_insides.push(item);
			backHook(item);
		}*/
		
		
		/**
		 * 強制的に全部回収する. 
		 * 
		 */
		public function backAll():void
		{
			/*_outsides.forEach(function(item:Object, index:int, arr:Array):void
			{
				outsideToInside(item);
			});*/
			var item:Object;
			while(_outsides.length > 0)
			{
				outsideToInside(_outsides[_outsides.length - 1]);
			}
			__testDuplicates();
		}
		
		
		public function toString():String {
			return _insides.join(",") + " | " + _outsides.join(",");
		}
		
		
		//--------------------------------------
		// debug
		//--------------------------------------
		
		
		private function __testDuplicates():void
		{
			var f:Object = ArrayUtil.findDuplicates(_insides, _outsides);
			if (f)
			{
				trace("重複！");
				trace(ObjectUtil.toObjectString(f));
			}
		}
		
		
		//--------------------------------------
		// private
		//--------------------------------------
		
		protected function addOutside():Object
		{
			var res:Object = onCreate.apply(null, _args);
			_outsides.push(res);
			return res;
		}
		
		protected function getFromInside():Object
		{
			return insideToOutside();
		}
		
		protected function insideToOutside():Object
		{
			var res:Object = _insides.pop();
			_outsides.push(res);
			return res;
		}
		
		protected function outsideToInside(item:Object):void
		{
			if (_insides.indexOf(item) > 0) throw new ArgumentError("指定されたアイテムは、すでにbackItem()されています。");
			var index:int = _outsides.indexOf(item);
			if (index < 0) throw new ArgumentError("指定されたアイテムは、管理対象外です。");
			
			// outsideから消す
			ArrayUtil.remove(_outsides, index, 1);
			// insideに追加
			_insides.push(item);
		}
		
		
		//--------------------------------------
		// hook?
		//--------------------------------------
		
		protected function initHook(createFnc:Function = null):void {
		}
		
		protected function backHook(item:Object):void {
		}
		
		/**
		 * コンストラクト関数. サブクラスでオーバーライドする用.
		 * @param	...args	共通引数.
		 * @return
		 */
		protected function createHook(...args):Object {
			return {};
		}
		
	}

}