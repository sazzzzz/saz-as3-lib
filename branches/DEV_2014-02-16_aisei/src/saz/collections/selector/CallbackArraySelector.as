package saz.collections.selector
{
	/**
	 * コールバック関数を指定して使うArraySelector。
	 * @author saz
	 * 
	 */
	public class CallbackArraySelector extends ArraySelectorBase
	{
		
		/**
		 * 選択処理を記述するコールバック。
		 */
		public var onSelect:Function;
		
		/**
		 * 非選択処理を記述するコールバック。
		 */
		public var onUnselect:Function;
		
		/**
		 * @copy	ArraySelectorBase#ArraySelectorBase
		 */
		public function CallbackArraySelector(array:Array=null)
		{
			super(array);
			
			onSelect = function(item:Object):void {};
			onUnselect = function(item:Object):void {};
		}
		
		
		/**
		 * @copy	ArraySelectorBase#atSelect
		 */
		override protected function atSelect(item:Object):void
		{
			onSelect(item);
		}
		
		/**
		 * @copy	ArraySelectorBase#atUnselect
		 */
		override protected function atUnselect(item:Object):void
		{
			onUnselect(item);
		}
		
		
	}
}