package saz.controll {
	/**
	 * インスタンスプール.
	 * @author saz
	 */
	public class Pool {
		
		/**
		 * インスタンス生成用メソッド.
		 */
		public var atCreate:Function;
		
		protected var $args:Array;
		protected var $items:Array;
		
		
		public function Pool(createFnc:Function = null) {
			$initHook(createFnc);
			
			if (!$items) $items = new Array();
		}
		
		/**
		 * インスタンスを取得. プールされてれば、プールから取り出す. なければ作る. 
		 * コンストラクタに引数を渡したい場合は、共通引数argsを指定できる。
		 * @return	インスタンス.
		 */
		public function getItem():* {
			if ($items.length > 0) {
				return $items.pop();
			}else {
				return atCreate.apply(null, $args);
			}
		}
		
		/**
		 * インスタンスを返す.
		 * @param	item	返すインスタンス.
		 */
		public function backItem(item:Object):void {
			if (null == item) throw new ArgumentError("Pool#backItem: null以外を指定してください。");
			$items.push(item);
			$backHook(item);
		}
		
		public function toString():String {
			return String($items);
		}
		
		
		
		protected function $initHook(createFnc:Function = null):void {
			atCreate = (null != createFnc) ? createFnc : $atCreate;
		}
		
		protected function $backHook(item:Object):void {
		}
		
		/**
		 * コンストラクト関数. サブクラスでオーバーライドする用.
		 * @param	...args	共通引数.
		 * @return
		 */
		protected function $atCreate(...args):Object {
			return { };
		}
		
		
		
		
		
		/**
		 * プールされている数.
		 */
		public function get length():uint {
			return $items.length;
		}
		
		/**
		 * コンストラクタに渡す、共通の引数.
		 */
		public function get args():Array { return $args; }
		
		public function set args(value:Array):void {
			$args = value;
		}
		
	}

}