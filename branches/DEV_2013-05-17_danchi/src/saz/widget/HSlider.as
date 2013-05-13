package saz.widget
{
	import flash.display.InteractiveObject;
	
	public class HSlider extends SliderBase
	{
		
		public function HSlider(thumObj:InteractiveObject)
		{
			super(thumObj);
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