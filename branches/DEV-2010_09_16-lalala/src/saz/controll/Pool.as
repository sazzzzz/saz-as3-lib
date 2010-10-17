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
		
		protected var $items:Array;
		
		public function Pool(createFnc:Function = null) {
			//atCreate = (null != createFnc) ? createFnc : $atCreate;
			$initHook(createFnc);
			
			if (!$items) $items = new Array();
		}
		
		/**
		 * インスタンスを取得. プールされてれば、プールから取り出す. なければ作る. 
		 * @param	...args	atCreate（＝コンストラクタ）に渡すパラメータ.
		 * @return	インスタンス.
		 */
		public function getItem(...args):Object {
			if ($items.length > 0) {
				return $items.pop();
			}else {
				return atCreate.apply(null, args);
			}
		}
		
		/**
		 * インスタンスを返す.
		 * @param	item	返すインスタンス.
		 */
		public function backItem(item:Object):void {
			if (null == item) throw new ArgumentError("Pool#backItem: null以外を指定してください。");
			$items.push(item);
		}
		
		public function toString():String {
			return String($items);
		}
		
		
		
		protected function $initHook(createFnc:Function = null):void {
			atCreate = (null != createFnc) ? createFnc : $atCreate;
		}
		
		protected function $atCreate(...args):Object {
			return { };
		}
		
		/**
		 * プールされている数.
		 */
		public function get length():uint {
			return $items.length;
		}
		
	}

}