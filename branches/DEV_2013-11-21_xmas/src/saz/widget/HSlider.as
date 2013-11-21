package saz.widget
{
	import flash.display.InteractiveObject;
	
	public class HSlider extends SliderBase
	{
		
		/**
		 * コンストラクタ。
		 * 
		 * @param thumObj
		 * 
		 * @example The following code shows this function usage:
		 * <listing version="3.0">
		 * var slider = new HSlider(controll.seekThum);
		 * slider.size = 475;
		 * </listing>
		 * 
		 */
		public function HSlider(thumObj:InteractiveObject)
		{
			super(thumObj);
			
			snapInterval = 0;
		}
		
		override protected function getThumPosition():Number
		{
			return thum.x;
		}
		
		override protected function setThumPosition(value:Number):void
		{
			thum.x = value;
		}
		
		override protected function getMousePosition():Number
		{
			return thum.parent.mouseX;
		}
	}
}