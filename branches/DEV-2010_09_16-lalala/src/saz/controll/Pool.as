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
			atCreate = (null != createFnc) ? createFnc : $atCreate;
			
			if (!$items) $items = new Array();
		}
		
		/**
		 * インスタンスを取得. プールされてれば、プールから取り出す. なければ作る. 
		 * @param	...rest	atCreate（＝コンストラクタ）に渡すパラメータ.
		 * @return	インスタンス.
		 */
		public function getItem(...rest):Object {
			if ($items.length > 0) {
				return $items.pop();
			}else {
				return atCreate.apply(null, rest);
			}
		}
		
		/**
		 * インスタンスを返す.
		 * @param	item	返すインスタンス.
		 */
		public function backItem(item:Object):void {
			$items.push(item);
		}
		
		public function toString():String {
			return String($items);
		}
		
		protected function $atCreate(...rest):Object {
			return { };
		}
		
	}

}