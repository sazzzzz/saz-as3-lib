package saz.collections.selector {
	import saz.util.ArrayUtil;
	/**
	 * Selector基本クラス.
	 * @author saz
	 */
	public class ArraySelector {
		
		/**
		 * アイテムを選択状態にする処理メソッド.
		 */
		public var atSelect:Function;
		/**
		 * アイテムを非選択にする処理メソッド.
		 */
		public var atUnselect:Function;
		
		protected var $targets:/*Object*/Array;
		protected var $selectedIndex:int = -1;
		
		/**
		 * コンストラクタ.
		 * @param	target			対象とするArray.指定しなければ自動的に生成.
		 * @param	selectFnc		atSelectに指定するメソッド.
		 * @param	unselectFnc		atUnselectに指定するメソッド.
		 */
		public function ArraySelector(target:Array = null, selectFnc:Function = null, unselectFnc:Function = null) {
			$targets = (target) ? target : new Array();
			atSelect = (null != selectFnc) ? selectFnc : $atSelect;
			atUnselect = (null != unselectFnc) ? unselectFnc : $atUnselect;
		}
		
		
		/*public function select(item:Object):void {
		}
		
		public function selectByIndex(index:int):void {
			
		}
		
		public function unselect():void {
			
		}
		
		
		private function $selectItem(item:Object):void {
			
		}
		
		private function $unselect(item:Object):void {
			
		}*/
		
		
		/**
		 * すべてのアイテムに対し、強制的にatSelect、atUnselectを発行.
		 */
		public function update():void {
			$targets.forEach(function(item:Object, index:int, arr:Array):void {
				if ($selectedIndex == index) {
					atSelect(item);
				}else {
					atUnselect(item);
				}
			});
		}
		
		
		/**
		 * atSelectのデフォルト.サブクラス用.
		 * @param	item
		 */
		protected function $atSelect(item:Object):void {}
		
		/**
		 * atUnselectのデフォルト.サブクラス用.
		 * @param	item
		 */
		protected function $atUnselect(item:Object):void {}
		
		
		
		
		
		
		/**
		 * 指定されたインデックスに対応したアイテムを返す.
		 * @param	index
		 * @return
		 */
		private function $getItemByIndex(index:int):Object {
			return $targets[index];
		}
		
		
		
		/**
		 * データプロバイダに含まれているアイテムの数を取得します.
		 */
		public function get length():uint {
			return $targets.length;
		}
		
		/**
		 * 対象アイテムを格納するArray.-1 の値は、アイテムが選択されていないことを示します.
		 */
		public function get targets():Array { return $targets; }
		
		public function set targets(value:Array):void {
			$targets = value;
		}
		
		/**
		 * 選択されたアイテムのインデックスを取得または設定します.
		 */
		public function get selectedIndex():int { return $selectedIndex; }
		
		public function set selectedIndex(value:int):void {
			if ($selectedIndex == value) return;
			
			//カレントを、非選択処理
			//atUnselect($getItemByIndex($selectedIndex));
			var currentItem:Object = $getItemByIndex($selectedIndex);
			if (currentItem) atUnselect(currentItem);
			
			$selectedIndex = value;
			
			//指定アイテムを、選択処理
			//atSelect($getItemByIndex(value));
			var newItem:Object = $getItemByIndex(value);
			if (newItem) atSelect(newItem);
		}
		
		/**
		 * 選択されたアイテムを取得または設定します.
		 */
		public function get selectedItem():Object {
			return $getItemByIndex($selectedIndex);
		}
		
		public function set selectedItem(value:Object):void {
			var newIndex:int = ArrayUtil.find($targets, value);
			// $targetsの中に見つからなければ終了.
			if ( -1 == newIndex ) throw ArgumentError("指定したアイテムが、targetsの中に見つかりません。");
			
			selectedIndex = newIndex;
		}
		
		
	}

}