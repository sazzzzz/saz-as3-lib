package saz.collections.selector {
	/**
	 * プロパティを変更するSelector.
	 * @author saz
	 */
	public class ArrayPropertySelector extends ArraySelector{
		
		public var propertyName:String;
		public var selectValue:*;
		public var unselectValue:*;
		
		/**
		 * コンストラクタ.
		 * @param	target		対象とするArray.指定しなければ自動的に生成.
		 * @param	name		プロパティ名.
		 * @param	selectVal	選択時に設定する値.
		 * @param	unselectVal	非選択時に設定する値.
		 */
		public function ArrayPropertySelector(target:Array = null, name:String = "visible", selectVal:*= true, unselectVal:*= false) {
			super(target);
			
			propertyName = name;
			selectValue = selectVal;
			unselectValue = unselectVal;
		}
		
		/**
		 * atSelectのデフォルト.サブクラス用.
		 * @param	item
		 */
		override protected function $atSelect(item:Object):void {
			item[propertyName] = selectValue;
		}
		
		/**
		 * atUnselectのデフォルト.サブクラス用.
		 * @param	item
		 */
		override protected function $atUnselect(item:Object):void {
			item[propertyName] = unselectValue;
		}
		
	}

}