package saz.display.navi
{
	import saz.collections.selector.ArraySelectorBase;
	
	/**
	 * IButtonGroup用ArraySelector。
	 * @author saz
	 * 
	 */
	public class NaviSelector extends ArraySelectorBase
	{
		public function NaviSelector(array:Array=null)
		{
			super(array);
		}
		
		/**
		 * @copy	ArraySelectorBase#atSelect
		 */
		override protected function atSelect(item:Object):void
		{
			INaviButton(item).select();
		}
		
		/**
		 * @copy	ArraySelectorBase#atUnselect
		 */
		override protected function atUnselect(item:Object):void
		{
			INaviButton(item).unselect();
		}
		
	}
}