package saz.collections.selector {
	/**
	 * メソッドを実行するSelector.
	 * @author saz
	 */
	public class ArrayMethodSelector extends ArraySelector{
		
		public var selectMethodName:String;
		public var unselectMethodName:String;
		public var selectMethodArgs:Array;
		public var unselectMethodArgs:Array;
		
		/**
		 * コンストラクタ.
		 * @param	target			対象とするArray.指定しなければ自動的に生成.
		 * @param	selectName		選択時に実行するメソッド名.nullを指定した場合は、選択時に何もしない.
		 * @param	unselectName	非選択時に実行するメソッド名.nullを指定した場合は、非選択時に何もしない.
		 * @param	selectArgs		（オプション）選択時の引数.
		 * @param	unselectArgs	（オプション）非選択時の引数.
		 */
		public function ArrayMethodSelector(target:Array = null, selectName:String = null, unselectName:String = null, selectArgs:Array = null, unselectArgs:Array = null) {
			super(target);
			
			selectMethodName = selectName;
			unselectMethodName = unselectName;
			selectMethodArgs = selectArgs;
			unselectMethodArgs = unselectArgs;
		}
		
		
		/**
		 * atSelectのデフォルト.サブクラス用.
		 * @param	item
		 */
		override protected function $atSelect(item:Object):void {
			if (!selectMethodName) return;
			item[selectMethodName].apply(null, selectMethodArgs);
		}
		
		/**
		 * atUnselectのデフォルト.サブクラス用.
		 * @param	item
		 */
		override protected function $atUnselect(item:Object):void {
			if (!unselectMethodName) return;
			item[unselectMethodName].apply(null, unselectMethodArgs);
		}
		
	}

}