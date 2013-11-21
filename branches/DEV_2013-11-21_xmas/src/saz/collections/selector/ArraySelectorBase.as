package saz.collections.selector {
	
	import saz.collections.enumerator.Enumerable;
	
	/**
	 * Selector基本クラス。サブクラスでatSelect, atUnselectをオーバーライドして使う。単体では動作しない。
	 * @author saz
	 */
	public class ArraySelectorBase {
		
		
		
		/**
		 * 対象アイテムを格納するArray.
		 */
		public function get target():Array
		{
			return _target;
		}
		public function set target(value:Array):void
		{
			_target = value;
			enumerable.setTarget(_target);
		}
		protected var _target:/*Object*/Array;
		
		
		/**
		 * 選択されたアイテムのインデックスを取得します.-1 の値は、アイテムが選択されていないことを示します.
		 */
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		protected var _selectedIndex:int = -1;
		
		
		/**
		 * 選択されたアイテムを取得します.
		 */
		public function get selectedItem():Object
		{
			return target[selectedIndex];
		}
		
		
		
		
		
		/**
		 * targetのEnumerable。
		 * @return 
		 * 
		 */
		protected function get enumerable():Enumerable
		{
			if (_enum == null && target != null) _enum = new Enumerable(target);
			return _enum;
		}
		private var _enum:Enumerable;
		
		
		
		
		
		
		
		
		
		
		
		
		/**
		 * コンストラクタ.
		 * @param array			対象とするArray.
		 * 
		 */
		public function ArraySelectorBase(array:Array = null) {
			if (array != null) target = array;
		}
		
		
		
		
		/**
		 * アイテム指定で選択。
		 * @param item	選択するアイテム。targetに含まれないアイテムを指定すると非選択状態に。
		 * @return 選択したアイテム。
		 * 
		 */
		public function select(item:Object):Object
		{
			return selectAt(target.indexOf(item));
		}
		
		/**
		 * インデックス指定で選択。
		 * @param index	インデックス。範囲外を指定すると非選択状態に。
		 * @return 選択したアイテム。
		 * 
		 */
		public function selectAt(index:int):Object
		{
//			if (index < 0 || target.length <= index) throw new ArgumentError("インデックスが範囲外です。");
			
			// 選択中アイテムがあれば非選択
			if (selectedIndex != -1)
			{
				atUnselect(selectedItem);
				_selectedIndex = -1;
			}
			
			// 指定アイテムがtargetに含まれるかチェック
			if (-1 < index && index < target.length)
			{
				_selectedIndex = index;
				atSelect(target[index]);
				return target[index];
			}
			
			return null;
		}
		
		/**
		 * プロパティ指定で選択。
		 * @param value	値。
		 * @param name	プロパティ名。
		 * @return 選択したアイテム。
		 * 
		 */
		public function selectByProperty(value:Object, name:String = "name"):Object
		{
			return select(enumerable.detect(function(item:Object, index:int):Boolean
			{
				return item[name] == value;
			}));
		}
		
		
		
		/**
		 * target中のすべてのアイテムに非選択処理をする。必要か？
		 * @departed	必要か？
		 */
		public function unselectAll():void
		{
			target.forEach(function(item:Object, index:int, arr:Array):void
			{
				atUnselect(item);
			});
		}
		
		
		/**
		 * すべてのアイテムに対し、強制的にatSelect、atUnselectを発行.
		 * @departed	必要か？
		 */
		public function update():void {
			target.forEach(function(item:Object, index:int, arr:Array):void
			{
				if (_selectedIndex == index)
				{
					atSelect(item);
				}else {
					atUnselect(item);
				}
			});
		}
		
		
		
		
		//--------------------------------------
		// for subclass
		//--------------------------------------
		
		
		
		/**
		 * 選択処理をするメソッド.サブクラス用.
		 * @param	item
		 */
		protected function atSelect(item:Object):void {}
		
		/**
		 * 非選択処理をするメソッド.サブクラス用.
		 * @param	item
		 */
		protected function atUnselect(item:Object):void {}
		
		
		
		
		
		
		
		
	}
	
}